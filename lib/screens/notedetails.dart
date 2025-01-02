import 'package:flutter/material.dart';
import 'package:my_sqflite_project/screens/notedetails.dart';
import 'package:my_sqflite_project/screens/notelists.dart';
import 'dart:async';
import 'package:my_sqflite_project/models/note.dart';
import 'package:my_sqflite_project/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
class NoteDetails extends StatefulWidget {
  
  String appBarTitle;
  final Note note;
  NoteDetails(this.note,this.appBarTitle);

  @override
  State<NoteDetails> createState() => NoteDetailsState(this.appBarTitle);
}

class NoteDetailsState extends State<NoteDetails> {

  static var _priorities = ["High","Low"];
  String appBarTitle;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  NoteDetailsState(this.appBarTitle);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: IconButton(onPressed:(){
          moveBackward();
        }, 
        icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15,right: 10,left: 10),
        child: ListView(
          children: [
            ListTile(
              trailing: DropdownButton(
                items: _priorities.map((String dropDownStringItem){
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem));
                }).toList(), 
                value: 'Low',
                onChanged: (valueSelectedByUser){
                  setState(() {
                    debugPrint('user selected $valueSelectedByUser');
                  });
                },
            ),),
            Padding(
              padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
              child:TextField(
                controller: titleController,
                onChanged: (value) {
                  debugPrint("it has changed");
                }, 
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
              ) ),
              Padding(
              padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
              child:TextField(
                controller: descriptionController,
                onChanged: (value) {
                  debugPrint("Description has changed");
                }, 
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
              ) ),
              Padding(
                padding: EdgeInsets.only(top:15.0,bottom: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            debugPrint("Save button Clicked");
                          });
                        }, 
                        child:Text("Save"),
                        style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.purple,
                         foregroundColor: Colors.white
                        )),
                    ),
                    Container(width: 5.0,),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            debugPrint("Delete button Clicked");
                          });
                        }, 
                        child:Text("Delete"),
                        style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.purple,
                         foregroundColor: Colors.white
                        )),
                    ),

                  ],
                ),)
              
          ]
        ),
    ),);
  }
  void moveBackward(){
    Navigator.pop(context);
  }
}