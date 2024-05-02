import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/assets.dart';
import '../../utils/material.dart';

class PlaningDetailsPage extends StatefulWidget {
  final dynamic data;
  const PlaningDetailsPage({super.key, required this.data});

  @override
  State<PlaningDetailsPage> createState() => _PlaningDetailsPageState();
}

class _PlaningDetailsPageState extends State<PlaningDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              const Text("Manage Team", style: TextStyle(color: Colors.white)),
          backgroundColor: MaterialColors.primaryColor.shade200),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(children: [
          Container(
              decoration:
                  BoxDecoration(color: MaterialColors.primaryColor.shade100),
              child: Column(children: [
                CupertinoListTile(
                    title: const Text("Tournament"),
                    trailing: Text(widget.data['tournamentType'])),
                CupertinoListTile(
                    title: const Text("Gender"),
                    trailing: Text(widget.data['genderIs'])),
                CupertinoListTile(
                    title: const Text("Status"),
                    trailing: Text(widget.data['status']))
              ])),
          const SizedBox(height: 20),
          const SizedBox(height: 2, child: Divider(color: Colors.black26)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Container(
              decoration: BoxDecoration(color: Colors.blueGrey.shade50),
              child: ListTile(
                  subtitle: widget.data['status'] == "Pending"
                      ? const Text("Pending",
                          style: TextStyle(color: Colors.blueGrey))
                      : widget.data['status'] == "Done" &&
                              widget.data['winTeamNo'] == "0"
                          ? const Text("Win",
                              style: TextStyle(color: Colors.green))
                          : const Text("Loss",
                              style: TextStyle(color: Colors.red)),
                  leading: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.17,
                      child: Stack(children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CircleAvatar(
                              radius: 30,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: Image.asset(Assets.boxer)),
                              ),
                            )),
                        Positioned(
                                top: 27,
                                bottom: 0,
                                child: SizedBox(
                                    width: 30,
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: CircleAvatar(
                                                backgroundColor: Colors.black87,
                                                child: widget.data['status'] ==
                                                        "Pending"
                                                    ? const Icon(Icons.history,
                                                        color: Colors.white,
                                                        size: 15)
                                                    : widget.data['status'] ==
                                                                "Done" &&
                                                            widget.data[
                                                                    'winTeamNo'] ==
                                                                "0"
                                                        ? Image.asset(
                                                            Assets.win)
                                                        : Icon(Icons.thumb_down,
                                                            color: Colors
                                                                .red.shade200,
                                                            size: 15))))))
                            .animate(
                                delay: 500.ms,
                                onPlay: (controller) => controller.repeat())
                            .saturate()
                            .shimmer(
                                duration: const Duration(seconds: 2),
                                delay: const Duration(milliseconds: 1000))
                            .shimmer(
                                duration: const Duration(seconds: 2),
                                curve: Curves.easeInOut)
                      ])),
                  title: Text(
                      "${widget.data['teams']['team0']['fname']}${widget.data['teams']['team0']['lname']}"))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                  child: CupertinoListTile(
                      title: const Text("Phone"),
                      trailing: IconButton(
                          onPressed: () async {
                            final Uri launchUri = Uri(
                                scheme: 'tel',
                                path:
                                    "${widget.data['teams']['team0']['phone']}");
                            await launchUrl(launchUri);
                          },
                          icon: const Icon(Icons.phone))))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                  child: CupertinoListTile(
                      title: const Text("Weight"),
                      trailing: Text(
                          "${widget.data['teams']['team0']['weight']} KG")))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                  child: CupertinoListTile(
                      title: const Text("Gender"),
                      trailing:
                          Text("${widget.data['teams']['team0']['gender']}")))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                  child: CupertinoListTile(
                      title: const Text("Sport Type"),
                      trailing: Text(
                          "${widget.data['teams']['team0']['sportType']}")))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                  child: CupertinoListTile(
                      title: const Text("Birthday"),
                      trailing: Text(
                          "${widget.data['teams']['team0']['birthday']}")))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                  child: CupertinoListTile(
                      title: const Text("Address"),
                      trailing: Text(
                          "${widget.data['teams']['team0']['address']}")))),
          /////////////////////////////////////////////////////////////////////////////////////////////////
          const SizedBox(height: 10),
          Stack(alignment: Alignment.center, children: [
            const Divider(thickness: 4),
            CircleAvatar(child: Image.asset(Assets.vs))
          ]),
          const SizedBox(height: 10),
          Container(
              decoration: BoxDecoration(color: Colors.blueGrey.shade50),
              child: ListTile(
                  subtitle: widget.data['status'] == "Pending"
                      ? const Text("Pending",
                          style: TextStyle(color: Colors.blueGrey))
                      : widget.data['status'] == "Done" &&
                              widget.data['winTeamNo'] == "1"
                          ? const Text("Win",
                              style: TextStyle(color: Colors.green))
                          : const Text("Loss",
                              style: TextStyle(color: Colors.red)),
                  leading: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.17,
                      child: Stack(children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CircleAvatar(
                              radius: 30,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: Image.asset(Assets.boxer)),
                              ),
                            )),
                        Positioned(
                                top: 27,
                                bottom: 0,
                                child: SizedBox(
                                    width: 30,
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: CircleAvatar(
                                                backgroundColor: Colors.black87,
                                                child: widget.data['status'] ==
                                                        "Pending"
                                                    ? const Icon(Icons.history,
                                                        color: Colors.white,
                                                        size: 15)
                                                    : widget.data['status'] ==
                                                                "Done" &&
                                                            widget.data[
                                                                    'winTeamNo'] ==
                                                                "1"
                                                        ? Image.asset(
                                                            Assets.win)
                                                        : Icon(Icons.thumb_down,
                                                            color: Colors
                                                                .red.shade200,
                                                            size: 15))))))
                            .animate(
                                delay: 500.ms,
                                onPlay: (controller) => controller.repeat())
                            .saturate()
                            .shimmer(
                                duration: const Duration(seconds: 2),
                                delay: const Duration(milliseconds: 1000))
                            .shimmer(
                                duration: const Duration(seconds: 2),
                                curve: Curves.easeInOut)
                      ])),
                  title: Text(
                      "${widget.data['teams']['team1']['fname']}${widget.data['teams']['team1']['lname']}"))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                  child: CupertinoListTile(
                      title: const Text("Phone"),
                      trailing: IconButton(
                          onPressed: () async {
                            final Uri launchUri = Uri(
                                scheme: 'tel',
                                path:
                                    "${widget.data['teams']['team1']['phone']}");
                            await launchUrl(launchUri);
                          },
                          icon: const Icon(Icons.phone))))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                  child: CupertinoListTile(
                      title: const Text("Weight"),
                      trailing: Text(
                          "${widget.data['teams']['team1']['weight']} KG")))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                  child: CupertinoListTile(
                      title: const Text("Gender"),
                      trailing:
                          Text("${widget.data['teams']['team1']['gender']}")))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                  child: CupertinoListTile(
                      title: const Text("Sport Type"),
                      trailing: Text(
                          "${widget.data['teams']['team1']['sportType']}")))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                  child: CupertinoListTile(
                      title: const Text("Birthday"),
                      trailing: Text(
                          "${widget.data['teams']['team1']['birthday']}")))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                  child: CupertinoListTile(
                      title: const Text("Address"),
                      trailing: Text(
                          "${widget.data['teams']['team1']['address']}")))),
        ]),
      ),
    );
  }
}
