import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/material.dart';

class ShowSelectedTeams extends StatefulWidget {
  const ShowSelectedTeams({super.key});

  @override
  State<ShowSelectedTeams> createState() => _ShowSelectedTeamsState();
}

class _ShowSelectedTeamsState extends State<ShowSelectedTeams> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Transform.rotate(
                angle: -0.3,
                child: Transform.scale(
                  scale: 1.2,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                        color: MaterialColors.primaryColor.shade50,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.elliptical(50, 50))),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                left: MediaQuery.of(context).size.width * 0.24,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  // height: MediaQuery.of(context).size.height * 0.07,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text("Confirm")),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.2,
                left: MediaQuery.of(context).size.width * 0.1,
                child: Text("Something About This........."),
              ),
            ],
          ),

          //////////////
          DataTable(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),

            // border:
            //     TableBorder(left: BorderSide(width: 2, color: Colors.black)),
            columns: [
              const DataColumn(label: Text('My Team.')),
              const DataColumn(label: Text('vs.')),
              const DataColumn(label: Text('Abc Team')),
            ],
            rows: [
              const DataRow(cells: [
                DataCell(Text('abc 1')),
                DataCell(Text('/')),
                DataCell(Text('abc 2')),
              ]),
              const DataRow(cells: [
                DataCell(Text('abc 1')),
                DataCell(Text('/')),
                DataCell(Text('abc 2')),
              ]),
              // Add more DataRow widgets for additional rows
            ],
          ),
        ],
      ),
    );
  }
}
