// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class Note {
  String id;
  String title;
  String somethings;
  Note({
    required this.id,
    required this.title,
    required this.somethings,
  });

  Note copyWith({
    String? id,
    String? title,
    String? somethings,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      somethings: somethings ?? this.somethings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'somethings': somethings,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as String,
      title: map['title'] as String,
      somethings: map['somethings'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Note(id: $id, title: $title, somethings: $somethings)';

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.somethings == somethings;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ somethings.hashCode;
}
