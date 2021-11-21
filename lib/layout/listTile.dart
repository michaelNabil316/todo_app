import 'package:flutter/material.dart';
import 'package:todoey_flutter2/bloc/bloc.dart';

class Listtile extends StatelessWidget {
  final String title;
  final String time;
  final bool ischecked;
  final int id;
  final Function checkboxCallBack;
  Listtile(
      this.title, this.time, this.ischecked, this.id, this.checkboxCallBack);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Dismissible(
        background: Container(color: Colors.white),
        key: ValueKey(id.toString()),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.lightBlueAccent,
            radius: 30,
            child: Text(
              '$time',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
                fontSize: 18.0,
                decoration: ischecked ? TextDecoration.lineThrough : null),
          ),
          trailing: Checkbox(
            activeColor: Colors.lightBlueAccent,
            value: ischecked,
            onChanged: checkboxCallBack,
          ),
          //onLongPress: () => AppBloc.get(context).deleteTask(id),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: Icon(Icons.delete),
        ),
        onDismissed: (v) {
          AppBloc.get(context).deleteTask(id);
        },
      ),
    );
  }
}
