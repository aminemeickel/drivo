class Token {
  Token({
    required this.token,
    required this.expiresIn,
    required this.refreshExpiresIn,
    required this.refreshToken,
  }) : savedIn = DateTime.now().toString();
  String token;
  String expiresIn;
  String refreshToken;
  String refreshExpiresIn;
  String savedIn;
  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
        token: json['token'],
        expiresIn: json['token_expires_in'],
        refreshToken: json['refresh_token'],
        refreshExpiresIn: json['refresh_token_expires_in']);
  }

  Map toJson() => {
        'token': token,
        'token_expires_in': expiresIn,
        'refresh_token': refreshToken,
        'refresh_token_expires_in': refreshExpiresIn,
        'savedIn': savedIn
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
