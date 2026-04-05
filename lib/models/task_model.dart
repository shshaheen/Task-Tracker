class Task {
  final String id;
  final String title;
  final String? description;
  final String status;
  final String priority;

  const Task({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    this.priority = 'medium',
  });

  /// Parses a task from the JSON object returned by the backend.
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: json['status'] as String,
      priority: json['priority'] as String? ?? 'medium',
    );
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? status,
    String? priority,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          status == other.status &&
          priority == other.priority;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      (description?.hashCode ?? 0) ^
      status.hashCode ^
      priority.hashCode;
}
