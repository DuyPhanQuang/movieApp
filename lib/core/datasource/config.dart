import '../entity/entity.dart';

enum ApiHeaderType { normal, withToken, withoutToken }

class Authorization extends BaseEntity {
  final String? accessToken;
  final String? refreshToken;

  Authorization({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Authorization.fromJson(Map<String, dynamic> json) {
    return Authorization(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
  ];

  @override
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}

class HeaderConfig {
  final String encodedCredentials;
  final String refreshTokenPath;
  HeaderConfig({
    required this.encodedCredentials,
    required this.refreshTokenPath,
  });
}
