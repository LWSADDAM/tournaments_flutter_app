import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:trainer/provider/auth_provider.dart';
import 'package:trainer/screens/planing/planing_details.dart';
import '../../provider/planing_vm.dart';
import '../../utils/assets.dart';
import '../../utils/material.dart';

class NotifyPage extends StatefulWidget {
  final dynamic data;
  const NotifyPage({super.key, this.data});

  @override
  State<NotifyPage> createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<PlaningProviderC>(context, listen: false).getPlaningF(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        appBar: AppBar(
            title: const Text("All Tournaments"),
            backgroundColor:
                MaterialColors.primaryColor.shade100.withOpacity(0.7)),
        body: Consumer<PlaningProviderC>(builder: (context, vmVal, child) {
          return SingleChildScrollView(
              controller: ScrollController(),
              child: Column(children: [
                const SizedBox(height: 20),
                /////////////
                vmVal.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: vmVal.planingList.length,
                        shrinkWrap: true,
                        controller: ScrollController(),
                        itemBuilder: (BuildContext context, int index) {
                          var data = vmVal.planingList[index];
                          return VsTile(data: data);
                        })
              ]));
        }));
  }
}

class VsTile extends StatefulWidget {
  final dynamic data;
  const VsTile({super.key, this.data});

  @override
  State<VsTile> createState() => _VsTileState();
}

class _VsTileState extends State<VsTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlaningDetailsPage(data: widget.data)));
        },
        child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            // decoration: BoxDecoration(color: Colors.white,),
            child: Column(children: [
              // Text(widget.data.id),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.16,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(Assets.coach),
                              ),
                              Positioned(
                                      // right: -4,
                                      top: 34,
                                      bottom: 0,
                                      // offset: Offset(-10, 0),

                                      child: SizedBox(
                                          width: 30,
                                          child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.black87,
                                                      child: widget.data['status'] == "Done" &&
                                                              widget.data['winingTeamNo'] ==
                                                                  "0"
                                                          ? Image.asset(
                                                              Assets.win)
                                                          : widget.data['status'] == "Done" &&
                                                                  widget.data['winTeamNo'] ==
                                                                      "1"
                                                              ? Icon(Icons.thumb_down,
                                                                  color: Colors
                                                                      .redAccent
                                                                      .shade100,
                                                                  size: 12)
                                                              : const Icon(Icons.history,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 12))))))
                                  .animate(
                                      delay: 500.ms,
                                      onPlay: (controller) =>
                                          controller.repeat())
                                  .saturate()
                                  .shimmer(
                                      duration: const Duration(seconds: 2),
                                      delay: const Duration(milliseconds: 1000))
                                  .shimmer(
                                      duration: const Duration(seconds: 2),
                                      curve: Curves.easeInOut),
                            ],
                          )),
                      Text(" ${widget.data['teams']['team0']['fname']} ",
                          style: TextStyle(fontSize: 17)),
                    ],
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Image.asset(Assets.vs)),
                  Row(
                    children: [
                      Text("${widget.data['teams']['team1']['fname']} ",
                          style: const TextStyle(fontSize: 17)),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.17,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(Assets.coach),
                              ),
                              Positioned(
                                      // right: -4,
                                      top: 34,
                                      bottom: 0,
                                      // offset: Offset(-10, 0),

                                      child: SizedBox(
                                          width: 30,
                                          child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.black87,
                                                      child: widget.data['status'] == "Done" &&
                                                              widget.data['winTeamNo'] ==
                                                                  "1"
                                                          ? Image.asset(
                                                              Assets.win)
                                                          : widget.data['status'] == "Done" &&
                                                                  widget.data['winingTeamNo'] ==
                                                                      "0"
                                                              ? Icon(Icons.thumb_down,
                                                                  color: Colors
                                                                      .redAccent
                                                                      .shade100,
                                                                  size: 12)
                                                              : const Icon(Icons.history,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 12))))))
                                  .animate(
                                      delay: 500.ms,
                                      onPlay: (controller) =>
                                          controller.repeat())
                                  .saturate()
                                  .shimmer(
                                      duration: const Duration(seconds: 2),
                                      delay: const Duration(milliseconds: 1000))
                                  .shimmer(
                                      duration: const Duration(seconds: 2),
                                      curve: Curves.easeInOut),
                            ],
                          )),
                    ],
                  )
                ],
              ),
              const Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(" ${widget.data['tournamentType']}"),
                Text("${widget.data['sportType']} ")
              ])
            ])));
  }

///////////////////////////////
}
