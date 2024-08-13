import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskModel {
  String id;
  String title;
  String description;
  bool isDone;
  int date;
  TimeOfDay? time;// Nullable TimeOfDay field
  String userId;
  Timestamp? createdAt; // Add this field

  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    this.id = "",
    this.isDone = false,
    this.time,
    this.createdAt,// Initialize TimeOfDay
    required this.userId,
  });

  TaskModel.fromJson(Map<String, dynamic> data)
      : this(
    id: data["id"],
    date: data["date"],
    description: data["description"],
    title: data["title"],
    isDone: data["isDone"],
    time: data["time"] != null
        ? TimeOfDay(
      hour: data["time"]["hour"],
      minute: data["time"]["minute"],
    )
        : null,  // Deserialize TimeOfDay
    userId: data["userId"],
    createdAt: data['createdAt'], // Parse creation time
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "isDone": isDone,
      "time": time != null
          ? {'hour': time!.hour, 'minute': time!.minute}
          : null,  // Serialize TimeOfDay
      "userId": userId,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(), // Set creation time
    };
  }
}
