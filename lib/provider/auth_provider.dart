import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trainer/screens/auth.dart/login.dart';
import 'package:trainer/screens/homepage.dart';

class AuthVMC extends ChangeNotifier {
  // int _count = 0;

  // int get count => _count;
  bool isLoading = false;
  bool isLoadingForLogin = false;
  var userProfile = {};
  List teams = [];
  String? uid = "";
  String? userName = "";
  String? userEmail = "";
  String? imgPickerPath = "";
  String? tournamentType = "";
  getAuthF() async {
    isLoading = true;
    notifyListeners();
    uid = FirebaseAuth.instance.currentUser!.uid.toString();
    userName = FirebaseAuth.instance.currentUser!.displayName;
    userEmail = FirebaseAuth.instance.currentUser!.email;
    /////// from database
    var checkUser =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    userProfile = checkUser.data()!;
    teams = checkUser.data()!['teams'] ?? [];
    tournamentType = checkUser.data()!['tournamentType'] ?? " ";
    // debugPrint("👉 userProfile: ${checkUser.data().toString()}");
    isLoading = false;
    notifyListeners();
  }

  deleteAccountVMF(context) async {
    FirebaseAuth.instance.currentUser!.delete().then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Account Deleted!')));
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('$error')));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Login Again To Confirm!'),
        action: SnackBarAction(
            label: 'Login',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            }),
      ));
    });
  }

  Future<void> createWithEmailAndPassword(context,
      {String email = "", String password = ""}) async {
    try {
      signoutF();
      isLoadingForLogin = true;
      notifyListeners();
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      // print('User ${user!.uid} signed in successfully!');
      var userName = user!.email.toString().split('@');
      registeredVmF(context, uid: user.uid.toString(), name: userName.first);
      isLoadingForLogin = false;
      notifyListeners();
    } catch (e) {
      isLoadingForLogin = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<void> signInWithEmailAndPassword(context,
      {String email = "", String password = ""}) async {
    try {
      signoutF();
      isLoadingForLogin = true;
      notifyListeners();
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      uid = user!.uid;
      getAuthF();
      isLoadingForLogin = false;
      notifyListeners();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } catch (e) {
      isLoadingForLogin = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      print('Failed to sign in: $e');
    }
  }

  loginWithGoogleVMF(context) async {
    try {
      signoutF();
      isLoading = true;
      notifyListeners();
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(forceCodeForRefreshToken: true).signIn();
      if (googleUser != null) {
        ////////
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        ////////
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        // debugPrint("👉 googleAuth.idToken: ${googleAuth.idToken}");
        // debugPrint("👉 googleAuth.accessToken: ${googleAuth.accessToken}");
        ////////
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        debugPrint("👉 userCredential: ${userCredential.user!.uid}");
        // debugPrint("Signed in as ${userCredential.user!.displayName}");
        await registeredVmF(context,
            name: userCredential.user!.displayName,
            uid: userCredential.user!.uid);
      } else {
        debugPrint("Sign-in cancelled");
      }
      isLoading = false;
      notifyListeners();
    } catch (error, stackTrace) {
      isLoading = false;
      notifyListeners();
      debugPrint("💥 try catch when SignIn: Error: $error");
      debugPrint("💥 try catch stackTrace: $stackTrace");
    }
    // notifyListeners();
  }

  // checkDataIdF(context, {id, email}) async {
  //   var checkUsersId =
  //       await FirebaseFirestore.instance.collection("users").get();
  //   for (var data in checkUsersId.docs) {
  //     if (data.id.toString().toLowerCase() == id.toString().toLowerCase()) {
  //       uid = id;
  //       userName = data.data()['profile']['name'];
  //       userEmail = email;
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }
  // }

  /////////////// if Not Registered Make an account
  registeredVmF(context, {uid = "abc", name = "Name"}) async {
    var checkUser =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    if (checkUser.data() != null &&
        checkUser.data()!['uid'].toString().toLowerCase() ==
            uid.toString().toLowerCase()) {
      debugPrint("👉 userProfile: ${checkUser.data().toString()}");
      getAuthF();
      isLoading = false;
      notifyListeners();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
      return;
    }
    final userProfile = {
      "uid": "$uid",
      "teams": [],
      "tournamentType": "Not Choosed",
      "profile": {
        "imgPath":
            "https://firebasestorage.googleapis.com/v0/b/turnierproto2.appspot.com/o/coach.png?alt=media&token=0f85fe51-4d88-4fe5-8433-2ca9ec82d45a",
        "name": "$name",
        "availableTimeRange": "2024-05-10 To:2025-01-01",
        "phone": "+124567",
        "bio": "Experienced Coach With a Passion For Mentoring athietes.",
        "educationCertificate":
            "Bachelor`s in Sports Managements,Certified Coach",
        "teamsCurrentlyCoach": "Youth Coccer Team",
        "skillsExperties": "Tactical Analysis, Player Development",
        "preferences": "Prefer one-on-one Coaching Sessions",
      }
    };
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(userProfile);
    isLoading = false;
    notifyListeners();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
  //////////////////////////////////////////////////

  signoutF() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }

  //////////////////////////////////////////////////

  updateImage(BuildContext context, String imgPath) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Uploading image....'),
          duration: Duration(seconds: 1)));
      imgPickerPath = imgPath;
      isLoading = true;
      notifyListeners();
      var refProfile = FirebaseStorage.instance
          .ref()
          .child("usersId")
          .child(uid!)
          .child('profile.png');
      var uploadTask = refProfile.putFile(File(imgPath));

      var downloadUrl = await (await uploadTask).ref.getDownloadURL();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Profile Updated!'), duration: Duration(seconds: 1)));

//////////////////////////
      final userProfile = {"profile.imgPath": downloadUrl};
//////////////////////////
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .update(userProfile);
      await getAuthF();
      isLoading = false;
      notifyListeners();
      log("👉 Image download URL: $downloadUrl");
    } catch (e, stackTrace) {
      isLoading = false;
      notifyListeners();
      log("💥 try catch when updateImage:$e");
      log("💥 try catch ST when updateImage:$stackTrace");
    }
  }

  /////////////////////////
  updateProfileVmF(context, {profileDataForUpdate = const {}}) async {
    isLoading = true;
    notifyListeners();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update(profileDataForUpdate);
    isLoading = false;
    notifyListeners();
    await getAuthF();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Profile Updated!')));
  }

  //////////
  updateProfiletournamentTypeVmF(context, {value = ""}) async {
    isLoading = true;
    notifyListeners();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"tournamentType": value});
    await getAuthF();
    isLoading = false;
    notifyListeners();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Updated!')));
  }
}
