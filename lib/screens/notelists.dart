import 'package:flutter/material.dart';
import 'package:my_sqflite_project/screens/notedetails.dart';
import 'package:my_sqflite_project/screens/notelists.dart';
import 'dart:async';
import 'package:my_sqflite_project/models/note.dart';
import 'package:my_sqflite_project/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class NoteLists extends StatefulWidget {
  
  @override
  State<NoteLists> createState() => _NoteListsState();
}

class _NoteListsState extends State<NoteLists> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    if(noteList == null){
      noteList = List<Note>();
      updateListView();
    }
    debugPrint('Count value: $count');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: getNoteListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Adding a note');
          navigateToDetail(Note('', '', 2),'Add Note');
        },
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        debugPrint('Rendering item $index'); // Debug output
        return Card(
          color: const Color.fromARGB(255, 255, 57, 57),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: getPriorityColor(this.noteList[position].priority),
              child: getPriorityIcon(this.noteList[position].priority),
            ),
            title: Text(this.noteList[position].title,style: titleStyle,),
            subtitle: const Text(this.noteList[position].date),
            trailing: GestureDetector(child: const Icon(Icons.delete, color: Colors.grey),
            onTap: () {
              _delete(context, noteList[position]);
            },),
            onTap: (){
              debugPrint("ListTile Tapped");
              navigateToDetail(this.noteList[position],'Edit Note');
            },
            
          ),
        );
      },
    );
  }
  Color getPriorityColor(int priority){
    switch(priority){
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
      
    }
  }
  Icon getPriorityIcon(int priority){
    switch(priority){
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }
  void _delete(BuildContext context,Note note) async{

    int result = await databaseHelper.deleteNote(note.id);
    if(result != 0){
      _showSnackBar(context,'Note Deleted Successfully');
      updateListView();
    }
  }
  void _showSnackBar(BuildContext context,String message){
    final SnackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(SnackBar);
  }



  void navigateToDetail(Note note,String title){}
    Navigator.push(context, MaterialPageRoute(
      builder: (context){
        return NoteDetail(note,title);
      }));
  }


  void updateListView(){
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database){
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList){
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
}


