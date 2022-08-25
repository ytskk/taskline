import 'package:flutter/cupertino.dart';
import 'package:taskline/features/features.dart';

@immutable
class Task {
  const Task({
    required this.id,
    required this.name,
    required this.status,
  });

  final String id;
  final String name;
  final TaskStatus status;

  Task copyWith({
    String? id,
    String? name,
    TaskStatus? status,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] as String,
        name: json['name'] as String,
        status: TaskStatus.fromName(json['status']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status.name,
      };

  @override
  String toString() => 'Task(id: $id, name: $name, status: $status)';

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
