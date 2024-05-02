// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:turnier/utils/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add, color: Colors.white),
//         backgroundColor: MaterialColors.primaryColor.shade300,
//         onPressed: () {},
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar.medium(
//             surfaceTintColor: Colors.white,
//             // backgroundColor:
//             //     MaterialColors.primaryColor.shade100.withOpacity(0.6),
//             flexibleSpace: Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: Image.asset("assets/hands.png"),
//             ),
//             leading: const Icon(Icons.sort),
//             title: const Text('title remainig'),
//             centerTitle: true,
//             actions: [
//               const Icon(Icons.filter_alt_outlined),
//               SizedBox(width: 10)
//             ],
//           ),
//           SliverToBoxAdapter(
//             child: Container(
//               // height: 1100,
//               color: MaterialColors.primaryColor.shade50,
//               child: Column(
//                 children: [
//                   Transform.translate(
//                     offset: const Offset(0, -10),
//                     child: Card(
//                       borderOnForeground: true,
//                       surfaceTintColor: Colors.white,
//                       color: Colors.white,
//                       shape: const BeveledRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(20),
//                               bottomRight: Radius.circular(20))),
//                       child: ListTile(
//                         tileColor: Colors.white,
//                         shape: BeveledRectangleBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                         title: const Text(
//                           "Total Coaches",
//                           style: TextStyle(color: MaterialColors.primaryColor),
//                         ),
//                         trailing: const Text(
//                           "30",
//                           style: TextStyle(
//                               color: MaterialColors.primaryColor,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       SizedBox(
//                         height: 20,
//                         child: TextButton(
//                             style: ButtonStyle(
//                                 padding: MaterialStateProperty.all(
//                                     EdgeInsets.only(right: 20))),
//                             onPressed: () {},
//                             child: const Text("see All")),
//                       ),
//                     ],
//                   ),
//                   GridView.builder(
//                     shrinkWrap: true,
//                     controller: ScrollController(),
//                     itemCount: 30,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Card(
//                         borderOnForeground: true,
//                         surfaceTintColor: Colors.white,
//                         color: Colors.white,
//                         shape: BeveledRectangleBorder(
//                             borderRadius: BorderRadius.circular(17)),
//                         child: Opacity(
//                             opacity: 1,
//                             child: Transform.scale(
//                                 scale: 0.7,
//                                 child: Image.asset("assets/coachProfile.png"))),
//                       )
//                           .animate()
//                           .fade(delay: Duration(milliseconds: 200 * index))
//                           .fadeIn();
//                     },
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


