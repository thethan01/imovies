import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imovies/constant.dart';
import 'package:imovies/screen/login_screen.dart';
import 'package:imovies/screen/sign_up.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);
  static const String id = "GetStarted_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/4.5),
                child: Center(
                    child: SvgPicture.asset("assets/images/gst2.svg")),
              ),
              const Text(
                'Movie App',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: kTextDarkColor),
              ),
              // buttonSignup(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: SizedBox(
                  height: 65,
                  width: MediaQuery.of(context).size.width -50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    primary: kDarkColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                  Navigator.pushNamed(context, SignIn.id);
                    },
                    child: const Text(
                  'SIGN IN',
                  style: TextStyle(
                      color: kTextDarkColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                    text: "Don't heva a account?",
                    style: const TextStyle(color: Colors.white24, fontSize: 14),
                    children: [
                      TextSpan(
                          text: ' Sign up',
                          style: const TextStyle(
                              color: kTextDarkColor, fontSize: 14),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            Navigator.pushNamed(context, SignUp.id);
                          })
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
