// import 'package:flutter/material.dart';
// import 'package:notes/models/note_model.dart';
// import 'package:provider/provider.dart';
// import 'package:notes/view_models/List_Notes_view_model.dart';
// import 'package:notes/views/Add_Note_Screen.dart';
//
// class Grid_Tile_Widget extends StatelessWidget {
//   int index;
//
//   Grid_Tile_Widget(this.index);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       child: Consumer<NoteListViewModel>(
//         builder: (context, notedata, child) {
//           return GestureDetector(
//             onLongPress: () {
//               notedata.deleteNote(notedata.Notes[index]);
//             },
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           AddNoteScreen(note: notedata.Notes[index])));
//             },
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Expanded(
//                   flex: 9,
//                   child: GridTile(
//                       child: Container(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Text(
//                         notedata.Notes[index].description,
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         color: Color(0xFF161616),
//                         shape: BoxShape.rectangle,
//                         borderRadius: BorderRadius.circular(13)),
//                   )),
//                 ),
//                 Expanded(
//                     flex: 1,
//                     child: Center(
//                         child: Text(
//                       notedata.Notes[index].title,
//                     ))),
//                 Expanded(
//                     flex: 1,
//                     child: Center(
//                         child: Text(
//                       notedata.accessNoteDateTime(
//                           notedata.Notes[index]),
//                       style: TextStyle(color: Color(0xFF727474)),
//                     )))
//                 //    ,
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
