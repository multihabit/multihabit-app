import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multihabit/blocs/auth/auth_bloc.dart';
import 'package:multihabit/blocs/login/login_bloc.dart';
import 'package:multihabit/models/user_repository.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(userRepository: context.read<UserRepository>()),
      child: Scaffold(
        body: LoginForm(),
      )
      );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc? _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _usernameController.addListener(_onUsernameChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc,LoginState>(
      listener: (context, state) {

        if (state.isSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          BlocProvider.of<AuthBloc>(context).add(AuthenticatedEvent());
          Navigator.of(context).pop("fromLogin");
        }

        if (state.isSubmitting) {
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

        if (state.isFailure) {
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
      builder: (context, state) {
        return Center(
          child: FractionallySizedBox(
            widthFactor: 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _usernameController,
                  key: const Key("loginUsernameField"),
                  decoration: const InputDecoration(
                    hintText: "Enter your username or e-mail address",
                    labelText: "Username or E-mail",
                  ),
                ),
                if (!state.isUsernameValid && !state.isUsernameEmpty)
                  const Text("Invalid Username!"),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  key: const Key("loginPasswordField"),
                  decoration: const InputDecoration(
                    hintText: "Enter your password",
                    labelText: "Password"
                  ),
                ),
                if (!state.isPasswordValid && state.isPasswordEmpty && !state.isUsernameEmpty)
                  const Text("Invalid Password!"),
                ElevatedButton(
                  onPressed: () {
                    _loginBloc?.add(SubmitEvent(
                      username: _usernameController.text,
                      password: _passwordController.text,
                    ));
                  }, 
                  child: const Text("Login"),
                ),
              ]
            ),
          )
        );
      }
    );
  }

  void _onUsernameChanged() {
    _loginBloc?.add(UsernameChangedEvent(username: _usernameController.text));
  }

  void _onPasswordChanged() {
    _loginBloc?.add(PasswordChangedEvent(password: _passwordController.text));
  }
}
