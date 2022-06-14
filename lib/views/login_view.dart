import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multihabit/blocs/auth/auth_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  AuthBloc? _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc,AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          Navigator.of(context, rootNavigator: true).pop();
          _authBloc!.add(AuthenticatedEvent());
          Navigator.of(context).pop("fromLogin");
        }

        if (state is AuthBusyState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ]
                )
              );
            }
          );
        }

        if (state is AuthFailureState) {
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: ElevatedButton(
              child: const Text("Login/Register"),
              onPressed: () {
                _authBloc?.add(AuthRequestEvent());
              },
            )
          ),
        );
      }
    );
  }
}
