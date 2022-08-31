import 'package:flutter/cupertino.dart';
import 'package:taskline/features/features.dart';

@immutable
class Task {
  Task({
    required this.id,
    required this.name,
    required this.status,
    DateTime? createdAt,
    this.completedAt,
  }) : this.createdAt = createdAt ?? DateTime.now();

  final String id;
  final String name;
  final TaskStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;

  Task copyWith({
    String? id,
    String? name,
    TaskStatus? status,
    DateTime? createdAt,
    DateTime? completedAt,
    // Crutch!!
    bool isCompleted = false,
  }) {
    assert(isCompleted ? completedAt != null : true);

    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: isCompleted ? completedAt : null,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] as String,
        name: json['name'] as String,
        status: TaskStatus.fromName(json['status']),

        /// For backwards compatibility with old tasks without createdAt property.
        createdAt: json['createdAt'] == null
            ? DateTime.now()
            : DateTime.parse(json['createdAt'] as String),
        completedAt: json['completedAt'] == null
            ? null
            : DateTime.parse(json['completedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status.name,
        'createdAt': createdAt.toIso8601String(),
        'completedAt': completedAt?.toIso8601String(),
      };

  @override
  String toString() =>
      'Task { id: $id, name: $name, status: $status, createdAt: $createdAt, completedAt: $completedAt }';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task &&
        other.id == id &&
        other.name == name &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ status.hashCode;
  }
}
