import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:trainer/helpers/dateformat.dart';
import 'package:trainer/provider/auth_provider.dart';
import 'package:trainer/screens/auth.dart/login.dart';
import 'package:trainer/utils/assets.dart';

import '../utils/material.dart';
import '../widgets/alert.dart';

class CoachProfilePage extends StatefulWidget {
  const CoachProfilePage({Key? key}) : super(key: key);

  @override
  State<CoachProfilePage> createState() => _CoachProfilePageState();
}

class _CoachProfilePageState extends State<CoachProfilePage> {
  // Placeholder variables for coach information
  // String coachName = "John Doe";
  // String contactInfo = "123-456-7890";
  // String bioDescription =
  //     "Experienced coach with a passion for mentoring athletes.";
  // String educationAndCertifications =
  //     "Bachelor's in Sports Management, Certified Coach";
  // String teamsCurrentlyCoaching = "Youth Soccer Team";
  // String availability = "Available weekday evenings and weekends.";
  // String skillsAndExpertise = "Tactical Analysis, Player Development";
  // String preferences = "Prefer one-on-one coaching sessions.";

  // Controllers for the text fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactInfoController = TextEditingController();
  TextEditingController _bioDescriptionController = TextEditingController();
  TextEditingController _educationAndCertificationsController =
      TextEditingController();
  TextEditingController _teamsCurrentlyCoachingController =
      TextEditingController();
  TextEditingController _availabilityController = TextEditingController();
  TextEditingController _skillsAndExpertiseController = TextEditingController();
  TextEditingController _preferencesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var userProfile =
        Provider.of<AuthVMC>(context, listen: false).userProfile['profile'];
    _nameController.text = userProfile['name'];
    _contactInfoController.text = userProfile['phone'];
    _bioDescriptionController.text = userProfile['bio'];
    _educationAndCertificationsController.text =
        userProfile['educationCertificate'];
    _teamsCurrentlyCoachingController.text = userProfile['teamsCurrentlyCoach'];
    _availabilityController.text = userProfile['availableTimeRange'];
    _skillsAndExpertiseController.text = userProfile['skillsExperties'];
    _preferencesController.text = userProfile['preferences'];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now().add(const Duration(days: 7))),
      firstDate: DateTime.now(),
      lastDate: DateTime(2500),
    );
    if (picked != null) {
      setState(() {
        _availabilityController.text =
            '${formatDate(picked.start)} To:${formatDate(picked.end)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVMC>(builder: (context, vMval, child) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Coach Profile"),
            actions: [
              IconButton(
                  onPressed: () {
                    callDeleteAccountAlert(context);
                  },
                  icon: const Icon(Icons.delete)),
              IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  icon: const Icon(Icons.exit_to_app_outlined))
            ],
          ),
          body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Stack(children: [
                              RippleAnimation(
                                  color: MaterialColors.primaryColor.shade200,
                                  delay: const Duration(milliseconds: 300),
                                  repeat: true,
                                  minRadius: 35,
                                  ripplesCount: 6,
                                  duration: const Duration(milliseconds: 1500),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Hero(
                                        tag: "profile",
                                        child: CircleAvatar(
                                            radius: 50,
                                            child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                onTap: () async {
                                                  var img = await ImagePicker()
                                                      .pickImage(
                                                          source: ImageSource
                                                              .gallery);
                                                  if (img != null) {
                                                    await vMval.updateImage(
                                                        context, img.path);
                                                  }
                                                },
                                                child: vMval.imgPickerPath!
                                                        .isNotEmpty
                                                    ? Image.file(File(
                                                        vMval.imgPickerPath!))
                                                    : CachedNetworkImage(
                                                        imageUrl:
                                                            vMval.userProfile[
                                                                    'profile']
                                                                ['imgPath'],
                                                        placeholder: (context,
                                                                url) =>
                                                            CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                              backgroundColor:
                                                                  MaterialColors
                                                                      .primaryColor
                                                                      .shade100,
                                                            ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(Assets
                                                                .coach)))),
                                      ))),
                              Positioned(
                                  right: 0,
                                  bottom: 6,
                                  child: CircleAvatar(
                                      radius: 15,
                                      child: vMval.isLoading
                                          ? Transform.scale(
                                              scale: 0.7,
                                              child: CircularProgressIndicator
                                                  .adaptive(
                                                strokeWidth: 2,
                                                backgroundColor: MaterialColors
                                                    .primaryColor.shade100,
                                              ),
                                            )
                                          : const Icon(Icons.edit, size: 20)))
                            ])),
                        TextFormField(
                            controller: _nameController,
                            decoration:
                                const InputDecoration(labelText: 'Name')),
                        TextFormField(
                            controller: _contactInfoController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                labelText: 'Contact Information')),
                        TextFormField(
                            controller: _bioDescriptionController,
                            decoration: const InputDecoration(
                                labelText: 'Bio Description'),
                            maxLines: null),
                        TextFormField(
                            controller: _educationAndCertificationsController,
                            decoration: const InputDecoration(
                                labelText: 'Education and Certifications')),
                        TextFormField(
                            controller: _teamsCurrentlyCoachingController,
                            decoration: const InputDecoration(
                                labelText: 'Teams Currently Coaching')),
                        TextFormField(
                            controller: _availabilityController,
                            onTap: () {
                              _selectDate(context);
                            },
                            decoration: const InputDecoration(
                                labelText: 'Availability')),
                        TextFormField(
                            controller: _skillsAndExpertiseController,
                            decoration: const InputDecoration(
                                labelText: 'Skills and Expertise')),
                        TextFormField(
                            controller: _preferencesController,
                            decoration:
                                const InputDecoration(labelText: 'Preferences'))
                      ]))),
          bottomNavigationBar: BottomAppBar(
              child: SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              MaterialColors.primaryColor)),
                      onPressed: () {
                        final userProfile = {
                          "profile": {
                            "imgPath": vMval.userProfile['profile']['imgPath'],
                            "name": _nameController.text,
                            "phone": _contactInfoController.text,
                            "bio": _bioDescriptionController.text,
                            "educationCertificate":
                                _educationAndCertificationsController.text,
                            "teamsCurrentlyCoach":
                                _teamsCurrentlyCoachingController.text,
                            "availableTimeRange": _availabilityController.text,
                            "skillsExperties":
                                _skillsAndExpertiseController.text,
                            "preferences": _preferencesController.text,
                          }
                        };
                        vMval.updateProfileVmF(context,
                            profileDataForUpdate: userProfile);
                      },
                      child: vMval.isLoading
                          ? CircularProgressIndicator.adaptive(
                              backgroundColor:
                                  MaterialColors.primaryColor.shade100)
                          : const Text('Update Profile',
                              style: TextStyle(color: Colors.white))))));
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactInfoController.dispose();
    _bioDescriptionController.dispose();
    _educationAndCertificationsController.dispose();
    _teamsCurrentlyCoachingController.dispose();
    _availabilityController.dispose();
    _skillsAndExpertiseController.dispose();
    _preferencesController.dispose();
    super.dispose();
  }
}
