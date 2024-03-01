//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// GENERATED BY XYZ_GEN - DO NOT MODIFY BY HAND
// See: https://github.com/robmllze/xyz_gen
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

// ignore_for_file: annotate_overrides
// ignore_for_file: empty_constructor_bodies
// ignore_for_file: invalid_null_aware_operator
// ignore_for_file: overridden_fields
// ignore_for_file: unnecessary_non_null_assertion
// ignore_for_file: unnecessary_null_comparison
// ignore_for_file: unnecessary_this

part of 'model_user.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class ModelUser extends _ModelUser {
  //
  //
  //

  static const K_ARGS = "args";
  static const K_ID = "id";
  static const K_ROLE = "role";
  static const K_USER_PUB_ID = "user_pub_id";

  String? role;
  String? userPubId;

  //
  //
  //

  ModelUser({
    String? id,
    dynamic args,
    this.role,
    this.userPubId,
  }) : super._() {
    this.id = id;
    this.args = args;
  }

  //
  //
  //

  ModelUser.unsafe({
    String? id,
    dynamic args,
    this.role,
    this.userPubId,
  }) : super._() {
    this.id = id;
    this.args = args;
  }

  //
  //
  //

  factory ModelUser.from(
    ModelUser other,
  ) {
    return ModelUser.unsafe()..updateWith(other);
  }

  //
  //
  //

  factory ModelUser.fromJson(
    String source,
  ) {
    try {
      final decoded = jsonDecode(source);
      return ModelUser.fromJMap(decoded);
    } catch (e) {
      assert(false, e);
      rethrow;
    }
  }

  //
  //
  //

  factory ModelUser.fromJMap(
    Map<String, dynamic> input,
  ) {
    try {
      return ModelUser.unsafe(
        args: input[K_ARGS],
        id: input[K_ID]?.toString().trim().nullIfEmpty,
        role: input[K_ROLE]?.toString().trim().nullIfEmpty,
        userPubId: input[K_USER_PUB_ID]?.toString().trim().nullIfEmpty,
      );
    } catch (e) {
      assert(false, e);
      rethrow;
    }
  }

  //
  //
  //

  @override
  Map<String, dynamic> toJMap({
    dynamic defaultValue,
    bool includeNulls = false,
  }) {
    try {
      final withNulls = <String, dynamic>{
        K_ARGS: args,
        K_ID: id?.toString().trim().nullIfEmpty,
        K_ROLE: role?.toString().trim().nullIfEmpty,
        K_USER_PUB_ID: userPubId?.toString().trim().nullIfEmpty,
      }.mapWithDefault(defaultValue);
      return includeNulls ? withNulls : withNulls.nonNulls;
    } catch (e) {
      assert(false, e);
      rethrow;
    }
  }

  //
  //
  //

  @override
  T empty<T extends Model>() {
    return ModelUser.unsafe() as T;
  }

  //
  //
  //

  @override
  T copy<T extends Model>() {
    return (ModelUser.unsafe()..updateWith(this)) as T;
  }

  //
  //
  //

  @override
  T copyWith<T extends Model>(
    T other,
  ) {
    if (other is ModelUser) {
      return this.copy<T>()..updateWith(other);
    }
    assert(false);
    return this.copy<T>();
  }

  //
  //
  //

  @override
  T copyWithJMap<T extends Model>(
    JMap other,
  ) {
    if (other.isNotEmpty) {
      return this.copy<T>()..updateWithJMap(other);
    }
    return this.copy<T>();
  }

  //
  //
  //

  @override
  void updateWith<T extends Model>(
    T other,
  ) {
    if (other is ModelUser) {
      this.args = other.args ?? this.args;
      this.id = other.id ?? this.id;
      this.role = other.role ?? this.role;
      this.userPubId = other.userPubId ?? this.userPubId;
    } else {
      assert(false);
    }
  }

  //
  //
  //

  @override
  void updateWithJMap<T extends Model>(
    JMap other,
  ) {
    this.updateWith(ModelUser.fromJMap(other));
  }
}