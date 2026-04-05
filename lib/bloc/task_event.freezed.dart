// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskEvent()';
}


}

/// @nodoc
class $TaskEventCopyWith<$Res>  {
$TaskEventCopyWith(TaskEvent _, $Res Function(TaskEvent) __);
}


/// Adds pattern-matching-related methods to [TaskEvent].
extension TaskEventPatterns on TaskEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchTasks value)?  fetchTasks,TResult Function( AddTask value)?  addTask,TResult Function( UpdateTask value)?  updateTask,TResult Function( DeleteTask value)?  deleteTask,TResult Function( CreateTeam value)?  createTeam,TResult Function( TaskAddedLocally value)?  taskAddedLocally,TResult Function( TaskUpdatedLocally value)?  taskUpdatedLocally,TResult Function( TaskDeletedLocally value)?  taskDeletedLocally,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchTasks() when fetchTasks != null:
return fetchTasks(_that);case AddTask() when addTask != null:
return addTask(_that);case UpdateTask() when updateTask != null:
return updateTask(_that);case DeleteTask() when deleteTask != null:
return deleteTask(_that);case CreateTeam() when createTeam != null:
return createTeam(_that);case TaskAddedLocally() when taskAddedLocally != null:
return taskAddedLocally(_that);case TaskUpdatedLocally() when taskUpdatedLocally != null:
return taskUpdatedLocally(_that);case TaskDeletedLocally() when taskDeletedLocally != null:
return taskDeletedLocally(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchTasks value)  fetchTasks,required TResult Function( AddTask value)  addTask,required TResult Function( UpdateTask value)  updateTask,required TResult Function( DeleteTask value)  deleteTask,required TResult Function( CreateTeam value)  createTeam,required TResult Function( TaskAddedLocally value)  taskAddedLocally,required TResult Function( TaskUpdatedLocally value)  taskUpdatedLocally,required TResult Function( TaskDeletedLocally value)  taskDeletedLocally,}){
final _that = this;
switch (_that) {
case FetchTasks():
return fetchTasks(_that);case AddTask():
return addTask(_that);case UpdateTask():
return updateTask(_that);case DeleteTask():
return deleteTask(_that);case CreateTeam():
return createTeam(_that);case TaskAddedLocally():
return taskAddedLocally(_that);case TaskUpdatedLocally():
return taskUpdatedLocally(_that);case TaskDeletedLocally():
return taskDeletedLocally(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchTasks value)?  fetchTasks,TResult? Function( AddTask value)?  addTask,TResult? Function( UpdateTask value)?  updateTask,TResult? Function( DeleteTask value)?  deleteTask,TResult? Function( CreateTeam value)?  createTeam,TResult? Function( TaskAddedLocally value)?  taskAddedLocally,TResult? Function( TaskUpdatedLocally value)?  taskUpdatedLocally,TResult? Function( TaskDeletedLocally value)?  taskDeletedLocally,}){
final _that = this;
switch (_that) {
case FetchTasks() when fetchTasks != null:
return fetchTasks(_that);case AddTask() when addTask != null:
return addTask(_that);case UpdateTask() when updateTask != null:
return updateTask(_that);case DeleteTask() when deleteTask != null:
return deleteTask(_that);case CreateTeam() when createTeam != null:
return createTeam(_that);case TaskAddedLocally() when taskAddedLocally != null:
return taskAddedLocally(_that);case TaskUpdatedLocally() when taskUpdatedLocally != null:
return taskUpdatedLocally(_that);case TaskDeletedLocally() when taskDeletedLocally != null:
return taskDeletedLocally(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchTasks,TResult Function( String title,  String teamId,  String? description,  String? priority,  String? assignedTo)?  addTask,TResult Function( String id,  String? title,  String? description,  String? status,  String? priority,  String? teamId,  String? assignedTo)?  updateTask,TResult Function( String id)?  deleteTask,TResult Function( String name,  String? description)?  createTeam,TResult Function( Task task)?  taskAddedLocally,TResult Function( Task task)?  taskUpdatedLocally,TResult Function( String id)?  taskDeletedLocally,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchTasks() when fetchTasks != null:
return fetchTasks();case AddTask() when addTask != null:
return addTask(_that.title,_that.teamId,_that.description,_that.priority,_that.assignedTo);case UpdateTask() when updateTask != null:
return updateTask(_that.id,_that.title,_that.description,_that.status,_that.priority,_that.teamId,_that.assignedTo);case DeleteTask() when deleteTask != null:
return deleteTask(_that.id);case CreateTeam() when createTeam != null:
return createTeam(_that.name,_that.description);case TaskAddedLocally() when taskAddedLocally != null:
return taskAddedLocally(_that.task);case TaskUpdatedLocally() when taskUpdatedLocally != null:
return taskUpdatedLocally(_that.task);case TaskDeletedLocally() when taskDeletedLocally != null:
return taskDeletedLocally(_that.id);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchTasks,required TResult Function( String title,  String teamId,  String? description,  String? priority,  String? assignedTo)  addTask,required TResult Function( String id,  String? title,  String? description,  String? status,  String? priority,  String? teamId,  String? assignedTo)  updateTask,required TResult Function( String id)  deleteTask,required TResult Function( String name,  String? description)  createTeam,required TResult Function( Task task)  taskAddedLocally,required TResult Function( Task task)  taskUpdatedLocally,required TResult Function( String id)  taskDeletedLocally,}) {final _that = this;
switch (_that) {
case FetchTasks():
return fetchTasks();case AddTask():
return addTask(_that.title,_that.teamId,_that.description,_that.priority,_that.assignedTo);case UpdateTask():
return updateTask(_that.id,_that.title,_that.description,_that.status,_that.priority,_that.teamId,_that.assignedTo);case DeleteTask():
return deleteTask(_that.id);case CreateTeam():
return createTeam(_that.name,_that.description);case TaskAddedLocally():
return taskAddedLocally(_that.task);case TaskUpdatedLocally():
return taskUpdatedLocally(_that.task);case TaskDeletedLocally():
return taskDeletedLocally(_that.id);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchTasks,TResult? Function( String title,  String teamId,  String? description,  String? priority,  String? assignedTo)?  addTask,TResult? Function( String id,  String? title,  String? description,  String? status,  String? priority,  String? teamId,  String? assignedTo)?  updateTask,TResult? Function( String id)?  deleteTask,TResult? Function( String name,  String? description)?  createTeam,TResult? Function( Task task)?  taskAddedLocally,TResult? Function( Task task)?  taskUpdatedLocally,TResult? Function( String id)?  taskDeletedLocally,}) {final _that = this;
switch (_that) {
case FetchTasks() when fetchTasks != null:
return fetchTasks();case AddTask() when addTask != null:
return addTask(_that.title,_that.teamId,_that.description,_that.priority,_that.assignedTo);case UpdateTask() when updateTask != null:
return updateTask(_that.id,_that.title,_that.description,_that.status,_that.priority,_that.teamId,_that.assignedTo);case DeleteTask() when deleteTask != null:
return deleteTask(_that.id);case CreateTeam() when createTeam != null:
return createTeam(_that.name,_that.description);case TaskAddedLocally() when taskAddedLocally != null:
return taskAddedLocally(_that.task);case TaskUpdatedLocally() when taskUpdatedLocally != null:
return taskUpdatedLocally(_that.task);case TaskDeletedLocally() when taskDeletedLocally != null:
return taskDeletedLocally(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class FetchTasks implements TaskEvent {
  const FetchTasks();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchTasks);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskEvent.fetchTasks()';
}


}




/// @nodoc


class AddTask implements TaskEvent {
  const AddTask({required this.title, required this.teamId, this.description, this.priority, this.assignedTo});
  

 final  String title;
 final  String teamId;
 final  String? description;
 final  String? priority;
 final  String? assignedTo;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddTaskCopyWith<AddTask> get copyWith => _$AddTaskCopyWithImpl<AddTask>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddTask&&(identical(other.title, title) || other.title == title)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.assignedTo, assignedTo) || other.assignedTo == assignedTo));
}


@override
int get hashCode => Object.hash(runtimeType,title,teamId,description,priority,assignedTo);

@override
String toString() {
  return 'TaskEvent.addTask(title: $title, teamId: $teamId, description: $description, priority: $priority, assignedTo: $assignedTo)';
}


}

/// @nodoc
abstract mixin class $AddTaskCopyWith<$Res> implements $TaskEventCopyWith<$Res> {
  factory $AddTaskCopyWith(AddTask value, $Res Function(AddTask) _then) = _$AddTaskCopyWithImpl;
@useResult
$Res call({
 String title, String teamId, String? description, String? priority, String? assignedTo
});




}
/// @nodoc
class _$AddTaskCopyWithImpl<$Res>
    implements $AddTaskCopyWith<$Res> {
  _$AddTaskCopyWithImpl(this._self, this._then);

  final AddTask _self;
  final $Res Function(AddTask) _then;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,Object? teamId = null,Object? description = freezed,Object? priority = freezed,Object? assignedTo = freezed,}) {
  return _then(AddTask(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String?,assignedTo: freezed == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class UpdateTask implements TaskEvent {
  const UpdateTask({required this.id, this.title, this.description, this.status, this.priority, this.teamId, this.assignedTo});
  

 final  String id;
 final  String? title;
 final  String? description;
 final  String? status;
 final  String? priority;
 final  String? teamId;
 final  String? assignedTo;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateTaskCopyWith<UpdateTask> get copyWith => _$UpdateTaskCopyWithImpl<UpdateTask>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateTask&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.assignedTo, assignedTo) || other.assignedTo == assignedTo));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,status,priority,teamId,assignedTo);

@override
String toString() {
  return 'TaskEvent.updateTask(id: $id, title: $title, description: $description, status: $status, priority: $priority, teamId: $teamId, assignedTo: $assignedTo)';
}


}

/// @nodoc
abstract mixin class $UpdateTaskCopyWith<$Res> implements $TaskEventCopyWith<$Res> {
  factory $UpdateTaskCopyWith(UpdateTask value, $Res Function(UpdateTask) _then) = _$UpdateTaskCopyWithImpl;
@useResult
$Res call({
 String id, String? title, String? description, String? status, String? priority, String? teamId, String? assignedTo
});




}
/// @nodoc
class _$UpdateTaskCopyWithImpl<$Res>
    implements $UpdateTaskCopyWith<$Res> {
  _$UpdateTaskCopyWithImpl(this._self, this._then);

  final UpdateTask _self;
  final $Res Function(UpdateTask) _then;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = freezed,Object? description = freezed,Object? status = freezed,Object? priority = freezed,Object? teamId = freezed,Object? assignedTo = freezed,}) {
  return _then(UpdateTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String?,teamId: freezed == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String?,assignedTo: freezed == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class DeleteTask implements TaskEvent {
  const DeleteTask({required this.id});
  

 final  String id;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteTaskCopyWith<DeleteTask> get copyWith => _$DeleteTaskCopyWithImpl<DeleteTask>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteTask&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'TaskEvent.deleteTask(id: $id)';
}


}

/// @nodoc
abstract mixin class $DeleteTaskCopyWith<$Res> implements $TaskEventCopyWith<$Res> {
  factory $DeleteTaskCopyWith(DeleteTask value, $Res Function(DeleteTask) _then) = _$DeleteTaskCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$DeleteTaskCopyWithImpl<$Res>
    implements $DeleteTaskCopyWith<$Res> {
  _$DeleteTaskCopyWithImpl(this._self, this._then);

  final DeleteTask _self;
  final $Res Function(DeleteTask) _then;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(DeleteTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CreateTeam implements TaskEvent {
  const CreateTeam({required this.name, this.description});
  

 final  String name;
 final  String? description;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTeamCopyWith<CreateTeam> get copyWith => _$CreateTeamCopyWithImpl<CreateTeam>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTeam&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,name,description);

@override
String toString() {
  return 'TaskEvent.createTeam(name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class $CreateTeamCopyWith<$Res> implements $TaskEventCopyWith<$Res> {
  factory $CreateTeamCopyWith(CreateTeam value, $Res Function(CreateTeam) _then) = _$CreateTeamCopyWithImpl;
@useResult
$Res call({
 String name, String? description
});




}
/// @nodoc
class _$CreateTeamCopyWithImpl<$Res>
    implements $CreateTeamCopyWith<$Res> {
  _$CreateTeamCopyWithImpl(this._self, this._then);

  final CreateTeam _self;
  final $Res Function(CreateTeam) _then;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = freezed,}) {
  return _then(CreateTeam(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class TaskAddedLocally implements TaskEvent {
  const TaskAddedLocally({required this.task});
  

 final  Task task;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskAddedLocallyCopyWith<TaskAddedLocally> get copyWith => _$TaskAddedLocallyCopyWithImpl<TaskAddedLocally>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskAddedLocally&&(identical(other.task, task) || other.task == task));
}


@override
int get hashCode => Object.hash(runtimeType,task);

@override
String toString() {
  return 'TaskEvent.taskAddedLocally(task: $task)';
}


}

/// @nodoc
abstract mixin class $TaskAddedLocallyCopyWith<$Res> implements $TaskEventCopyWith<$Res> {
  factory $TaskAddedLocallyCopyWith(TaskAddedLocally value, $Res Function(TaskAddedLocally) _then) = _$TaskAddedLocallyCopyWithImpl;
@useResult
$Res call({
 Task task
});




}
/// @nodoc
class _$TaskAddedLocallyCopyWithImpl<$Res>
    implements $TaskAddedLocallyCopyWith<$Res> {
  _$TaskAddedLocallyCopyWithImpl(this._self, this._then);

  final TaskAddedLocally _self;
  final $Res Function(TaskAddedLocally) _then;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? task = null,}) {
  return _then(TaskAddedLocally(
task: null == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as Task,
  ));
}


}

/// @nodoc


class TaskUpdatedLocally implements TaskEvent {
  const TaskUpdatedLocally({required this.task});
  

 final  Task task;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskUpdatedLocallyCopyWith<TaskUpdatedLocally> get copyWith => _$TaskUpdatedLocallyCopyWithImpl<TaskUpdatedLocally>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskUpdatedLocally&&(identical(other.task, task) || other.task == task));
}


@override
int get hashCode => Object.hash(runtimeType,task);

@override
String toString() {
  return 'TaskEvent.taskUpdatedLocally(task: $task)';
}


}

/// @nodoc
abstract mixin class $TaskUpdatedLocallyCopyWith<$Res> implements $TaskEventCopyWith<$Res> {
  factory $TaskUpdatedLocallyCopyWith(TaskUpdatedLocally value, $Res Function(TaskUpdatedLocally) _then) = _$TaskUpdatedLocallyCopyWithImpl;
@useResult
$Res call({
 Task task
});




}
/// @nodoc
class _$TaskUpdatedLocallyCopyWithImpl<$Res>
    implements $TaskUpdatedLocallyCopyWith<$Res> {
  _$TaskUpdatedLocallyCopyWithImpl(this._self, this._then);

  final TaskUpdatedLocally _self;
  final $Res Function(TaskUpdatedLocally) _then;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? task = null,}) {
  return _then(TaskUpdatedLocally(
task: null == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as Task,
  ));
}


}

/// @nodoc


class TaskDeletedLocally implements TaskEvent {
  const TaskDeletedLocally({required this.id});
  

 final  String id;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskDeletedLocallyCopyWith<TaskDeletedLocally> get copyWith => _$TaskDeletedLocallyCopyWithImpl<TaskDeletedLocally>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskDeletedLocally&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'TaskEvent.taskDeletedLocally(id: $id)';
}


}

/// @nodoc
abstract mixin class $TaskDeletedLocallyCopyWith<$Res> implements $TaskEventCopyWith<$Res> {
  factory $TaskDeletedLocallyCopyWith(TaskDeletedLocally value, $Res Function(TaskDeletedLocally) _then) = _$TaskDeletedLocallyCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$TaskDeletedLocallyCopyWithImpl<$Res>
    implements $TaskDeletedLocallyCopyWith<$Res> {
  _$TaskDeletedLocallyCopyWithImpl(this._self, this._then);

  final TaskDeletedLocally _self;
  final $Res Function(TaskDeletedLocally) _then;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(TaskDeletedLocally(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
