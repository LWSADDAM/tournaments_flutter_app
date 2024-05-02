import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SportTypesC with ChangeNotifier {
  List<dynamic> getSportTypesList = [];

  CollectionReference sportTypes =
      FirebaseFirestore.instance.collection('sportTypes');

  Future<void> getSportTypesF() async {
    try {
      var getList = await sportTypes.get();
      if (getList.docs.isNotEmpty) {
        getSportTypesList.clear();
        getSportTypesList = getList.docs;

        // debugPrint("👉 getSportTypesList:${getSportTypesList[0].id}");
        // debugPrint("👉 getSportTypesList:${getSportTypesList[0]tiitle}");
      }
      notifyListeners();
    } catch (e) {
      notifyListeners();
      debugPrint("💥 try catch getSportTypesF:$e");
    }
  }
}
