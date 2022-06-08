abstract class UserRepository {
  String? accessToken;
  Map<String,dynamic> userDetails = {};
  Map<String,dynamic> idToken = {};

  bool get isSignedIn => accessToken != null && userDetails.isNotEmpty && idToken.isNotEmpty;

  Future<UserRepository> signIn() async => this;
  Future<void> signOut() async {}
  Future<Map<String,dynamic>> getUserDetails(String accessToken) async => <String,dynamic>{};
}
