import 'package:imovies/constant.dart';
import 'package:imovies/screen/get_started.dart';
import 'package:imovies/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const String id = "SignUp_screen";
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController reEnterPassword = TextEditingController();
  TextEditingController emailAddressTextEdit = TextEditingController();
  TextEditingController passwordTextEdit = TextEditingController();
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
                  padding: const EdgeInsets.only(left: 25),
                  onPressed: () {
                    Navigator.pushNamed(context, GetStarted.id);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ), // back button, appbar
              const Text(
                "Create your account",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ), //Text Create acc
              Padding(
                padding: const EdgeInsets.only(top: 30),
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
                child: Text(
                  'OR SIGN UP WITH EMAIL',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ), // Text Sign In
              Padding(
                padding: const EdgeInsets.only(bottom: 22, right: 15, left: 15),
                child: TextField(
                  controller: emailAddressTextEdit,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Email',
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
              ), // TextField Email// TextField Password
              Padding(
                padding: const EdgeInsets.only(bottom: 22, right: 15, left: 15),
                child: TextField(
                  controller: passwordTextEdit,
                  keyboardType: TextInputType.visiblePassword,
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
              ), // TextField Password
              Padding(
                padding: const EdgeInsets.only(bottom: 22, right: 15, left: 15),
                child: TextField(
                  controller: reEnterPassword,
                  keyboardType: TextInputType.visiblePassword,
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
              ),
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
                    'GET STARTED',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )

              // TextField Re-enter password// TextField Re-enter password
            ],
          ),
        ),
      ),
    );
  }

}

