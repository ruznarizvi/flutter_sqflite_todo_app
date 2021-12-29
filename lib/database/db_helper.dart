import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sqflite_todo_app/modal/notes.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colColor = 'color';
  String colDate = 'date';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper
          ._createInstance();
    return _databaseHelper;
  }

  // only have a single app-wide reference to the database
  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    //notes.db is the database name
    String path = directory.path + 'notes.db';

    // Open/create the database at a given path
    var notesDatabase =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  // SQL code to create the database table
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
            '$colDescription TEXT, $colPriority INTEGER, $colColor INTEGER,$colDate TEXT)');
  }

  // READ Operation: Read all note objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await database;

   //var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');

   // using databaseHelper (alternate solution to using rawQuery)
    //notes are read using db.query() in ascending order based on the priorities set for each note
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertNote(Note note) async {
    //getting db reference
    Database db = await database;
    //running the insert command
    //our data from note is converted to map object so it can be understood by sqflite
    var result = await db.insert(noteTable, note.toMap());

    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateNote(Note note) async {
    //getting db reference
    var db = await database;

    //running the update command to update the data in noteTable via note id
    //note data is converted to map object
    var result = await db.update(noteTable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);

    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    //getting db reference
    var db = await database;

    //deleting note data via sql command
    int result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');

    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList(); // Get 'Map List' from database
    int count =
        noteMapList.length; // Count the number of map entries in db table

    List<Note> noteList = [];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }

}