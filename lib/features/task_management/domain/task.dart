class Task {
  final String id;
  final String title;
  final String description;
  final String priority;
  final String date;
  final bool isComplete;

  Task({
    this.id = '',
    required this.title,
    required this.description,
    required this.priority,
    required this.date,
    this.isComplete = false,
  });

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      priority.hashCode ^
      date.hashCode ^
      isComplete.hashCode;

  // Generate equals/hashCode (Alt + Insert > '== and hashCode')
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Task &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.priority == priority &&
        other.date == date &&
        other.isComplete == isComplete;
  }

  // Generate copyWith (Alt + Insert > 'copyWith')
  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? priority,
    String? date,
    bool? isComplete,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      date: date ?? this.date,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'date': date,
      'isComplete': isComplete,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      priority: map['priority'],
      date: map['date'],
      isComplete: map['isComplete'],
    );
  }

  // Generate toString (Alt + Insert > 'toString()')
  @override
  String toString() {
    return 'Task(id: $id, title: $title, description: $description, priority: $priority, date: $date, isComplete: $isComplete)';
  }
}
