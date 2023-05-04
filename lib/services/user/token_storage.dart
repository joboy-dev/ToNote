import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// THIS CLASS HANDLES TOKEN STORAGE
class TokenStorage {
  // initialize flutter secure storage
  final storage = const FlutterSecureStorage();

  final String userTokenKey = 'user_token';

  /// Function to write token to secure storage
  writeToken({required String token}) async {
    return await storage.write(key: userTokenKey, value: token);
  }

  /// Function to read token from secure storage
  readToken() async {
    return await storage.read(key: userTokenKey);
  }

  /// Function to delete token from secure storage
  deleteToken() async {
    await storage.delete(key: userTokenKey);
  }

  // Function to get current user token
  Future<String?> getToken() async {
    final userToken = await readToken();
    return userToken;
  }
}
