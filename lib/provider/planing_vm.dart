import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trainer/provider/auth_provider.dart';

class PlaningProviderC extends ChangeNotifier {
  CollectionReference genTeams =
      FirebaseFirestore.instance.collection('planing');
  //////////////////////////////////////////////////////////////
  bool isLoading = false;
  List planingList = [];

  getPlaningF(context) async {
    try {
      isLoading = true;
      notifyListeners();
      var getData = await genTeams.get();
      ///// filter it
      // context.watch<PlaningProviderC>().planingList[index]['coaches']
      //                         .where((element) => element['id'] == vmVal.uid).toList()
      if (planingList.isNotEmpty) {
        planingList.clear();
      }
      List teamsList = Provider.of<AuthVMC>(context, listen: false).teams;
      // Loop through each element in getData.docs
      for (var element in getData.docs) {
        // Loop through each team in the current element
        for (var team in element['teams']) {
          // Check if either team0 or team1 uid matches with any uid in teamsList
          if (teamsList.any((e) =>
              e['uid'].toString().toLowerCase() ==
                  team['team0']['uid'].toString().toLowerCase() ||
              e['uid'].toString().toLowerCase() ==
                  team['team1']['uid'].toString().toLowerCase())) {
            // If a match is found, add the element to planingList
            planingList.add({
              "sportType": element['sportType'],
              "genderIs": element['genderIs'],
              "tournamentType": element['tournamentType'],
              "status": team['status'],
              "winTeamNo": team['winTeamNo'],
              "teams": team,
            });
            // Break the loop as we don't need to check further teams for this element
            break;
          }
        }
      }
      // debugPrint("👉 teamsList:$teamsList");
      // debugPrint("👉 getData.docs:${getData.docs[0]['teams']}");
      // debugPrint("👉 planingList:$planingList");
      // for (var element in getData.docs) {
      //   for (var e2 in element['teams']) {
      //     for (var e3 in teamsList) {
      //       if ((e2['team0']['uid'].toString().toLowerCase() ==
      //               e3['uid'].toString().toLowerCase()) ||
      //           (e2['team1']['uid'].toString().toLowerCase() ==
      //               e3['uid'].toString().toLowerCase())) {
      //         planingList.add(element);
      //         break; // Added to break the loop once a match is found
      //       }
      //     }
      //   }
      // }

      debugPrint("👉🎞 planingList:${planingList[1]['teams']}");
      // planingList = getData.docs;
      isLoading = false;
      notifyListeners();
    } catch (error, stackTrace) {
      isLoading = false;
      notifyListeners();
      debugPrint("💥 try catch when getCoachesF error: Error: $error");
      debugPrint("💥 try catch stackTrace getCoachesF: $stackTrace");
    }
  }

  updatePlaningF(context, dataForReference) async {
    try {
      List coachesList = [];
      coachesList = dataForReference['coaches'];
      var uid = await Provider.of<AuthVMC>(context, listen: false).uid;

      for (int i = 0; i < coachesList.length; i++) {
        if (coachesList[i]['id'].toString().toLowerCase() ==
            uid.toString().toLowerCase()) {
          coachesList[i]['request'] = 'Accepted';
          // debugPrint("🎞👉 $coachesList ");
          break;
        }
      }
      debugPrint("👉 dataForReference.id: ${dataForReference.id}");
      await genTeams.doc(dataForReference.id).update({
        'coaches': coachesList.toList(),
      }).then((v) async {
        Navigator.pop(context);
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     content: const Text('Accepted'),
        //     action: SnackBarAction(label: 'Ok!', onPressed: () {})));
      });
      // notifyListeners();
      // await getPlaningF(context);
    } catch (error, stackTrace) {
      notifyListeners();
      debugPrint("💥 try catch when getCoachesF error: Error: $error");
      debugPrint("💥 try catch stackTrace getCoachesF: $stackTrace");
    }
  }
}
