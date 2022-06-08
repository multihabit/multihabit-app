import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticatedState extends AuthState {}
class AuthBusyState extends AuthState {}
class AuthSuccessState extends AuthState {}

class AuthFailureState extends AuthState {
  final String errorMessage;
  AuthFailureState(this.errorMessage);
}

class UnauthenticatedState extends AuthState {}
class UninitializedState extends AuthState {}
