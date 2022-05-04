import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isUsernameValid;
  final bool isPasswordValid;
  final bool isUsernameEmpty;
  final bool isPasswordEmpty;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const LoginState({
    required this.isUsernameValid,
    required this.isPasswordValid,
    required this.isUsernameEmpty,
    required this.isPasswordEmpty,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory LoginState.init() {
    return const LoginState(
      isUsernameValid: false,
      isUsernameEmpty: true,
      isPasswordValid: false,
      isPasswordEmpty: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.submitting() {
    return const LoginState(
      isUsernameValid: true,
      isUsernameEmpty: false,
      isPasswordValid: true,
      isPasswordEmpty: false,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.success() {
    return const LoginState(
      isUsernameValid: true,
      isUsernameEmpty: false,
      isPasswordValid: true,
      isPasswordEmpty: false,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  factory LoginState.failure() {
    return const LoginState(
      isUsernameValid: true,
      isUsernameEmpty: false,
      isPasswordValid: true,
      isPasswordEmpty: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  LoginState copyWith({
    bool? isUsernameValid,
    bool? isUsernameEmpty,
    bool? isPasswordValid,
    bool? isPasswordEmpty,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return LoginState(
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isUsernameEmpty: isUsernameEmpty ?? this.isUsernameEmpty,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isPasswordEmpty: isPasswordEmpty ?? this.isPasswordEmpty,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  LoginState updateUsername({
    bool? isUsernameValid,
    bool? isUsernameEmpty
  }) {
    return copyWith(
      isUsernameValid: isUsernameValid,
      isUsernameEmpty: isUsernameEmpty,
    );
  }

  LoginState updatePassword({
    bool? isPasswordValid,
    bool? isPasswordEmpty,
  }) {
    return copyWith(
      isPasswordValid: isPasswordValid,
      isPasswordEmpty: isPasswordEmpty
    );
  }

  LoginState submitting() {
    return copyWith(
      isSuccess: false,
      isFailure: false,
      isSubmitting: true,
    );
  }

  LoginState success() {
    return copyWith(
      isSuccess: true,
      isFailure: false,
      isSubmitting: false,
    );
  }

  LoginState failure() {
    return copyWith(
      isSuccess: false,
      isFailure: true,
      isSubmitting: false,
    );
  }

  bool get isEmpty => isUsernameEmpty && isPasswordEmpty;

  @override
  String toString() {
    return '''LoginState {
      isUsernameValid: $isUsernameValid,
      isUsernameEmpty: $isUsernameEmpty,
      isPasswordValid: $isPasswordValid,
      isPasswordEmpty: $isPasswordEmpty,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isEmpty: $isEmpty
    }
    ''';
  }

  @override
  List<Object> get props => [
    isUsernameValid,
    isUsernameEmpty,
    isPasswordValid,
    isPasswordEmpty,
    isSubmitting,
    isSuccess,
    isFailure,
    isEmpty
  ];
}
