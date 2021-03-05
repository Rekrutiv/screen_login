import 'package:chigago_login/screen/login_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_form/my_form_bloc.dart';


void main() {
  runApp(LoginSignupUI());
}

class LoginSignupUI extends StatelessWidget {
  const LoginSignupUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login Signup UI",
      home:  BlocProvider(
        create: (_) => MyFormBloc(),
    child:LoginSignupScreen(),),
    );
  }
}
