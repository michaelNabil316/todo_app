import 'package:flutter/material.dart';
import 'package:todoey_flutter2/screens/archeived_screen.dart';
import 'package:todoey_flutter2/screens/done_screen.dart';
import 'package:todoey_flutter2/screens/taskScreen.dart';

List<BottomNavigationBarItem> screensNavBarItems = [
  BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'tasks'),
  BottomNavigationBarItem(
      icon: Icon(Icons.check_circle_outline), label: 'done'),
  BottomNavigationBarItem(
      icon: Icon(Icons.archive_rounded), label: 'archevied'),
];

List<Widget> screens = [
  TasksScreen(),
  DoneScreen(),
  ArchScreen(),
];
