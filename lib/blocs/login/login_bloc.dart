import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multihabit/blocs/login/login_event.dart';
import 'package:multihabit/blocs/login/login_state.dart';
import 'package:multihabit/models/user_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:email_validator/email_validator.dart';

export 'login_event.dart';
export 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState> {
  UserRepository _userRepository;
  String username = '';
  String password = '';
  bool isUsernameValid = false;
  bool isPasswordValid = false;

  LoginBloc({required UserRepository userRepository})
    : _userRepository = userRepository, super(LoginState.init()) {
      on<UsernameChangedEvent>(_onUsernameChanged, transformer: debounce(const Duration(milliseconds: 500)));
      on<PasswordChangedEvent>(_onPasswordChanged, transformer: debounce(const Duration(milliseconds: 500)));
      on<SubmitEvent>(_onSubmit, transformer: debounce(const Duration(milliseconds: 500)));
    }

  EventTransformer<LoginEvent> debounce<LoginEvent>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }

  FutureOr<void> _onPasswordChanged(PasswordChangedEvent event, Emitter<LoginState> emit) {
    if (event.password != null) {
      password = event.password!;
      if (password.isNotEmpty) {
        emit(state.updatePassword(isPasswordValid: true, isPasswordEmpty: false));
      } else {
        emit(state.updatePassword(isPasswordValid: false, isPasswordEmpty: true));
      }
    }
  }

  FutureOr<void> _onUsernameChanged(UsernameChangedEvent event, Emitter<LoginState> emit) {
    if (event.username != null && event.username!.isNotEmpty) {
      username = event.username!;
      if(RegExp(r"@").hasMatch(username)) {
        isUsernameValid = EmailValidator.validate(username);
        if (!isUsernameValid) {
          emit(state.updateUsername(isUsernameValid: false, isUsernameEmpty: false));
        }
      } else if (RegExp(r"[^a-zA-Z0-9_\.\-]").hasMatch(username)) {
        emit(state.updateUsername(isUsernameValid: false, isUsernameEmpty: false));
      } else {
        emit(state.updateUsername(isUsernameValid: true, isUsernameEmpty: false));
      }
    } else {
      emit(state.updateUsername(isUsernameValid: false, isUsernameEmpty: true));
    }
  } 

  FutureOr<void> _onSubmit(SubmitEvent event, Emitter<LoginState> emit) async {
    emit(state.submitting());
    try {
      UserRepository signIn = await _userRepository.signIn(username: event.username!, password: event.password!);
      if (signIn.isSignedIn) {
        emit(state.success());
      } else {
        emit(state.failure());
      }
    } catch (_) {
      emit(state.failure());
    }
  }
}
