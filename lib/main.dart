import 'package:chatapp/core/utils/injection.dart';
import 'package:chatapp/core/utils/socket.dart';
import 'package:chatapp/features/auth/bloc/auth_bloc.dart';
import 'package:chatapp/features/auth/bloc/auth_event.dart';
import 'package:chatapp/features/auth/bloc/auth_state.dart';
import 'package:chatapp/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:chatapp/features/auth/login/presentation/page/login.dart';
import 'package:chatapp/features/auth/signup/presentation/bloc/signup_bloc.dart';
import 'package:chatapp/features/chat/presentation/bloc/getChat/getchat_bloc.dart';
import 'package:chatapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:chatapp/features/home/presentation/bloc/home_event.dart';
import 'package:chatapp/features/home/presentation/page/home.dart';
import 'package:chatapp/features/search/presentation/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final socket = Socket();
  socket.connecttoSocket();
  setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl.get<LoginBloc>(),
          ),
          BlocProvider(
            create: (context) => sl.get<SignupBloc>(),
          ),
          BlocProvider(
            create: (context) =>
                sl.get<AuthenticationBloc>()..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) => sl.get<HomeBloc>()..add(HomeLoadDataEvent()),
          ),
          BlocProvider(
            create: (context) => sl.get<GetchatBloc>(),
          ),
          BlocProvider(
            create: (context) => sl.get<SearchBloc>(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is AuthenticationAuthenticated) {
                return const HomePage();
              }
              if (state is AuthenticationUnauthenticated) {
                return const LoginPage();
              }
              return Container();
            },
          ),
        ));
  }
}
