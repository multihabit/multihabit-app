abstract class UserRepository {
  String? accessToken;
  Map<String,dynamic> userDetails = {};
  Map<String,dynamic> idToken = {};

  bool get isSignedIn => accessToken != null && userDetails.isNotEmpty && idToken.isNotEmpty;

  Future<void> signIn() async {}
  Future<void> signOut() async {}
  Future<Map<String,dynamic>> getUserDetails(String accessToken) async => <String,dynamic>{};
}
