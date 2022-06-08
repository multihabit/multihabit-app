import 'package:multihabit/models/user_repository.dart';

import 'dart:convert';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class Auth0Repository extends UserRepository {

  final auth0Domain= "multihabit.us.auth0.com";
  final auth0ClientID = "c70qgMzmoXQnuI5dd7A8btLlGKVZPToc";

  final auth0RedirectURI = "com.multihabit.multihabit://login-callback";
  final auth0Issuer = "https://multihabit.us.auth0.com";

  final FlutterAppAuth appAuth = const FlutterAppAuth();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Future<UserRepository> signIn() async {
    try {
      final AuthorizationTokenResponse? result = await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          auth0ClientID,
          auth0RedirectURI,
          issuer: auth0Issuer,
          scopes: ['openid', 'profile', 'offline_access'],
        )
      );

      if (result == null) return Future.error("Unable to sign in");

      idToken = parseIdToken(result.idToken!);
      userDetails = await getUserDetails(result.accessToken!);

      await secureStorage.write(key: "refresh_token", value: result.refreshToken!);

      return this;
    } catch (_) {
      return Future.error("Unable to sign in");
    }
  }

  @override
  Future<Map<String,dynamic>> getUserDetails(String accessToken) async {
    final Uri url = Uri(path: "https://$auth0Domain/userinfo");
    final http.Response response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'}
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to get User Details");
    }
  }

  Map<String,dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
      utf8.decode(base64Url.decode(base64Url.normalize(parts[1])))
    );
  }
}
