// // lib/screens/history_screen.dart
//
// import 'package:flutter/material.dart';
//
// class HistoryScreen extends StatelessWidget {
//   final List<String> history;
//
//   HistoryScreen({required this.history});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Calculation History'),
//         backgroundColor: Colors.grey,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.builder(
//           itemCount: history.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(
//                 history[index],
//                 style: TextStyle(fontSize: 18.0),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
