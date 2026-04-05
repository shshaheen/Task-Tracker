// ---------------------------------------------------------------------------
// Task — Immutable data class
//
// No json_serializable / json_annotation used.
// fromJson is written by hand and maps MongoDB's "_id" field to [id].
// ---------------------------------------------------------------------------

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
  ///
  /// MongoDB stores the primary key as `_id`, so we explicitly map it here.
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: json['status'] as String,
      priority: json['priority'] as String? ?? 'medium',
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
