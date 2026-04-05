class Task {
  final String id;
  final String title;
  final String? description;
  final String status;
  final String priority;
  final String teamId;
  final String? createdBy;
  final String? assignedTo;

  const Task({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.priority,
    required this.teamId,
    this.createdBy,
    this.assignedTo,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: (json['_id'] ?? '').toString(),
      title: (json['title'] ?? 'Untitled Task').toString(),
      description: json['description']?.toString(),
      status: (json['status'] ?? 'todo').toString(),
      priority: (json['priority'] ?? 'medium').toString(),
      teamId: (json['teamId'] ?? '').toString(),
      createdBy: json['createdBy']?.toString(),
      assignedTo: json['assignedTo']?.toString(),
    );
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? status,
    String? priority,
    String? teamId,
    String? createdBy,
    String? assignedTo,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      teamId: teamId ?? this.teamId,
      createdBy: createdBy ?? this.createdBy,
      assignedTo: assignedTo ?? this.assignedTo,
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
          priority == other.priority &&
          teamId == other.teamId;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      (description?.hashCode ?? 0) ^
      status.hashCode ^
      priority.hashCode ^
      teamId.hashCode;
}
