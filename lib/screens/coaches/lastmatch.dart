import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

import '../../helpers/dateformat.dart';
import '../../utils/assets.dart';
import '../../utils/material.dart';

class LastMatchDetailsPage extends StatefulWidget {
  const LastMatchDetailsPage({super.key});

  @override
  State<LastMatchDetailsPage> createState() => _LastMatchDetailsPageState();
}

class _LastMatchDetailsPageState extends State<LastMatchDetailsPage> {
  List<String> catgForTeam = [
    "Pain Full Fight",
    "Full Knockout",
    "Classic Kick",
  ];
  String selectedCategory = "Pain Full Fight";
  String selectedGender = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Last Match"),
          backgroundColor: MaterialColors.primaryColor.shade50,
          surfaceTintColor: MaterialColors.primaryColor.shade50,
          elevation: 0),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.12,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                        color: MaterialColors.primaryColor.shade50,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(70))),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 17.0),
                                child: Hero(
                                    tag: "coachProfile",
                                    child: CircleAvatar(
                                        radius: 40,
                                        child: Image.asset(Assets.coach)))),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name Abc",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: MaterialColors
                                            .primaryColor.shade300,
                                        fontWeight: FontWeight.bold)
                                  )
                                      .animate(
                                          delay: 500.ms,
                                          onPlay: (controller) =>
                                              controller.repeat())
                                      .shimmer(
                                          duration: const Duration(seconds: 2),
                                          delay: const Duration(
                                              milliseconds: 1000))
                                      .shimmer(
                                          duration: const Duration(seconds: 2),
                                          curve: Curves.easeInOut),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Last Match : ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              color: Colors.green.shade700,
                                              fontWeight: FontWeight.w300),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              '${formatDate(DateTime.now())} ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color:
                                                      Colors.blueGrey.shade400,
                                                  fontWeight: FontWeight.w300),
                                        ),
                                        TextSpan(
                                          text: ' - ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color:
                                                      Colors.blueGrey.shade600,
                                                  fontWeight: FontWeight.w800),
                                        ),
                                        TextSpan(
                                          text: '${formatDate(DateTime.now())}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color:
                                                      Colors.blueGrey.shade400,
                                                  fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ))),
            Stack(children: [
              Container(
                  color: MaterialColors.primaryColor.shade50,
                  height: MediaQuery.of(context).size.height * 0.1),
              Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(90))),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(" All Teams",
                                style: TextStyle(
                                    color: Colors.blueGrey.shade200,
                                    fontWeight: FontWeight.bold))
                          ])))
            ]),
            ListView.builder(
                itemCount: 8,
                shrinkWrap: true,
                controller: ScrollController(),
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    leading: const CircleAvatar(
                        child: Icon(Icons.person_4_outlined)),
                    title: const Text("Abc"),
                    subtitle: const Text("Category"),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Container(
                          color: Colors.blueGrey.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Text("Name:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color:
                                                    Colors.blueGrey.shade400))),
                                const Text("abc"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Container(
                          color: Colors.blueGrey.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Text("Gender:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color:
                                                    Colors.blueGrey.shade400))),
                                const Text("Male"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ////
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Container(
                          color: Colors.blueGrey.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Text("Weight:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color:
                                                    Colors.blueGrey.shade400))),
                                const Text("70 KG"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ////
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
