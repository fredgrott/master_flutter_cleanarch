// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:data_domain_layers/domain/entities/todo_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

/// Okay, short course on Models:
/// 1. Enums are immutable which is why we use them as models and why enhanced enums with mixins and 
///     interfaces is such as win for using Enums as models. And, yes, this could have been 
///     re-implemented as set of Enums.
///  2. We use immutable models so that we have a UDF(Unidirectional Data Flow) to go along 
///       with mataining and managing state in a declarative UI. Benefits are performance via 
///       the compiler as they are treated just like const fields and of course they are thread safe.
///        And, of course, predictable state and state transitions.
///   3. That also implies that ThemeData is mutable and is one of the performance bottlenecks 
///        as far as compilied code performance.
///   4. We have two observer groups in Flutter,  ChangeNotifier (mutable) and ValueNotifier(immutable).
///        ChangeNotifier can only use mutable models and no Collections and ValueNotifier can only use 
///        immutable models but no collections. This is one of the contributing factors to why we look 
///        outside of the Flutter SDK for state management systems as we do not have an adequate 
///        observer solution for complex models that use Colllections.
///   5. Temporary solution until meta static programming is in the stable branch of the Flutter SDK 
///        as at that time will be able to switch from Equatable package to data_class package which 
///         uses meta static programming to replace what Equatable does with real data class generation
///        without the pain of build runner.
///   6. So to mutate a Todo model we use the Todo.copyWith() method to get our new mutated Todo.
///   7. A further twist is when we get Value Classes and the elimination of const objects which will 
///        not be until end of 2025.
/// 
///  @author Fredrick Allan Grott
@immutable
class Todo extends Equatable {
  final bool complete;
  final String id;
  final String note;
  final String task;

  Todo(this.task, {this.complete = false, String note = '', String? id})
      : note = '',
        id = id ?? const Uuid().v4(),
        super();

  Todo copyWith({bool? complete, String? id, String? note, String? task}) {
    return Todo(
      task ?? this.task,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      note: note ?? this.note,
    );
  }

  @override
  String toString() {
    return 'Todo { complete: $complete, task: $task, note: $note, id: $id }';
  }

  TodoEntity toEntity() {
    return TodoEntity(task, id, note, complete);
  }

  Todo fromEntity(TodoEntity entity) {
    return Todo(
      entity.task,
      complete: entity.complete,
      note: entity.note,
      id: entity.id,
    );
  }

  @override
  List<Object?> get props => [
        task,
        note,
        id,
      ];
}
