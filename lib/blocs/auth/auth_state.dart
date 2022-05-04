import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticatedState extends AuthState {}
class UnauthenticatedState extends AuthState {}
class UninitializedState extends AuthState {}
