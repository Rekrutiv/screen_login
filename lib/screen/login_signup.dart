import 'package:chigago_login/bloc_form/my_form_bloc.dart';
import 'package:chigago_login/config/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:formz/formz.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<MyFormBloc>().add(EmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<MyFormBloc>().add(PasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        backgroundColor: Palette.backgroundColor,
        body: BlocListener<MyFormBloc, MyFormState>(
          listener: (context, state) {
            if (state.status.isSubmissionInProgress) {
              Scaffold.of(context).hideCurrentSnackBar();
              showDialog<void>(
                context: context,
                builder: (_) => SuccessDialog(),
              );
            }
            if (state.status.isSubmissionInProgress) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('Submitting...')),
                );
            }
          },
          child: Column(
            children: <Widget>[
              // construct the profile details widget here
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: size.height * 0.4,
                    decoration: BoxDecoration(
                      color: Palette.COLOR_WHITE,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Center(
                      child: Container(
                          height: size.height * 0.2,
                          decoration: BoxDecoration(
                              color: Palette.COLOR_WHITE,
                              image: DecorationImage(
                                  image: AssetImage("images/logo.png"),
                                  fit: BoxFit.contain))),
                    ),
                  ), // the tab bar with two items
                  SizedBox(
                    height: size.height * 0.09,
                    child: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      bottom: TabBar(
                        labelColor: Palette.facebookColor,
                        tabs: [
                          Tab(
                            text: "Войти",
                          ),
                          Tab(
                            text: "Зарегистрироваться",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // create widgets for each tab bar here
              Expanded(
                child: TabBarView(
                  children: [
                    // first tab bar view widget
                    buildSigninSection(),

                    // second tab bar viiew widget
                    buildSignupSection(),
                  ],
                ),
              ),
            ],
            // Trick to add the submit button
          ),
        ),
      ),
    ));
  }

  Container buildSigninSection() {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildTextField(
                MaterialCommunityIcons.email_outline, "Почта", false, true),
            buildTextField(
                MaterialCommunityIcons.lock_outline, "Пароль", true, false),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text("Забыли пароль?",
                      style: themeData.textTheme.bodyText1),
                )
              ],
            ),
            buildTextButton("Войти", Palette.googleColor)
          ],
        ),
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildTextField(
                MaterialCommunityIcons.account_outline, "Имя", false, false),
            EmailInput(focusNode: _emailFocusNode),
            PasswordInput(focusNode: _passwordFocusNode),
            Container(
              width: 200,
              margin: EdgeInsets.only(top: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Уже зарегистрированы? ",
                    style: TextStyle(color: Palette.textColor2),
                    children: [
                      TextSpan(
                        //recognizer: ,
                        text: "Вход",
                        style: TextStyle(
                          color: Palette.googleColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ]),
              ),
            ),
            SizedBox(height: 7),
            buildTextButton("Зарегистрироваться", Palette.googleColor)
          ],
        ),
      ),
    );
  }

  TextButton buildTextButton(String title, Color backgroundColor) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(width: 1, color: Palette.googleColor),
        minimumSize: Size(250, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          // side: BorderSide(color: Colors.red)
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(color: Palette.COLOR_WHITE),
      ),
    );
  }

  Widget buildTextField(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    final ThemeData themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Palette.iconColor,
          ),
//          enabledBorder: OutlineInputBorder(
//            borderSide: BorderSide(color: Palette.textColor1),
//            borderRadius: BorderRadius.all(Radius.circular(35.0)),
//          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
//            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: themeData.textTheme.subtitle1,
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key key, this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFormBloc, MyFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.email),
            labelText: 'Email',
            helperText: 'A complete, valid email e.g. joe@gmail.com',
            errorText: state.email.invalid
                ? 'Please ensure the email entered is valid'
                : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context.read<MyFormBloc>().add(EmailChanged(email: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key key, this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFormBloc, MyFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.lock),
            helperText:
                '''Password should be at least 8 characters with at least one letter and number''',
            helperMaxLines: 2,
            labelText: 'Password',
            errorMaxLines: 2,
            errorText: state.password.invalid
                ? '''Password must be at least 8 characters and contain at least one letter and number'''
                : null,
          ),
          obscureText: true,
          onChanged: (value) {
            context.read<MyFormBloc>().add(PasswordChanged(password: value));
          },
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Icon(Icons.info),
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Submitted Successfully!',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            RaisedButton(
              child: const Text('OK'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              onPressed: () => Navigator.of(context).pushNamed(
                '/home',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
