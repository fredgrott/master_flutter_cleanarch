// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// Basic entity in implementing CleanArch app architecture.
///  Notice that we can either do the hashcode and indentity 
///  stuff by hand or use Equatable. In this case I do entity by 
///  hand and the model with Equatable to show the difference.
/// 
///  We do not need entities immutable unlike models.
/// 
/// @author Fredrick Allan Grott
class TodoEntity {
  final bool complete;
  final String id;
  final String note;
  final String task;

  TodoEntity(this.task, this.id, this.note, this.complete);

  @override
  int get hashCode => complete.hashCode ^ task.hashCode ^ note.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoEntity &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          task == other.task &&
          note == other.note &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      'complete': complete,
      'task': task,
      'note': note,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'TodoEntity{complete: $complete, task: $task, note: $note, id: $id}';
  }

  TodoEntity fromJson(Map<String, Object> json) {
    return TodoEntity(
      json['task']! as String,
      json['id']! as String,
      json['note']! as String,
      json['complete']! as bool,
    );
  }
}
