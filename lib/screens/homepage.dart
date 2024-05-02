import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:trainer/helpers/valueinpoints.dart';
import 'package:trainer/provider/planing_vm.dart';
import 'package:trainer/utils/assets.dart';
import '../provider/auth_provider.dart';
import '../provider/tournaments_vm.dart';
import '../utils/material.dart';
import 'planing/planing_details.dart';
import 'teams/addteam.dart';
import 'notify.dart';
import 'profile.dart';
import 'teams/team_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadF();
  }

  loadF() async {
    await Provider.of<AuthVMC>(context, listen: false).getAuthF();
    await Provider.of<TournamentsC>(context, listen: false).getTournamentsF();
    await Provider.of<PlaningProviderC>(context, listen: false)
        .getPlaningF(context);
  }

  String selectedTournament = "Select Tournament";
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVMC>(builder: (context, vmVal, child) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.small(
            tooltip: "Add Team",
            shape: const ContinuousRectangleBorder(
                side: BorderSide(width: 2, color: MaterialColors.primaryColor)),
            child: const Icon(Icons.add, color: MaterialColors.primaryColor),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddTeamsPage()));
            }),
        body: CustomScrollView(
          slivers: [
            SliverAppBar.medium(
                pinned: true,
                floating: true,
                snap: true,
                scrolledUnderElevation: 0.9,
                surfaceTintColor: Colors.white,
                centerTitle: true,
                leading: const Text(''),
                flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                  // debugPrint("👉 constraints:${constraints.maxHeight}");
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Divider(),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${vmVal.userProfile['profile']['name']}",
                                      style: const TextStyle(
                                          color: MaterialColors.primaryColor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 22)),
                                  Row(children: [
                                    Transform.translate(
                                      offset: Offset(
                                          mapRange(constraints.maxHeight, 100,
                                                      180, 0.1, 1.0) *
                                                  120 -
                                              30,
                                          0),
                                      child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onTap: () async {
                                            await loadF();
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             const NotifyPage()));
                                          },
                                          child: Opacity(
                                              opacity: mapRange(
                                                  constraints.maxHeight,
                                                  100,
                                                  180,
                                                  0.4,
                                                  1.0),
                                              child: const CircleAvatar(
                                                  child: Icon(Icons.refresh)))),
                                    ),
                                    const SizedBox(width: 5),
                                    Transform.translate(
                                        offset: Offset(
                                            mapRange(constraints.maxHeight, 100,
                                                    180, 0.1, 1.0) *
                                                -60,
                                            0),
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const CoachProfilePage()));
                                            },
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Hero(
                                                  tag: "profile",
                                                  child: CircleAvatar(
                                                      child: CachedNetworkImage(
                                                          imageUrl:
                                                              vmVal.userProfile[
                                                                      'profile']
                                                                  ['imgPath'],
                                                          placeholder:
                                                              (context, url) {
                                                            return Transform.scale(
                                                                scale: 0.7,
                                                                child: const CircularProgressIndicator
                                                                    .adaptive(
                                                                    strokeWidth:
                                                                        2));
                                                          },
                                                          errorWidget: (context,
                                                              url, error) {
                                                            return Image.asset(
                                                                Assets
                                                                    .coachProfile);
                                                          })),
                                                ))))
                                  ])
                                ])),
                        const SizedBox(height: 25),
                        ///////////////
                        constraints.maxHeight <= 130.0
                            ? const SizedBox(height: 0, width: 0)
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.blueGrey.shade100
                                                .withOpacity(0.5)),
                                        child: Row(children: [
                                          Text(" Available",
                                              style: TextStyle(
                                                  color: Colors
                                                      .blueGrey.shade400)),
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors
                                                      .greenAccent.shade100),
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 2),
                                                  child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(Icons.history,
                                                            size: 13,
                                                            color: Colors.green
                                                                .shade700),
                                                        Text(
                                                            "${vmVal.userProfile['profile']['availableTimeRange']}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green
                                                                    .shade700,
                                                                fontSize: 11))
                                                      ])))
                                        ])),

                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 14.0),
                                        child: RichText(
                                            text: TextSpan(
                                                text:
                                                    '${context.watch<PlaningProviderC>().planingList.length}',
                                                style: TextStyle(
                                                    color:
                                                        Colors.green.shade700,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                children: const <TextSpan>[
                                              TextSpan(
                                                  text: ' / ',
                                                  style: TextStyle(
                                                      color: Colors.purple,
                                                      fontSize: 15)),
                                              TextSpan(
                                                  text: 'Matches ',
                                                  style: TextStyle(
                                                      color: Colors.green))
                                            ])))
                                    // Row(
                                    //   children: [
                                    //     RichText(
                                    //       text: TextSpan(
                                    //         text: 'Wons  ',
                                    //         style: const TextStyle(
                                    //             color: Colors.green, fontSize: 12),
                                    //         children: <TextSpan>[
                                    //           TextSpan(
                                    //               text: '0',
                                    //               style: TextStyle(
                                    //                   color: Colors.green.shade700,
                                    //                   fontWeight: FontWeight.bold)),
                                    //           const TextSpan(
                                    //               text: '/',
                                    //               style: TextStyle(
                                    //                   color: Colors.purple,
                                    //                   fontSize: 15)),
                                    //           const TextSpan(
                                    //               text: 'Loss ',
                                    //               style: TextStyle(
                                    //                   color: Colors.red,
                                    //                   fontSize: 12)),
                                    //           TextSpan(
                                    //               text: '0',
                                    //               style: TextStyle(
                                    //                   color: Colors.red.shade700,
                                    //                   fontWeight: FontWeight.bold))
                                    //         ],
                                    //       ),
                                    //     ),
                                    //     const SizedBox(width: 10),
                                    //   ],
                                    // ),
                                  ])
                      ]);
                })),
            SliverToBoxAdapter(
              child: Container(
                color: MaterialColors.primaryColor.shade50,
                child: Column(
                  children: [
                    const SizedBox(
                        height: 7,
                        child: Divider(
                            thickness: 7, height: 1, color: Colors.purple)),
                    Transform.translate(
                            offset: const Offset(0, -10),
                            child: Card(
                                borderOnForeground: true,
                                surfaceTintColor: Colors.white,
                                color: Colors.white,
                                shape: const BeveledRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20))),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NotifyPage()));
                                    },
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Last Message",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blueGrey
                                                                .shade300,
                                                            fontSize: 10)),
                                                    context
                                                            .watch<
                                                                PlaningProviderC>()
                                                            .planingList
                                                            .isNotEmpty
                                                        ? Text(
                                                            " New Tournament Requested",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green
                                                                    .shade700,
                                                                fontSize: 11))
                                                        : Text(
                                                            "Welcome!.........",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green
                                                                    .shade700,
                                                                fontSize: 11))
                                                  ])),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.close,
                                                  color: Colors.green.shade700,
                                                  size: 17))
                                        ]))))
                        .animate(
                            delay: const Duration(seconds: 2),
                            onPlay: (controller) => controller.repeat())
                        .shimmer(duration: const Duration(seconds: 2))
                        .shimmer(duration: const Duration(seconds: 2)),

                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      SizedBox(
                          height: 20,
                          child: TextButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.only(right: 20))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NotifyPage()));
                              },
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Last Matches",
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade300)))))
                    ]),

                    // military_tech
                    context.watch<PlaningProviderC>().planingList.isEmpty
                        ? Row(children: [
                            const SizedBox(width: 10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Card(
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Opacity(
                                        opacity: 0.2,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: CircleAvatar(
                                                        child: Image.asset(
                                                            Assets.boxer)))),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                                child: Image.asset(Assets.vs)),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: CircleAvatar(
                                                        child: Image.asset(
                                                            Assets.boxer)))),
                                          ],
                                        ),
                                      ),
                                      const Text("No Matches",
                                          style: TextStyle(
                                              color:
                                                  MaterialColors.primaryColor,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ])
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: context
                                    .watch<PlaningProviderC>()
                                    .planingList
                                    .length,
                                controller: ScrollController(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var teamsData = context
                                      .watch<PlaningProviderC>()
                                      .planingList[index];
                                  // debugPrint("👉${teamsData}");
                                  // return Text("${teamsData['teams']}");
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.55,
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PlaningDetailsPage(
                                                              data: teamsData,
                                                            )));
                                              },
                                              child: Hero(
                                                  tag: index.toString(),
                                                  child: Card(
                                                      shape:
                                                          BeveledRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      child: Row(children: [
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2,
                                                            child: Row(
                                                                children: [
                                                                  Opacity(
                                                                    opacity:
                                                                        0.4,
                                                                    child: Padding(
                                                                        padding: const EdgeInsets.only(left: 4.0),
                                                                        child: CircleAvatar(
                                                                            radius: 11,
                                                                            backgroundColor: Colors.black,
                                                                            child: teamsData['status'] == "Pending"
                                                                                ? const Icon(Icons.history, color: Colors.white, size: 14)
                                                                                : teamsData['status'] == "Done" && teamsData['winTeamNo'] == "0"
                                                                                    ? Image.asset(Assets.win)
                                                                                    : const Icon(Icons.thumb_down, color: Colors.white, size: 14))),
                                                                  ),
                                                                  CircleAvatar(
                                                                      child: Text(teamsData['teams']['team0']
                                                                              [
                                                                              'fname']
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              1)
                                                                          .toUpperCase())),
                                                                ])),
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.1,
                                                            child: Image.asset(
                                                                Assets.vs)),
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2,
                                                            child: Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                      child: Text(teamsData['teams']['team1']
                                                                              [
                                                                              'fname']
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              1)
                                                                          .toUpperCase())),
                                                                  Opacity(
                                                                    opacity:
                                                                        0.4,
                                                                    child: Padding(
                                                                        padding: const EdgeInsets.only(left: 4.0),
                                                                        child: CircleAvatar(
                                                                            radius: 11,
                                                                            backgroundColor: Colors.black,
                                                                            child: teamsData['status'] == "Pending"
                                                                                ? const Icon(Icons.history, color: Colors.white, size: 14)
                                                                                : teamsData['status'] == "Done" && teamsData['winTeamNo'] == "1"
                                                                                    ? Image.asset(Assets.win)
                                                                                    : const Icon(Icons.thumb_down, color: Colors.white, size: 14))),
                                                                  ),
                                                                ]))
                                                      ]))))));
                                })),
                    const SizedBox(height: 10),
                    Transform.translate(
                        offset: const Offset(0, 40),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade50
                                        .withOpacity(0.3),
                                    // borderRadius: BorderRadius.circular(20),
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(40),
                                        bottomRight: Radius.circular(40),
                                        topLeft: Radius.circular(40)),
                                    border: Border.all(
                                        width: 1.5,
                                        color: MaterialColors
                                            .primaryColor.shade100)),
                                child: ListTile(
                                    trailing: const Icon(
                                        Icons.keyboard_arrow_down_sharp),
                                    onTap: () {
                                      showCupertinoDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CupertinoAlertDialog(
                                                title: const Text(
                                                    'Select Tournament Type'),
                                                content: SingleChildScrollView(
                                                  controller:
                                                      ScrollController(),
                                                  child: context
                                                          .watch<TournamentsC>()
                                                          .getTournamentsList
                                                          .isEmpty
                                                      ? const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text("Empty"))
                                                      : Column(
                                                          children: context
                                                              .watch<
                                                                  TournamentsC>()
                                                              .getTournamentsList
                                                              .map((e) => Padding(
                                                                  padding: const EdgeInsets.all(2.0),
                                                                  child: CupertinoListTile(
                                                                      onTap: () async {
                                                                        await vmVal.updateProfiletournamentTypeVmF(
                                                                            context,
                                                                            value:
                                                                                e['title']);
                                                                        // context
                                                                        //     .read<
                                                                        //         TournamentsC>()
                                                                        //     .chooseTournamentsF(
                                                                        //         e['title']);
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      backgroundColor: Colors.blueGrey.shade50,
                                                                      title: Text("${e['title']}"))))
                                                              .toList(),
                                                        ),
                                                ),
                                                insetAnimationCurve:
                                                    Curves.bounceInOut,
                                                insetAnimationDuration:
                                                    const Duration(seconds: 1));
                                          });
                                    },
                                    title: Text(
                                        vmVal.tournamentType ?? "Choose"))))),

                    // Transform.translate(
                    //   offset: const Offset(0, 25),
                    //   child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.end,
                    //       children: [
                    //         SizedBox(
                    //             height: 20,
                    //             child: TextButton(
                    //                 style: ButtonStyle(
                    //                     padding: MaterialStateProperty.all(
                    //                         const EdgeInsets.only(right: 20))),
                    //                 onPressed: () {
                    //                   Navigator.push(
                    //                       context,
                    //                       MaterialPageRoute(
                    //                           builder: (context) =>
                    //                               const AddTeamsPage()));
                    //                 },
                    //                 child: const Text("All Teams")))
                    //       ]),
                    // ),
                    vmVal.teams.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1),
                              Text("Have No Teams",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              // color: Colors.deepPurpleAccent,
                                              color: MaterialColors
                                                  .primaryColor[400],
                                              shadows: [
                                            BoxShadow(
                                                color: MaterialColors
                                                    .primaryColor[200]!,
                                                offset: const Offset(1, 1),
                                                blurRadius: 2)
                                          ]))
                                  .animate(
                                      delay: 500.ms,
                                      onPlay: (controller) =>
                                          controller.repeat())
                                  .shakeX()
                                  .shimmer(
                                      duration: const Duration(seconds: 2),
                                      delay: const Duration(milliseconds: 1000))
                                  .shimmer(
                                      duration: const Duration(seconds: 2),
                                      curve: Curves.easeInOut)
                            ],
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            controller: ScrollController(),
                            itemCount: vmVal.userProfile['teams']!.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              Map teamData = vmVal.teams[index];
                              return Card(
                                      borderOnForeground: true,
                                      surfaceTintColor: Colors.white,
                                      color: Colors.white,
                                      shape: const BeveledRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(17),
                                              bottomRight:
                                                  Radius.circular(17))),
                                      child: ListTile(
                                          leading: Hero(
                                              tag: index.toString(),
                                              child: Opacity(
                                                  opacity: 1,
                                                  child: Transform.scale(
                                                      scale: 0.9,
                                                      child: Image.asset(
                                                          Assets.boxer)))),
                                          title: Text("${teamData['fname']}"),
                                          subtitle: Row(children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.06,
                                                child:
                                                    Image.asset(Assets.weight)),
                                            Text(
                                                'Wieght : ${teamData['weight']}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: Colors
                                                            .blueGrey.shade700,
                                                        fontWeight:
                                                            FontWeight.w300))
                                          ]),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TeamDetailsPage(
                                                            index: index,
                                                            teamDetails:
                                                                teamData)));
                                          },
                                          trailing: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                  teamData['gender']
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'male'
                                                      ? Icons.male
                                                      : Icons.female,
                                                  color: Colors
                                                      .blueGrey.shade200))))
                                  .animate()
                                  .fade(
                                      delay: Duration(milliseconds: 300 * index))
                                  .fadeIn();
                            },
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
