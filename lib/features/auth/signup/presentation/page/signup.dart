
import 'package:chatapp/core/utils/screensize.dart';
import 'package:chatapp/features/auth/signup/presentation/bloc/signup_bloc.dart';
import 'package:chatapp/features/auth/signup/presentation/bloc/signup_event.dart';
import 'package:chatapp/features/auth/signup/presentation/bloc/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  bool _visible = true;
  String? selected;
  List<String> dataDropDown = ["Male", "Female"];
  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _confirmpassword.dispose();
    _visible;

    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
       
        if (state is SignupSuccesState) {
          Navigator.pop(context);
        }
        if (state is SignupErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.msg)));
          // err = state.msg;
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Signup"),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              _usernamefield(),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              _passwordfilds(_password, "Password"),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              _passwordfilds(_confirmpassword, "Confirm Password"),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              _dropDown(),
              SizedBox(
                height: displayHeight(context) * 0.02,
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

  _passwordfilds(TextEditingController controller, String hint) {
    return SizedBox(
      width: displayWidth(context) * 0.9,
      height: displayHeight(context) * 0.06,
      child: TextField(
        obscureText: _visible,
        controller: controller,
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
            hintText: hint,
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

  _dropDown() {
    return DropdownButton(
      hint:const Text("Gender"),
      value: selected,
      onChanged: (value) {
        setState(() {
          selected = value!;
        });
      },
      items: dataDropDown
          .map(
            (e) => DropdownMenuItem(value: e, child: Text(e)),
          )
          .toList(),
    );
  }

  _btnlogin() {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<SignupBloc>(context).add(SignupDataEvent(
            username: _username.text,
            password: _password.text,
            confirmPassword: _confirmpassword.text,
            gender: selected.toString()));
        // sl.get<SignupBloc>().add(SignupDataEvent(
        //     username: _username.text,
        //     password: _password.text,
        //     confirmPassword: _confirmpassword.text,
        //     gender: selected.toString()));
      },
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          backgroundColor: Colors.black,
          minimumSize:
              Size(displayWidth(context) * 0.9, displayWidth(context) * 0.12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 0),
      child: const Text(
        'Signup',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
