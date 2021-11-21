import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey_flutter2/bloc/bloc.dart';
import 'package:todoey_flutter2/bloc/state.dart';
import 'package:todoey_flutter2/layout/listViews.dart';
import 'package:todoey_flutter2/layout/no_tasks.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
          color: Colors.white,
        ),
        child: BlocBuilder<AppBloc, AppStates>(builder: (context, state) {
          if (state is AppInitialState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (AppBloc.get(context).task.length > 0) {
              return Listview('all');
            } else {
              return NoTasksWidget();
            }
          }
        }),
      ),
    );
  }
}
