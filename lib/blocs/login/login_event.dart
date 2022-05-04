abstract class LoginEvent {
  String? username;
  String? password;

  LoginEvent({this.username, this.password});
}

class SubmitEvent extends LoginEvent {
  SubmitEvent({required String username, required String password}) : super(username: username, password: password);
}

class UsernameChangedEvent extends LoginEvent {
  UsernameChangedEvent({required String username}) : super(username: username);
}

class PasswordChangedEvent extends LoginEvent {
  PasswordChangedEvent({required String password}) : super(password: password);
}
