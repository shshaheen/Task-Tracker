// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskState()';
}


}

/// @nodoc
class $TaskStateCopyWith<$Res>  {
$TaskStateCopyWith(TaskState _, $Res Function(TaskState) __);
}


/// Adds pattern-matching-related methods to [TaskState].
extension TaskStatePatterns on TaskState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TaskInitial value)?  initial,TResult Function( TaskLoading value)?  loading,TResult Function( TaskLoaded value)?  loaded,TResult Function( TaskError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TaskInitial() when initial != null:
return initial(_that);case TaskLoading() when loading != null:
return loading(_that);case TaskLoaded() when loaded != null:
return loaded(_that);case TaskError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TaskInitial value)  initial,required TResult Function( TaskLoading value)  loading,required TResult Function( TaskLoaded value)  loaded,required TResult Function( TaskError value)  error,}){
final _that = this;
switch (_that) {
case TaskInitial():
return initial(_that);case TaskLoading():
return loading(_that);case TaskLoaded():
return loaded(_that);case TaskError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TaskInitial value)?  initial,TResult? Function( TaskLoading value)?  loading,TResult? Function( TaskLoaded value)?  loaded,TResult? Function( TaskError value)?  error,}){
final _that = this;
switch (_that) {
case TaskInitial() when initial != null:
return initial(_that);case TaskLoading() when loading != null:
return loading(_that);case TaskLoaded() when loaded != null:
return loaded(_that);case TaskError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Task> tasks)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TaskInitial() when initial != null:
return initial();case TaskLoading() when loading != null:
return loading();case TaskLoaded() when loaded != null:
return loaded(_that.tasks);case TaskError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Task> tasks)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case TaskInitial():
return initial();case TaskLoading():
return loading();case TaskLoaded():
return loaded(_that.tasks);case TaskError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Task> tasks)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case TaskInitial() when initial != null:
return initial();case TaskLoading() when loading != null:
return loading();case TaskLoaded() when loaded != null:
return loaded(_that.tasks);case TaskError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class TaskInitial implements TaskState {
  const TaskInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskState.initial()';
}


}




/// @nodoc


class TaskLoading implements TaskState {
  const TaskLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskState.loading()';
}


}




/// @nodoc


class TaskLoaded implements TaskState {
  const TaskLoaded({required final  List<Task> tasks}): _tasks = tasks;
  

 final  List<Task> _tasks;
 List<Task> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}


/// Create a copy of TaskState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskLoadedCopyWith<TaskLoaded> get copyWith => _$TaskLoadedCopyWithImpl<TaskLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskLoaded&&const DeepCollectionEquality().equals(other._tasks, _tasks));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tasks));

@override
String toString() {
  return 'TaskState.loaded(tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class $TaskLoadedCopyWith<$Res> implements $TaskStateCopyWith<$Res> {
  factory $TaskLoadedCopyWith(TaskLoaded value, $Res Function(TaskLoaded) _then) = _$TaskLoadedCopyWithImpl;
@useResult
$Res call({
 List<Task> tasks
});




}
/// @nodoc
class _$TaskLoadedCopyWithImpl<$Res>
    implements $TaskLoadedCopyWith<$Res> {
  _$TaskLoadedCopyWithImpl(this._self, this._then);

  final TaskLoaded _self;
  final $Res Function(TaskLoaded) _then;

/// Create a copy of TaskState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tasks = null,}) {
  return _then(TaskLoaded(
tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,
  ));
}


}

/// @nodoc


class TaskError implements TaskState {
  const TaskError({required this.message});
  

 final  String message;

/// Create a copy of TaskState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskErrorCopyWith<TaskError> get copyWith => _$TaskErrorCopyWithImpl<TaskError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TaskState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $TaskErrorCopyWith<$Res> implements $TaskStateCopyWith<$Res> {
  factory $TaskErrorCopyWith(TaskError value, $Res Function(TaskError) _then) = _$TaskErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TaskErrorCopyWithImpl<$Res>
    implements $TaskErrorCopyWith<$Res> {
  _$TaskErrorCopyWithImpl(this._self, this._then);

  final TaskError _self;
  final $Res Function(TaskError) _then;

/// Create a copy of TaskState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TaskError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
