import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:trainer/provider/auth_provider.dart';
import 'package:trainer/provider/teams_provider.dart';
import 'package:trainer/utils/assets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/material.dart';
import 'update_team.dart';

class TeamDetailsPage extends StatefulWidget {
  final int index;
  final Map teamDetails;
  const TeamDetailsPage(
      {super.key, required this.index, this.teamDetails = const {}});

  @override
  State<TeamDetailsPage> createState() => _TeamDetailsPageState();
}

class _TeamDetailsPageState extends State<TeamDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        backgroundColor: MaterialColors.primaryColor.shade100,
        surfaceTintColor: MaterialColors.primaryColor.shade100,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateTeamsPage(
                            teamMap: widget.teamDetails, index: widget.index)));
              },
              icon: const Icon(Icons.edit_note_outlined))
        ],
      ),
      bottomNavigationBar: InkWell(
          onTap: () {
            showCupertinoDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                      title: Text('Delete? ${widget.teamDetails['fname']}')
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
                              AuthVMC userData = await Provider.of<AuthVMC>(
                                  context,
                                  listen: false);
                              userData.teams.removeAt(widget.index);

                              await Provider.of<TeamsVmC>(context,
                                      listen: false)
                                  .deleteTeamF(context,
                                      uid: userData.uid,
                                      teamsList: userData.teams);
                            },
                            child: const Text('Yes')),
                        CupertinoButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No')),
                      ],
                      insetAnimationCurve: Curves.slowMiddle,
                      insetAnimationDuration: const Duration(seconds: 2));
                });
          },
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              child: BottomAppBar(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 0.0),
                      child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Icon(Icons.delete_outline_outlined,
                                color: Colors.grey),
                            SizedBox(width: 10),
                            Text('Delete', style: TextStyle(color: Colors.grey))
                          ])
                          .animate(
                              delay: 500.ms,
                              onPlay: (controller) => controller.repeat())
                          .shimmer(
                              duration: const Duration(seconds: 2),
                              delay: const Duration(milliseconds: 2000)))))),
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
                        color: MaterialColors.primaryColor.shade100,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(70))),
                    child: Column(children: [
                      Row(children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: Hero(
                                tag: widget.index.toString(),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: CircleAvatar(
                                        radius: 40,
                                        backgroundColor:
                                            MaterialColors.primaryColor.shade50,
                                        child: Image.asset(Assets.boxer,
                                            fit: BoxFit.cover))))),
                        Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${widget.teamDetails['fname']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: MaterialColors
                                                  .primaryColor.shade300,
                                              fontWeight: FontWeight.bold))
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
                                          text: 'Sport Type : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color: MaterialColors
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w300),
                                          children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                '${widget.teamDetails['sportType']} ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                    color: MaterialColors
                                                        .primaryColor.shade800,
                                                    fontWeight:
                                                        FontWeight.w300))
                                      ]))
                                ]))
                      ])
                    ]))),
            Stack(children: [
              Container(
                  color: MaterialColors.primaryColor.shade100,
                  height: MediaQuery.of(context).size.height * 0.11),
              Container(
                  height: MediaQuery.of(context).size.height * 0.11,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(60))),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(" ${widget.teamDetails['phone']}",
                              style: TextStyle(
                                  color: MaterialColors.primaryColor.shade200,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 30),
                            child: Transform.scale(
                              scale: 1.5,
                              child: IconButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              MaterialColors
                                                  .primaryColor.shade50)),
                                  onPressed: () async {
                                    final Uri launchUri = Uri(
                                      scheme: 'tel',
                                      path: "${widget.teamDetails['phone']}",
                                    );
                                    await launchUrl(launchUri);
                                  },
                                  icon: const Icon(
                                    Icons.phone_outlined,
                                    color: MaterialColors.primaryColor,
                                  )),
                            ),
                          ),
                        ],
                      ))),
            ]),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
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
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text("First Name:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            color: Colors.blueGrey.shade400))),
                            Text("${widget.teamDetails['fname']}"),
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
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text("last Name:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            color: Colors.blueGrey.shade400))),
                            Text("${widget.teamDetails['lname']}"),
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
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text("Gender:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            color: Colors.blueGrey.shade400))),
                            Text("${widget.teamDetails['gender']}"),
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
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text("BirthDay:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            color: Colors.blueGrey.shade400))),
                            Text("${widget.teamDetails['birthday']}"),
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
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text("Weight:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            color: Colors.blueGrey.shade400))),
                            Text("${widget.teamDetails['weight']}"),
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
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text("Address:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            color: Colors.blueGrey.shade400))),
                            Text("${widget.teamDetails['address']}"),
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
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text("Sport Type:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            color: Colors.blueGrey.shade400))),
                            Text("${widget.teamDetails['sportType']}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
