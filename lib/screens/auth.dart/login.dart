import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:trainer/screens/homepage.dart';
import 'package:trainer/utils/assets.dart';

import '../../provider/auth_provider.dart';
import '../../utils/material.dart';
import '../../widgets/textfieldwidget.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
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
  bool isVisible = true;

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
                            await Provider.of<AuthVMC>(context, listen: false)
                                .signInWithEmailAndPassword(context,
                                    email: emailController.text,
                                    password: passController.text);
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
                            : const Text('Login',
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  const Text("Login",
                      style: TextStyle(
                          color: MaterialColors.primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Text("Something about this...................."),
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
                        },
                      )),
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
                        },
                         obscureText: isVisible,
                  suffixIcon: IconButton(
                      onPressed: () {
                        isVisible = !isVisible;
                        setState(() {});
                      },
                      icon: Icon(isVisible
                          ? Icons.visibility_off
                          : Icons.visibility))
                      )),
                  const Text("OR"),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  InkWell(
                      onTap: () async {
                        await Provider.of<AuthVMC>(context, listen: false)
                            .loginWithGoogleVMF(context);
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey.shade50,
                              border: Border.all(
                                  width: 1, color: Colors.blueGrey.shade200),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      child: Image.asset(Assets.googleicon)),
                                  const Text(" Sign In With Google",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.blueGrey)),
                                  context.watch<AuthVMC>().isLoading
                                      ? Opacity(
                                          opacity: 0.6,
                                          child: Transform.scale(
                                              scale: 0.9,
                                              child: CircularProgressIndicator
                                                  .adaptive(
                                                      backgroundColor:
                                                          MaterialColors
                                                              .primaryColor
                                                              .shade100)))
                                      : const Text(""),
                                ],
                              )))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("    Have Not Account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          },
                          child: const Text("Signup"))
                    ],
                  )
                ]),
              ),
            )));
  }
}
