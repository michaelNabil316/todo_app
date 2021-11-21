import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey_flutter2/bloc/bloc.dart';
import 'package:todoey_flutter2/bloc/state.dart';
import 'package:todoey_flutter2/layout/listTile.dart';
import 'package:todoey_flutter2/models/task.dart';

class Listview extends StatelessWidget {
  final listType;
  Listview(this.listType);
  @override
  Widget build(BuildContext context) {
    final cubit = AppBloc.get(context);

    return BlocBuilder<AppBloc, AppStates>(
      builder: (context, state) {
        //witch list to appear in the screens
        List<Task> doneL = [];
        List<Task> archL = [];
        List<Task> listTypeFun() {
          if (listType == 'all')
            return cubit.task;
          else if (listType == 'done') {
            for (var element in cubit.task) {
              if (element.isDone == true) doneL.add(element);
            }
            return doneL;
          } else if (listType == 'arch') {
            for (var element in cubit.task) {
              if (element.isDone == false) archL.add(element);
            }
            return archL;
          } else
            return [];
        }

        List<Task> apperanceList = listTypeFun();

        //which state is emmited
        if (state is SuccessfulAppState)
          return ListView.separated(
            itemBuilder: (context, index) {
              return Listtile(
                apperanceList[index].name,
                apperanceList[index].time,
                apperanceList[index].isDone,
                apperanceList[index].taskId,
                (checkState) {
                  cubit.updateTask(
                    apperanceList[index].taskId,
                    !apperanceList[index].isDone,
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.grey[400],
                height: 1,
              );
            },
            itemCount: apperanceList.length,
          );
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
