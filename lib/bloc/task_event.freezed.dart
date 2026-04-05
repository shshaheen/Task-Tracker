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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchTasks value)?  fetchTasks,TResult Function( AddTask value)?  addTask,TResult Function( UpdateTask value)?  updateTask,TResult Function( DeleteTask value)?  deleteTask,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchTasks() when fetchTasks != null:
return fetchTasks(_that);case AddTask() when addTask != null:
return addTask(_that);case UpdateTask() when updateTask != null:
return updateTask(_that);case DeleteTask() when deleteTask != null:
return deleteTask(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchTasks value)  fetchTasks,required TResult Function( AddTask value)  addTask,required TResult Function( UpdateTask value)  updateTask,required TResult Function( DeleteTask value)  deleteTask,}){
final _that = this;
switch (_that) {
case FetchTasks():
return fetchTasks(_that);case AddTask():
return addTask(_that);case UpdateTask():
return updateTask(_that);case DeleteTask():
return deleteTask(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchTasks value)?  fetchTasks,TResult? Function( AddTask value)?  addTask,TResult? Function( UpdateTask value)?  updateTask,TResult? Function( DeleteTask value)?  deleteTask,}){
final _that = this;
switch (_that) {
case FetchTasks() when fetchTasks != null:
return fetchTasks(_that);case AddTask() when addTask != null:
return addTask(_that);case UpdateTask() when updateTask != null:
return updateTask(_that);case DeleteTask() when deleteTask != null:
return deleteTask(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchTasks,TResult Function( String title,  String? description,  String? priority)?  addTask,TResult Function( String id,  String? title,  String? description,  String? status,  String? priority)?  updateTask,TResult Function( String id)?  deleteTask,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchTasks() when fetchTasks != null:
return fetchTasks();case AddTask() when addTask != null:
return addTask(_that.title,_that.description,_that.priority);case UpdateTask() when updateTask != null:
return updateTask(_that.id,_that.title,_that.description,_that.status,_that.priority);case DeleteTask() when deleteTask != null:
return deleteTask(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchTasks,required TResult Function( String title,  String? description,  String? priority)  addTask,required TResult Function( String id,  String? title,  String? description,  String? status,  String? priority)  updateTask,required TResult Function( String id)  deleteTask,}) {final _that = this;
switch (_that) {
case FetchTasks():
return fetchTasks();case AddTask():
return addTask(_that.title,_that.description,_that.priority);case UpdateTask():
return updateTask(_that.id,_that.title,_that.description,_that.status,_that.priority);case DeleteTask():
return deleteTask(_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchTasks,TResult? Function( String title,  String? description,  String? priority)?  addTask,TResult? Function( String id,  String? title,  String? description,  String? status,  String? priority)?  updateTask,TResult? Function( String id)?  deleteTask,}) {final _that = this;
switch (_that) {
case FetchTasks() when fetchTasks != null:
return fetchTasks();case AddTask() when addTask != null:
return addTask(_that.title,_that.description,_that.priority);case UpdateTask() when updateTask != null:
return updateTask(_that.id,_that.title,_that.description,_that.status,_that.priority);case DeleteTask() when deleteTask != null:
return deleteTask(_that.id);case _:
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
  const AddTask({required this.title, this.description, this.priority});
  

 final  String title;
 final  String? description;
 final  String? priority;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddTaskCopyWith<AddTask> get copyWith => _$AddTaskCopyWithImpl<AddTask>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddTask&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,priority);

@override
String toString() {
  return 'TaskEvent.addTask(title: $title, description: $description, priority: $priority)';
}


}

/// @nodoc
abstract mixin class $AddTaskCopyWith<$Res> implements $TaskEventCopyWith<$Res> {
  factory $AddTaskCopyWith(AddTask value, $Res Function(AddTask) _then) = _$AddTaskCopyWithImpl;
@useResult
$Res call({
 String title, String? description, String? priority
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
@pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = freezed,Object? priority = freezed,}) {
  return _then(AddTask(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class UpdateTask implements TaskEvent {
  const UpdateTask({required this.id, this.title, this.description, this.status, this.priority});
  

 final  String id;
 final  String? title;
 final  String? description;
 final  String? status;
 final  String? priority;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateTaskCopyWith<UpdateTask> get copyWith => _$UpdateTaskCopyWithImpl<UpdateTask>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateTask&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,status,priority);

@override
String toString() {
  return 'TaskEvent.updateTask(id: $id, title: $title, description: $description, status: $status, priority: $priority)';
}


}

/// @nodoc
abstract mixin class $UpdateTaskCopyWith<$Res> implements $TaskEventCopyWith<$Res> {
  factory $UpdateTaskCopyWith(UpdateTask value, $Res Function(UpdateTask) _then) = _$UpdateTaskCopyWithImpl;
@useResult
$Res call({
 String id, String? title, String? description, String? status, String? priority
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
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = freezed,Object? description = freezed,Object? status = freezed,Object? priority = freezed,}) {
  return _then(UpdateTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
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

// dart format on
