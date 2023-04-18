class TodoItem {
  final String title;
  final String description;
  final DateTime createdAt;
  bool isCompleted;

  TodoItem({
    required this.title,
    required this.description,
    required this.createdAt,
    this.isCompleted = false,
  });
}