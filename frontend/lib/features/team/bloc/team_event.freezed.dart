// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeamEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeamEvent()';
}


}

/// @nodoc
class $TeamEventCopyWith<$Res>  {
$TeamEventCopyWith(TeamEvent _, $Res Function(TeamEvent) __);
}


/// Adds pattern-matching-related methods to [TeamEvent].
extension TeamEventPatterns on TeamEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchTeams value)?  fetchTeams,TResult Function( CreateTeam value)?  createTeam,TResult Function( DeleteTeam value)?  deleteTeam,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchTeams() when fetchTeams != null:
return fetchTeams(_that);case CreateTeam() when createTeam != null:
return createTeam(_that);case DeleteTeam() when deleteTeam != null:
return deleteTeam(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchTeams value)  fetchTeams,required TResult Function( CreateTeam value)  createTeam,required TResult Function( DeleteTeam value)  deleteTeam,}){
final _that = this;
switch (_that) {
case FetchTeams():
return fetchTeams(_that);case CreateTeam():
return createTeam(_that);case DeleteTeam():
return deleteTeam(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchTeams value)?  fetchTeams,TResult? Function( CreateTeam value)?  createTeam,TResult? Function( DeleteTeam value)?  deleteTeam,}){
final _that = this;
switch (_that) {
case FetchTeams() when fetchTeams != null:
return fetchTeams(_that);case CreateTeam() when createTeam != null:
return createTeam(_that);case DeleteTeam() when deleteTeam != null:
return deleteTeam(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchTeams,TResult Function( String name,  String? description)?  createTeam,TResult Function( String id)?  deleteTeam,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchTeams() when fetchTeams != null:
return fetchTeams();case CreateTeam() when createTeam != null:
return createTeam(_that.name,_that.description);case DeleteTeam() when deleteTeam != null:
return deleteTeam(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchTeams,required TResult Function( String name,  String? description)  createTeam,required TResult Function( String id)  deleteTeam,}) {final _that = this;
switch (_that) {
case FetchTeams():
return fetchTeams();case CreateTeam():
return createTeam(_that.name,_that.description);case DeleteTeam():
return deleteTeam(_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchTeams,TResult? Function( String name,  String? description)?  createTeam,TResult? Function( String id)?  deleteTeam,}) {final _that = this;
switch (_that) {
case FetchTeams() when fetchTeams != null:
return fetchTeams();case CreateTeam() when createTeam != null:
return createTeam(_that.name,_that.description);case DeleteTeam() when deleteTeam != null:
return deleteTeam(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class FetchTeams implements TeamEvent {
  const FetchTeams();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchTeams);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeamEvent.fetchTeams()';
}


}




/// @nodoc


class CreateTeam implements TeamEvent {
  const CreateTeam({required this.name, this.description});
  

 final  String name;
 final  String? description;

/// Create a copy of TeamEvent
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
  return 'TeamEvent.createTeam(name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class $CreateTeamCopyWith<$Res> implements $TeamEventCopyWith<$Res> {
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

/// Create a copy of TeamEvent
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


class DeleteTeam implements TeamEvent {
  const DeleteTeam({required this.id});
  

 final  String id;

/// Create a copy of TeamEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteTeamCopyWith<DeleteTeam> get copyWith => _$DeleteTeamCopyWithImpl<DeleteTeam>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteTeam&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'TeamEvent.deleteTeam(id: $id)';
}


}

/// @nodoc
abstract mixin class $DeleteTeamCopyWith<$Res> implements $TeamEventCopyWith<$Res> {
  factory $DeleteTeamCopyWith(DeleteTeam value, $Res Function(DeleteTeam) _then) = _$DeleteTeamCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$DeleteTeamCopyWithImpl<$Res>
    implements $DeleteTeamCopyWith<$Res> {
  _$DeleteTeamCopyWithImpl(this._self, this._then);

  final DeleteTeam _self;
  final $Res Function(DeleteTeam) _then;

/// Create a copy of TeamEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(DeleteTeam(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
