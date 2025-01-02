import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:my_sqflite_project/models/note.dart';

 class DatabaseHelper {
   static DatabaseHelper? _databaseHelper; //singleton Databasehelper
   static Database? _database;

   String noteTable = 'note_table';
   String colId = 'id';
   String colTitle = 'title';
   String colDescription = 'description';
   String colPriority = 'priority';
   String colDate = 'date';


  DatabaseHelper._createInstance(); //Named constructor to crate an instance

  factory DatabaseHelper(){
    if (_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance(); //it is execute only once,singleton object
    }
    return _databaseHelper!;
  }
  Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';
    //open/create the database at given path

    var notesDatabase = await openDatabase(path , version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db,int newVersion) async{
    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT,$colDescription TEXT,$colPriority INT,$colDate TEXT)');
  }

  //fetch operation get all obj from the database
    
  
  Future<List<Map<String,dynamic>>> getNoteMapList() async{
    Database db = await this.database;
    var result = await db.query(noteTable,orderBy: '$colPriority ASC');
    return result;
  }
  //insert operation insert a noteobjct to database
   Future<int> insertNote(Note note) async{
    Database db = await this.database;
    var result = await db.insert(noteTable,note.toMap());
    return result;
   }
   //Update operation update a note objct and save it to databse
   Future<int> updateNote(Note note) async{
    Database db = await this.database;
    var result = await db.update(noteTable,note.toMap(),where: '$colId=?',whereArgs: [note.id]);
    return result;
   }
   //Delete operation
   Future<int> deleteNote(int id) async{
    var db = await this.database;
    var result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId=id');
    return result;
   }
   //Get number of objects in the database
   Future<int> getCount() async{
    Database db = await this.database;
    List<Map<String,dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable ');
    int? result = Sqflite.firstIntValue(x);
    return result ?? 0;
   }
   //get maplist and convert it to notelist
   Future<List<Note>>getNoteList()async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;
    List<Note> noteList = List<Note>();
    for(int i = 0;i<count;i++){
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }
      return noteList;
    }
    
 }

   

 