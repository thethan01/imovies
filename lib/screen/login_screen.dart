import 'package:imovies/constant.dart';
import 'package:imovies/screen/get_started.dart';
import 'package:imovies/screen/home_screen.dart';
// import 'package:imovies/screen/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imovies/screen/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const String id = "SigIn_screen";
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 25, top: 10),
                  onPressed: () {
                    Navigator.pushNamed(context, GetStarted.id);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ), // back button, appbar
              const Text(
                "Welcome Back!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ), //Text Wellcome Back!
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    "assets/images/fb.svg",
                    width: MediaQuery.of(context).size.width - 30,
                  ),
                ),
              ), // Login with Facebook button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    "assets/images/gg.svg",
                    width: MediaQuery.of(context).size.width - 30,
                  ),
                ),
              ), // Login with GG button
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 35),
                child: Text('OR LOG IN WITH EMAIL',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ), // Text LOG IN WITH EMAIL
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                child: TextField(

                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.white)),
                    hintText: 'Email address',
                    hintStyle: const TextStyle(color: kDarkColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ), // TextField Email
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.white)),
                    hintStyle: const TextStyle(color: kDarkColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ), //TextField Password
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width - 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kDarkColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.id);
                  },
                  child: const Text(
                    'SIGN IN',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),// Sign In button
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 20),
                child: RichText(
                    text: TextSpan(
                        text: 'Forgot Password?',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigator.pushNamed(context, ForgotPassword.id);
                          })),
              ),// Forgot Password
              RichText(
                text: TextSpan(
                    text: 'Don\'t have account?',
                    style:
                        const TextStyle(color: Colors.white, fontSize: 14),
                    children: [
                      TextSpan(
                          text: ' Sign up',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, SignUp.id);
                            })
                    ]),
              )// Sign Up
            ],
          ),
        ),
      ),
    );
  }
}
