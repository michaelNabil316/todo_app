import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../bloc/bloc.dart';

final formKey = GlobalKey<FormState>();
var titleController = TextEditingController();
var timeController = TextEditingController();

class BuilBottemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.lightBlueAccent),
            ),
            TextFieldModule(
              controller: titleController,
              icon: Icons.text_fields_outlined,
              inputType: TextInputType.text,
              label: 'title',
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFieldModule(
              controller: timeController,
              icon: Icons.watch_later_outlined,
              inputType: TextInputType.datetime,
              label: 'time',
              ontap: () {
                showTimePicker(context: context, initialTime: TimeOfDay.now())
                    .then((value) =>
                        {timeController.text = value.format(context)});
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              //color: Colors.lightBlueAccent,
              child: Text('Add'),
              onPressed: () {
                if (formKey.currentState.validate()) {
                  AppBloc.get(context).insertToDataBase(
                      titleController.text, '${timeController.text}');
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldModule extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType inputType;
  final Function ontap;

  const TextFieldModule({
    Key key,
    this.controller,
    this.label,
    this.icon,
    this.inputType,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'please enter a value';
          }
          return null;
        },
        onTap: ontap,
      ),
    );
  }
}
