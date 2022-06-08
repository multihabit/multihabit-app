import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multihabit/blocs/auth/auth_bloc.dart';
import 'package:multihabit/blocs/router/router_cubit.dart';
import 'package:multihabit/blocs/simple_bloc_delegate.dart';
import 'package:multihabit/models/auth0_repository.dart';
import 'package:multihabit/models/router_delegate.dart';
import 'package:multihabit/models/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: SimpleBlocDelegate()
  );
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final UserRepository _userRepository = Auth0Repository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RouterCubit()),
        BlocProvider(create: (context) => AuthBloc(userRepository: _userRepository)),
      ],
      child: RepositoryProvider(
        create: (context) => _userRepository,
        child: MaterialApp(
          home: BlocBuilder<RouterCubit,RouterState>(
            builder: (context, state) {
              return Router(
                routerDelegate: RootRouterDelegate(
                  navigatorKey: navigatorKey,
                  cubit: BlocProvider.of<RouterCubit>(context)
                ),
                backButtonDispatcher: RootBackButtonDispatcher(),
              );
            },)
        ),
      ),
    );
  }
}
