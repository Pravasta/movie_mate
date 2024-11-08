import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:movie_mate/core/variables/variable.dart';
import 'package:movie_mate/data/model/response/bank_transfer_response_model.dart';
import 'package:movie_mate/data/model/response/qris_response_model.dart';

import '../../model/response/payment_status_response_model.dart';

abstract class PaymentRemoteDatasource {
  String generateBasicAuthHeader(String serverKey);
  Future<QrisResponseModel> generateQrCode(String orderId, int grossAmount);
  Future<PaymentStatusResponseModel> checkPaymentStatus(String orderId);
  Future<BankTransferResponseModel> transferPayment(
      String orderId, int grossAmount, String bank);
}

class PaymentRemoteDatasourceImpl implements PaymentRemoteDatasource {
  final http.Client _client;

  PaymentRemoteDatasourceImpl({required http.Client client}) : _client = client;

  @override
  String generateBasicAuthHeader(String serverKey) {
    final base64Credentials = base64Encode(utf8.encode('$serverKey:'));
    final authHeader = 'Basic $base64Credentials';

    return authHeader;
  }

  @override
  Future<PaymentStatusResponseModel> checkPaymentStatus(String orderId) async {
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": generateBasicAuthHeader(Variable.serverKey),
    };
    final response = await _client.get(
      Uri.parse("${Variable.baseQrisUrl}/v2/$orderId/status"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return PaymentStatusResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to check payment method');
    }
  }

  @override
  Future<QrisResponseModel> generateQrCode(
      String orderId, int grossAmount) async {
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": generateBasicAuthHeader(Variable.serverKey),
    };

    final body = jsonEncode({
      "payment_type": "gopay",
      "transaction_details": {
        "order_id": orderId,
        "gross_amount": grossAmount,
      }
    });

    final response = await _client.post(
      Uri.parse('${Variable.baseQrisUrl}/v2/charge'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return QrisResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to generate QR Code');
    }
  }

  @override
  Future<BankTransferResponseModel> transferPayment(
      String orderId, int grossAmount, String bank) async {
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": generateBasicAuthHeader(Variable.serverKey),
    };

    final body = jsonEncode({
      "payment_type": "bank_transfer",
      "transaction_details": {
        "order_id": orderId,
        "gross_amount": grossAmount,
      },
      "bank_transfer": {
        "bank": bank,
      }
    });

    final response = await _client.post(
      Uri.parse('${Variable.baseQrisUrl}/v2/charge'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 201) {
      return BankTransferResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to Payment');
    }
  }

  factory PaymentRemoteDatasourceImpl.create() {
    return PaymentRemoteDatasourceImpl(
      client: http.Client(),
    );
  }
}
