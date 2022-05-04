class UserRepository {
  String? _userID;

  Future<UserRepository> signIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 3), () {
      if ( username != "test" || password != "test") throw Exception("Incorrect login credentials provided.");
    
      _userID = username;
    });
    return Future.value(this);
  }

  Future<UserRepository> signOut() {
    _userID = null;
    return Future.value(this);
  }

  bool get isSignedIn => _userID != null && _userID!.isNotEmpty;
}
