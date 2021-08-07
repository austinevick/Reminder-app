class Reminder {
  int id;
  final String title;
  final String content;
  final String category;
  final DateTime dateCreated;
  final DateTime scheduledDate;
  final String scheduledTime;
  final bool isImportant;
  bool isActive;

  Reminder({
    this.id,
    this.title,
    this.content,
    this.category,
    this.dateCreated,
    this.scheduledDate,
    this.scheduledTime,
    this.isActive,
    this.isImportant,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'dateCreated': dateCreated.toIso8601String(),
      'scheduledDate': scheduledDate.toIso8601String(),
      'scheduledTime': scheduledTime,
      'isActive': isActive ? 0 : 1,
      'isImportant': isImportant ? 0 : 1,
    };
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      category: map['category'],
      dateCreated: DateTime.parse(map['dateCreated'] as String),
      scheduledDate: DateTime.parse(map['scheduledDate'] as String),
      scheduledTime: map['scheduledTime'],
      isActive: map['isActive'] == 0,
      isImportant: map['isImportant'] == 0,
    );
  }

  @override
  String toString() {
    return 'Reminder(id: $id, title: $title, content: $content, category: $category, dateCreated: $dateCreated, scheduledDate: $scheduledDate, scheduledTime: $scheduledTime, isActive: $isActive, isImportant: $isImportant)';
  }
}
