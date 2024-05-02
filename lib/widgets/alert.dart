import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:trainer/provider/auth_provider.dart';

/////////////////////////
callDeleteAccountAlert(context) async {
  showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.transparent,
            body: CupertinoAlertDialog(
                title: const Text('Want To Delete An Account?')
                    .animate(onPlay: (controller) {
                      controller.repeat();
                    })
                    .shimmer(
                        delay: const Duration(seconds: 1),
                        duration: const Duration(seconds: 2))
                    .shimmer(
                        color: Colors.redAccent.shade200,
                        delay: const Duration(seconds: 1),
                        duration: const Duration(seconds: 2)),
                actions: [
                  CupertinoButton(
                      onPressed: () async {
                        await Provider.of<AuthVMC>(context, listen: false)
                            .deleteAccountVMF(context);
                      },
                      child: const Text(
                        'YES',
                        style: TextStyle(color: Colors.red),
                      )),
                  CupertinoButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('NO')),
                ],
                insetAnimationCurve: Curves.slowMiddle,
                insetAnimationDuration: const Duration(seconds: 2)));
      });
}
