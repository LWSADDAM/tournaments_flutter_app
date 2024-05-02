import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:trainer/screens/auth.dart/login.dart';
import 'package:trainer/screens/homepage.dart';
import 'package:trainer/utils/assets.dart';

import '../../provider/auth_provider.dart';
import '../../utils/material.dart';
import '../../widgets/textfieldwidget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController pass2Controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    checkLoginF();
  }

  checkLoginF() async {
    User? user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                MaterialColors.primaryColor)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (passController.text.toString() !=
                                pass2Controller.text.toString()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Password Should Be Same')));
                            } else {
                              await Provider.of<AuthVMC>(context, listen: false)
                                  .createWithEmailAndPassword(context,
                                      email: emailController.text,
                                      password: passController.text);
                            }
                          }
                        },
                        child: context.watch<AuthVMC>().isLoadingForLogin
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Login',
                                      style: TextStyle(color: Colors.white)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Transform.scale(
                                      scale: 0.6,
                                      child: CircularProgressIndicator.adaptive(
                                        backgroundColor: MaterialColors
                                            .primaryColor.shade100,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : const Text('SignUp',
                                style: TextStyle(color: Colors.white)))))
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(
                duration: const Duration(seconds: 2),
                delay: const Duration(seconds: 2)),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Center(
                      child: SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.2 / 1,
                              child: Image.asset(Assets.splash1))
                          .animate(onPlay: (controller) => controller.repeat())
                          .shimmer(
                              duration: const Duration(seconds: 2),
                              delay: const Duration(seconds: 2))),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  const Text("SignUp",
                      style: TextStyle(
                          color: MaterialColors.primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2),
                      child: TextFormFieldCustom(
                          controller: emailController,
                          hint: "Email",
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Email is Required";
                            }
                          })),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2),
                      child: TextFormFieldCustom(
                          controller: passController,
                          hint: "Password",
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Password is Required";
                            }
                          })),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2),
                      child: TextFormFieldCustom(
                          controller: pass2Controller,
                          hint: "Confirm Password",
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Password is Required";
                            }
                          })),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Text("OR"),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("    Have Account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: const Text("Login"))
                    ],
                  )
                ]),
              ),
            )));
  }
}
