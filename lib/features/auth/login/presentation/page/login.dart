import 'package:chatapp/core/utils/screensize.dart';
import 'package:chatapp/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:chatapp/features/auth/login/presentation/bloc/login_event.dart';
import 'package:chatapp/features/auth/login/presentation/bloc/login_state.dart';
import 'package:chatapp/features/auth/signup/presentation/page/signup.dart';
import 'package:chatapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:chatapp/features/home/presentation/bloc/home_event.dart';
import 'package:chatapp/features/home/presentation/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _visible = true;
  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoginErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error.toString())));
        }
        if (state is LoginSuccesState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false);

          context.read<HomeBloc>().add(HomeLoadDataEvent());
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Login"),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              _usernamefield(),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              _passwordfilds(),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              _textnoaccount(),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              _btnlogin()
            ],
          ),
        ),
      ),
    );
  }

  _usernamefield() {
    return SizedBox(
      width: displayWidth(context) * 0.9,
      height: displayHeight(context) * 0.06,
      child: TextField(
        controller: _username,
        cursorColor: Colors.black,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
            hintText: 'Username',
            hintStyle: const TextStyle(color: Colors.black),
            // border: ,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            filled: true,
            contentPadding: const EdgeInsets.all(20),
            fillColor: Colors.grey.withOpacity(0.4)),
      ),
    );
  }

  _passwordfilds() {
    return SizedBox(
      width: displayWidth(context) * 0.9,
      height: displayHeight(context) * 0.06,
      child: TextField(
        obscureText: _visible,
        controller: _password,
        cursorColor: Colors.black,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: _visible
                  ? const Icon(
                      Icons.visibility_off,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.visibility,
                      color: Colors.black,
                    ),
              onPressed: () {
                setState(() {
                  _visible = !_visible;
                });
              },
            ),
            hintText: "Password",
            hintStyle: const TextStyle(color: Colors.black),
            // border: ,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            filled: true,
            contentPadding: const EdgeInsets.all(20),
            fillColor: Colors.grey.withOpacity(0.4)),
      ),
    );
  }

  _textnoaccount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignupPage(),
                  ));
            },
            child: const Text(
              "Dont Have Account?",
              textAlign: TextAlign.start,
            )),
      ],
    );
  }

  _btnlogin() {
    return ElevatedButton(
      onPressed: () {
        //  sl.get<LoginBloc>().add(
        //     LoginSuccesEvent( _username.text, _password.text));
        context
            .read<LoginBloc>()
            .add(LoginSuccesEvent(_username.text, _password.text));
      },
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          backgroundColor: Colors.black,
          minimumSize:
              Size(displayWidth(context) * 0.9, displayWidth(context) * 0.12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 0),
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
