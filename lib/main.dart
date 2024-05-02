import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:trainer/screens/homepage.dart';
import 'package:trainer/utils/assets.dart';
import '../utils/glitch.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'provider/auth_provider.dart';
import 'provider/planing_vm.dart';
import 'provider/sport_type_vm.dart';
import 'provider/teams_provider.dart';
import 'provider/tournaments_vm.dart';
import 'screens/auth.dart/login.dart';
import 'utils/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_optionssss.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthVMC()),
          ChangeNotifierProvider(create: (_) => TeamsVmC()),
          ChangeNotifierProvider(create: (_) => SportTypesC()),
          ChangeNotifierProvider(create: (_) => TournamentsC()),
          ChangeNotifierProvider(create: (_) => PlaningProviderC()),
        ],
        child: MaterialApp(
            title: 'Trainer',
            theme: ThemeData(
                colorScheme:
                    ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
                useMaterial3: true),
            debugShowCheckedModeBanner: false,
            home: const SplashPage()));
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    onlineSpan();
  }

  onlineSpan() async {
    Timer(const Duration(seconds: 3), () async {
      Navigator.of(context).pushReplacement(PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(color: MaterialColors.primaryColor[50]),
        child: Scaffold(
            backgroundColor: MaterialColors.primaryColor[50],
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 0.8 / 1,
                              child: GlithEffect(
                                  child: Image.asset(Assets.splash1)))
                          .animate()
                          .scale()),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25 / 1),
                  // const CircularProgressIndicator(strokeWidth: 2)
                  Text('Champ Corner',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  // color: Colors.deepPurpleAccent,
                                  color: MaterialColors.primaryColor[400],
                                  shadows: [
                                BoxShadow(
                                    color: MaterialColors.primaryColor[200]!,
                                    offset: const Offset(1, 1),
                                    blurRadius: 2)
                              ]))
                      .animate(
                          delay: 500.ms,
                          onPlay: (controller) => controller.repeat())
                      .shakeX()
                      .shimmer(
                          duration: const Duration(seconds: 2),
                          delay: const Duration(milliseconds: 1000))
                      .shimmer(
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInOut)
                ])));
  }
}
