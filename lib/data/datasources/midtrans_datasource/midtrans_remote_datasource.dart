import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:movie_mate/core/variables/variable.dart';
import 'package:movie_mate/data/model/response/qris_response_model.dart';

import '../../model/response/qris_status_response_model.dart';

abstract class MidtransRemoteDatasource {
  String generateBasicAuthHeader(String serverKey);
  Future<QrisResponseModel> generateQrCode(String orderId, int grossAmount);
  Future<QrisStatusResponseModel> checkPaymentStatus(String orderId);
}

class MidtransRemoteDatasourceImpl implements MidtransRemoteDatasource {
  final http.Client _client;

  MidtransRemoteDatasourceImpl({required http.Client client})
      : _client = client;

  @override
  String generateBasicAuthHeader(String serverKey) {
    final base64Credentials = base64Encode(utf8.encode('$serverKey:'));
    final authHeader = 'Basic $base64Credentials';

    return authHeader;
  }

  @override
  Future<QrisStatusResponseModel> checkPaymentStatus(String orderId) async {
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
      return QrisStatusResponseModel.fromJson(response.body);
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

  factory MidtransRemoteDatasourceImpl.create() {
    return MidtransRemoteDatasourceImpl(
      client: http.Client(),
    );
  }
}
