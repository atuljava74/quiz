import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  DateTime lastAttemptDate;
  int currentStreak;
  int correctAttempts;
  int totalQuizAttempted;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.lastAttemptDate,
    required this.currentStreak,
    required this.correctAttempts,
    required this.totalQuizAttempted,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      lastAttemptDate: (json['lastAttemptDate'] as Timestamp).toDate(),
      currentStreak: json['currentStreak'],
      correctAttempts: json['correctAttempts'],
      totalQuizAttempted: json['totalQuizAttempted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'lastAttemptDate': Timestamp.fromDate(lastAttemptDate),
      'currentStreak': currentStreak,
      'correctAttempts': correctAttempts,
      'totalQuizAttempted': totalQuizAttempted,
    };
  }
}