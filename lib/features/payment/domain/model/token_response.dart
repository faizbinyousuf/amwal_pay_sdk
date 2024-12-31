class TokenResponse {
  final String sessionToken;

  TokenResponse({
    required this.sessionToken,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      sessionToken: json['sessionToken'],
    );
  }
}
