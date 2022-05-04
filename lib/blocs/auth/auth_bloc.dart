import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multihabit/models/user_repository.dart';

import 'auth_state.dart';
import 'auth_event.dart';

export 'auth_state.dart';
export 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository _userRepository;

  AuthBloc({required UserRepository userRepository}) 
    : _userRepository = userRepository, super(UninitializedState()) {
    on<AppStartedEvent>((event, emit) {
      if (_userRepository.isSignedIn) { 
        emit(AuthenticatedState()); 
      } else {
        emit(UnauthenticatedState());
      }
    });
    on<AuthenticatedEvent>((event, emit) { emit(AuthenticatedState()); });
  }

}
