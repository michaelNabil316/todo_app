class Task {
  final String name;
  final String time;
  final int taskId;
  bool isDone;
  Task({this.name, this.time, this.taskId, this.isDone = false});
  void toggle() {
    isDone = !isDone;
  }
}
