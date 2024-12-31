class TokenRequest {
  final String merchantId;
  final String secureHashValue;
  final String? customerId;

  TokenRequest({
    required this.merchantId,
    required this.secureHashValue,
    required this.customerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'merchantId': merchantId,
      'secureHashValue': secureHashValue,
      'customerId': customerId,
    };
  }

  factory TokenRequest.fromJson(Map<String, dynamic> json) {
    return TokenRequest(
      merchantId: json['merchantId'],
      secureHashValue: json['secureHashValue'],
      customerId: json['customerId'],
    );
  }

  TokenRequest copyWith({
    String? merchantId,
    String? secureHashValue,
    String? customerId,
  }) {
    return TokenRequest(
      merchantId: merchantId ?? this.merchantId,
      secureHashValue: secureHashValue ?? this.secureHashValue,
      customerId: customerId ?? this.customerId,
    );
  }
}
