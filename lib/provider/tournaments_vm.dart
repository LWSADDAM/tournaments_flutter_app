import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TournamentsC with ChangeNotifier {
  List<dynamic> getTournamentsList = [];
  String choosedTournament = "Choose";

  CollectionReference tournaments =
      FirebaseFirestore.instance.collection('tournamentTypes');

  Future<void> getTournamentsF() async {
    try {
      var getList = await tournaments.get();
      if (getList.docs.isNotEmpty) {
        getTournamentsList.clear();
        getTournamentsList = getList.docs;

        // debugPrint("👉 getTournamentsList:${getTournamentsList[0].id}");
        // debugPrint("👉 getTournamentsList:${getTournamentsList[0]tiitle}");
      }
      notifyListeners();
    } catch (e) {
      notifyListeners();
      debugPrint("💥 try catch getTournamentsF:$e");
    }
  }

  chooseTournamentsF(value) {
    try {
      choosedTournament = value;
      notifyListeners();
    } catch (e) {
      notifyListeners();
      debugPrint("💥 try catch chooseTournamentsF:$e");
    }
  }
}
