class TodoModel {
  String title;
  bool isCompleted;
  DateTime expire;

  TodoModel({
    required this.title,
    required this.isCompleted,
    required this.expire,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      title: json['title'],
      isCompleted: json['isCompleted'],
      expire: json['expire'],
    );
  }
}
