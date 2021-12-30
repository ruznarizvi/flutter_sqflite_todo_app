import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqflite_todo_app/modal/notes.dart';

class NotesSearch extends SearchDelegate<Note> {
  final List<Note> notes;
  //array is used to store the filtered notes
  List<Note> filteredNotes = [];
  NotesSearch({this.notes});

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(
        hintColor: Colors.black,
        primaryColor: Colors.white,
        textTheme: const TextTheme(
          headline6: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16,),
        )
    );
    assert(theme != null);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: Colors.black,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query == '') {
      return Container(
        color: Colors.white,
        child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.search,
                    size: 50,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Enter a note to search.',
                  style: TextStyle(color: Colors.black),
                )
              ],
            )),
      );
    } else {
      filteredNotes = [];
      getFilteredList(notes);
      if (filteredNotes.isEmpty) {
        return Container(
          color: Colors.white,
          child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.sentiment_dissatisfied,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'No results found',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              )),
        );
      } else {
        return Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: filteredNotes.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(
                  Icons.note,
                  color: Colors.black,
                ),
                title: Text(
                  filteredNotes[index].title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black),
                ),
                subtitle: Text(
                  filteredNotes[index].description,
                  style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
                onTap: () {
                  close(context, filteredNotes[index]);
                },
              );
            },
          ),
        );
      }
    }
  }

  //Search notes
  Future<List<Note>> getFilteredList(List<Note> note) async {
    for (int i = 0; i < note.length; i++) {
      //checking if entered note keyword is available in the database
      if (note[i].title.toLowerCase().contains(query) ||
          note[i].description.toLowerCase().contains(query)) {
        //the filtered note is then added to the filteredNotes array
        filteredNotes.add(note[i]);
      }
    }
    //checking if notes are being filtered correctly
    if (filteredNotes.isNotEmpty){
      debugPrint('Notes filtered successfully.');
    }else {
      debugPrint('No results found.');
    }


    return filteredNotes;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == '') {
      return Container(
        color: Colors.white,
        child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.search,
                    size: 50,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Enter a note to search',
                  style: TextStyle(color: Colors.black),
                )
              ],
            )),
      );
    } else {
      filteredNotes = [];
      getFilteredList(notes);
      if (filteredNotes.isEmpty) {
        return Container(
          color: Colors.white,
          child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.sentiment_dissatisfied,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'No results found',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              )),
        );
      } else {
        return Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: filteredNotes.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(
                  Icons.note,
                  color: Colors.black,
                ),
                title: Text(
                  filteredNotes[index].title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black),
                ),
                subtitle: Text(
                  filteredNotes[index].description,
                  style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
                onTap: () {
                  close(context, filteredNotes[index]);
                },
              );
            },
          ),
        );
      }
    }
  }
}