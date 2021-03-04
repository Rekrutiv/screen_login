import 'package:chigago_login/config/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
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
          body: Column(
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
    );
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
                Icons.mail_outline, "Адрес электронной почты", false, true),
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
            buildTextField(
                MaterialCommunityIcons.email_outline, "Почта", false, true),
            buildTextField(
                MaterialCommunityIcons.lock_outline, "Пароль", true, false),
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
