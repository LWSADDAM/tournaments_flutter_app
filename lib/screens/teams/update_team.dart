import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:trainer/provider/auth_provider.dart';
import 'package:trainer/provider/teams_provider.dart';

import '../../provider/sport_type_vm.dart';
import '../../utils/material.dart';
import '../../widgets/textfieldwidget.dart';

enum Gender { Male, Female }

class UpdateTeamsPage extends StatefulWidget {
  final int index;
  final Map teamMap;
  const UpdateTeamsPage(
      {super.key, required this.index, this.teamMap = const {}});

  @override
  State<UpdateTeamsPage> createState() => _UpdateTeamsPageState();
}

class _UpdateTeamsPageState extends State<UpdateTeamsPage> {
  String selectedGender = "Male";

  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController sportTypeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.teamMap['fname'];
    lastNameController.text = widget.teamMap['lname'];
    birthdayController.text = widget.teamMap['birthday'];
    weightController.text = widget.teamMap['weight'];
    addressController.text = widget.teamMap['address'];
    telephoneController.text = widget.teamMap['phone'];
    sportTypeController.text = widget.teamMap['sportType'];
    selectedGender = widget.teamMap['gender'];
    Provider.of<SportTypesC>(context, listen: false).getSportTypesF();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        // extendBodyBehindAppBar: true,
        bottomNavigationBar: SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.2),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                MaterialColors.primaryColor)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            AuthVMC authData =
                                Provider.of<AuthVMC>(context, listen: false);
                            List teamsList = authData.teams.toList();
                            teamsList[widget.index] = {
                              // Map mapData = {
                              "fname": firstNameController.text,
                              "lname": lastNameController.text,
                              "birthday": birthdayController.text,
                              "weight": weightController.text,
                              "gender": selectedGender.toString(),
                              "address": addressController.text,
                              "phone": telephoneController.text,
                              "sportType": sportTypeController.text
                            };
                            // final updatedTeamsList = {"teams": teamsList};
                            await Provider.of<TeamsVmC>(context, listen: false)
                                .updateTeamF(context,
                                    uid: authData.uid,
                                    teamByIndexMapData: teamsList,
                                    teamListIndex: widget.index);
                          }
                        },
                        child: context.watch<TeamsVmC>().isLoading
                            ? CircularProgressIndicator.adaptive(
                                backgroundColor:
                                    MaterialColors.primaryColor.shade100)
                            : const Text('Update',
                                style: TextStyle(color: Colors.white)))))
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(
                duration: const Duration(seconds: 2),
                delay: const Duration(seconds: 2)),
        appBar: AppBar(title: const Text("Update Team")),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04),
                          Text("  Can Add 13 Team Members",
                                  style: TextStyle(
                                      color: Colors.deepOrange.shade200))
                              .animate(
                                  onPlay: (controller) => controller.repeat())
                              .shimmer(delay: const Duration(seconds: 2)),
                          Row(children: [
                            Expanded(
                              child: TextFormFieldCustom(
                                controller: firstNameController,
                                hint: 'First Name',
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter first name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                                child: TextFormFieldCustom(
                                    controller: lastNameController,
                                    hint: 'Last Name',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter last name';
                                      }
                                      return null;
                                    }))
                          ]),
                          Row(
                            children: [
                              Expanded(
                                  child: TextFormFieldCustom(
                                      controller: birthdayController,
                                      hint: 'Birthday',
                                      inputType: TextInputType.datetime,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter birthday';
                                        }
                                        return null;
                                      })),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormFieldCustom(
                                  controller: weightController,
                                  hint: 'Weight KG',
                                  inputType: TextInputType.number,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter weight KG';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Gender",
                                    style: TextStyle(
                                        color: Colors.blueGrey.shade300,
                                        fontWeight: FontWeight.bold)),
                                Radio.adaptive(
                                    value: "Male",
                                    groupValue: selectedGender,
                                    onChanged: (v) {
                                      selectedGender = v!;
                                      setState(() {});
                                    }),
                                const Text("Male"),
                                Radio.adaptive(
                                    value: "Female",
                                    groupValue: selectedGender,
                                    onChanged: (v) {
                                      selectedGender = v!;
                                      setState(() {});
                                    }),
                                const Text("Female")
                              ]),
                          TextFormFieldCustom(
                              controller: addressController,
                              hint: 'Address',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter address';
                                }
                                return null;
                              }),
                          TextFormFieldCustom(
                              inputType: TextInputType.phone,
                              controller: telephoneController,
                              hint: 'Telephone',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter telephone number';
                                }
                                return null;
                              }),
                          TextFormFieldCustom(
                              controller: sportTypeController,
                              hint: 'Sport Type',
                              onTap: () {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, set) {
                                        return CupertinoAlertDialog(
                                          title:
                                              const Text('Select Sport Type'),
                                          content: SingleChildScrollView(
                                            controller: ScrollController(),
                                            child: Column(
                                              children: context
                                                  .watch<SportTypesC>()
                                                  .getSportTypesList
                                                  .map((e) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child:
                                                            CupertinoListTile(
                                                                onTap: () {
                                                                  sportTypeController
                                                                          .text =
                                                                      "${e['title']}";
                                                                  set(() {});
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                backgroundColor:
                                                                    Colors
                                                                        .blueGrey
                                                                        .shade50,
                                                                title: Text(
                                                                    "${e['title']}")),
                                                      ))
                                                  .toList(),
                                            ),
                                          ),
                                          insetAnimationCurve:
                                              Curves.bounceInOut,
                                          insetAnimationDuration:
                                              const Duration(seconds: 1),
                                        );
                                      });
                                    });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter sport type';
                                }
                                return null;
                              })
                        ])))));
  }
}
