import 'dart:convert';

class BankTransferResponseModel {
  final String? statusCode;
  final String? statusMessage;
  final String? transactionId;
  final String? orderId;
  final String? merchantId;
  final String? grossAmount;
  final String? currency;
  final String? paymentType;
  final DateTime? transactionTime;
  final String? transactionStatus;
  final String? fraudStatus;
  final String? acquirer;
  final List<BankAction>? actions;

  BankTransferResponseModel({
    this.statusCode,
    this.statusMessage,
    this.transactionId,
    this.orderId,
    this.merchantId,
    this.grossAmount,
    this.currency,
    this.paymentType,
    this.transactionTime,
    this.transactionStatus,
    this.fraudStatus,
    this.acquirer,
    this.actions,
  });

  factory BankTransferResponseModel.fromJson(String str) =>
      BankTransferResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BankTransferResponseModel.fromMap(Map<String, dynamic> json) =>
      BankTransferResponseModel(
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        transactionId: json["transaction_id"],
        orderId: json["order_id"],
        merchantId: json["merchant_id"],
        grossAmount: json["gross_amount"],
        currency: json["currency"],
        paymentType: json["payment_type"],
        transactionTime: json["transaction_time"] == null
            ? null
            : DateTime.parse(json["transaction_time"]),
        transactionStatus: json["transaction_status"],
        fraudStatus: json["fraud_status"],
        acquirer: json["acquirer"],
        actions: json["actions"] == null
            ? []
            : List<BankAction>.from(
                json["actions"]!.map((x) => BankAction.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status_code": statusCode,
        "status_message": statusMessage,
        "transaction_id": transactionId,
        "order_id": orderId,
        "merchant_id": merchantId,
        "gross_amount": grossAmount,
        "currency": currency,
        "payment_type": paymentType,
        "transaction_time": transactionTime?.toIso8601String(),
        "transaction_status": transactionStatus,
        "fraud_status": fraudStatus,
        "acquirer": acquirer,
        "actions": actions == null
            ? []
            : List<dynamic>.from(actions!.map((x) => x.toMap())),
      };
}

class BankAction {
  final String? name;
  final String? method;
  final String? url;

  BankAction({
    this.name,
    this.method,
    this.url,
  });

  factory BankAction.fromJson(String str) =>
      BankAction.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BankAction.fromMap(Map<String, dynamic> json) => BankAction(
        name: json["name"],
        method: json["method"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "method": method,
        "url": url,
      };
}
