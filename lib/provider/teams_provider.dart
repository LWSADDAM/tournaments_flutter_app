import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trainer/provider/auth_provider.dart';

class TeamsVmC extends ChangeNotifier {
  bool isLoading = false;
  addTeamF(context, {uid = "abc", teamData = const {}}) async {
    try {
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .update(teamData);
      await Provider.of<AuthVMC>(context, listen: false).getAuthF();
      isLoading = false;
      notifyListeners();
      Navigator.pop(context);
    } catch (error, stackTrace) {
      isLoading = false;
      notifyListeners();
      debugPrint("💥 try catch when TeamsVmC error: Error: $error");
      debugPrint("💥 try catch stackTrace TeamsVmC: $stackTrace");
    }
  }

  updateTeamF(context, {uid = "abc", teamByIndexMapData, teamListIndex}) async {
    try {
      isLoading = true;
      notifyListeners();
      // String fieldPath = "teams.$teamListIndex";
      // Map<String, dynamic> updateData = {
      //   fieldPath: teamByIndexMapData,
      // };
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .update({"teams": teamByIndexMapData});
      // .update({"teams.$teamListIndex": teamByIndexMapData});
      await Provider.of<AuthVMC>(context, listen: false).getAuthF();
      isLoading = false;
      notifyListeners();
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (error, stackTrace) {
      isLoading = false;
      notifyListeners();
      debugPrint("💥 try catch when TeamsVmC error: Error: $error");
      debugPrint("💥 try catch stackTrace TeamsVmC: $stackTrace");
    }
  }

  deleteTeamF(context, {uid = "abc", teamsList = const []}) async {
    try {
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .update({"teams": teamsList});
      await Provider.of<AuthVMC>(context, listen: false).getAuthF();
      isLoading = false;
      notifyListeners();
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (error, stackTrace) {
      isLoading = false;
      notifyListeners();
      debugPrint("💥 try catch when TeamsVmC error: Error: $error");
      debugPrint("💥 try catch stackTrace TeamsVmC: $stackTrace");
    }
  }
}
