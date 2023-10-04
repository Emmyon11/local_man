import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProfessionModel {
  final String name;
  final List<String> members;
  final String createdAt;
  final String uid;
  final String updatedAt;
  final String descriptiion;
  final String picture;
  ProfessionModel({
    required this.name,
    required this.members,
    required this.createdAt,
    required this.uid,
    required this.updatedAt,
    required this.descriptiion,
    required this.picture,
  });

  ProfessionModel copyWith({
    String? name,
    List<String>? members,
    String? createdAt,
    String? uid,
    String? updatedAt,
    String? descriptiion,
    String? picture,
  }) {
    return ProfessionModel(
      name: name ?? this.name,
      members: members ?? this.members,
      createdAt: createdAt ?? this.createdAt,
      uid: uid ?? this.uid,
      updatedAt: updatedAt ?? this.updatedAt,
      descriptiion: descriptiion ?? this.descriptiion,
      picture: picture ?? this.picture,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'members': members});
    result.addAll({'createdAt': createdAt});
    result.addAll({'updatedAt': updatedAt});
    result.addAll({'descriptiion': descriptiion});
    result.addAll({'picture': picture});

    return result;
  }

  factory ProfessionModel.fromMap(Map<String, dynamic> map) {
    return ProfessionModel(
      name: map['name'] ?? '',
      members: List<String>.from(map['members']),
      createdAt: map['createdAt'] ?? '',
      uid: map['\$id'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      descriptiion: map['descriptiion'] ?? '',
      picture: map['picture'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfessionModel.fromJson(String source) =>
      ProfessionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProfessionModel(name: $name, members: $members, createdAt: $createdAt, uid: $uid, updatedAt: $updatedAt, descriptiion: $descriptiion, picture: $picture)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfessionModel &&
        other.name == name &&
        listEquals(other.members, members) &&
        other.createdAt == createdAt &&
        other.uid == uid &&
        other.updatedAt == updatedAt &&
        other.descriptiion == descriptiion &&
        other.picture == picture;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        members.hashCode ^
        createdAt.hashCode ^
        uid.hashCode ^
        updatedAt.hashCode ^
        descriptiion.hashCode ^
        picture.hashCode;
  }
}
