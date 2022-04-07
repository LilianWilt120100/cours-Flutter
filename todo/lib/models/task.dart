class Task {
  int id;
  String content;
  bool completed;
  DateTime createdAt;

  Task(this.id, this.content, this.completed, this.createdAt) {
    // Initialization code goes here.
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        json['id'],
        json['title'],
        json['completed'],
        DateTime.now());
  }
}