import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';
import 'state.dart';

class AppBloc extends Cubit<AppStates> {
  AppBloc() : super(AppInitialState());
  static AppBloc get(context) => BlocProvider.of(context);

  Database database;
  List<Task> task = [];
  //create new database and get the values of database
  void createDataBase() async {
    emit(AppInitialState());
    database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
      if (!kReleaseMode) print('data base created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, states TEXT)')
          .then((value) => {if (!kReleaseMode) print('table created')})
          .catchError((onError) => {
                if (!kReleaseMode)
                  print('error in create table: ${onError.toString()}')
              });
    }, onOpen: (database) {
      if (!kReleaseMode) print('table opened');
      getDatabase(database).then((value) => {
            task = value
                .map((el) => Task(
                      name: el['title'],
                      time: el['time'],
                      taskId: el['id'],
                      isDone: el['states'] == 'true' ? true : false,
                    ))
                .toList(),
            emit(SuccessfulAppState())
          });
    });
  }

  //get data from database
  Future<List<Map>> getDatabase(Database db) async {
    List<Map> tasks = await db.rawQuery('SELECT * FROM tasks');
    print(tasks);
    return tasks;
  }

  //insert new item
  void insertToDataBase(String title, String time) {
    database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks (title,date,time,states) VALUES ("$title","654","$time","false")')
          .then((value) {
        if (!kReleaseMode) print('the values is: ${value.toString()}');
        getDatabase(database).then((value) => {
              task = value
                  .map((el) => Task(
                        name: el['title'],
                        time: el['time'],
                        taskId: el['id'],
                        isDone: el['states'] == 'true' ? true : false,
                      ))
                  .toList(),
              emit(SuccessfulAppState())
            });
      }).catchError((err) {
        if (!kReleaseMode) print('error in insert table: ${err.toString()}');
      });
      return null;
    });
  }

  //delete an item from tasks in database
  void deleteTask(int id) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then(
      (value) => {
        getDatabase(database).then(
          (value) => {
            task = value
                .map((el) => Task(
                      name: el['title'],
                      time: el['time'],
                      taskId: el['id'],
                      isDone: el['states'] == 'true' ? true : false,
                    ))
                .toList(),
            emit(SuccessfulAppState())
          },
        ),
      },
    );
  }

  //update statues of the task
  void updateTask(int id, bool states) {
    database.rawUpdate(
        'UPDATE tasks SET states = ? WHERE id = ?', ['$states', id]).then(
      (value) => {
        getDatabase(database).then(
          (value) => {
            task = value
                .map((el) => Task(
                      name: el['title'],
                      time: el['time'],
                      taskId: el['id'],
                      isDone: el['states'] == 'true' ? true : false,
                    ))
                .toList(),
            emit(SuccessfulAppState())
          },
        ),
      },
    );
  }
}
