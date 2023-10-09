
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
class db {

  late Database database;
  List<Map> attendants = [];


  void createdb() {
    openDatabase(
        'connectx.db',
        version: 1,
        onCreate: (database, version) {

          print('database created');
          database
              .execute(
              'CREATE TABLE attendants (id INTEGER PRIMARY KEY , image TEXT, name TEXT, date TEXT)')
              .then((value) {
            print('table created');
          }).catchError((error) {
            print('Error When Creating Table ${error.toString()}');
          });
        },
        onOpen: (database) {
          getdb(database);
          print('database opened');
        }

    ).then((value) {
      database = value;

    });
  }

  void insertdb(
      {
        required String image,
        required String date,
        required String name,

      }) async {
    await database.transaction((txn) =>
        txn.rawInsert(
          'INSERT INTO tasks(image, name, date) VALUES("$image", "$name", "$date")',
        ).then((value) {
          print('$value inserted successfully');

          getdb(database);
        }).catchError((error) {
          print('Error When Inserting New Record ${error.toString()}');
        }));
  }

  void getdb(database)  {

    database.rawQuery('SELECT * FROM attendants').then((value){
      value.forEach((element)  {
        if(element['name']== 'Youssef')
          attendants.add(element);

      });


    });


  }




  void deleteData({
    required int id,
  }) async
  {
    database.rawDelete('DELETE FROM attendants WHERE id = ?', [id])
        .then((value)
    {
     getdb(database);

    });
  }

}