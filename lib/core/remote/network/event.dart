import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String? id;
  String? title;
  String? description;
  Timestamp? date;
  String? type;

  Event({
    this.id,
    this.title,
    this.description,
    this.date,
    this.type,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'type': type,
    };
  }

  factory Event.fromFirestore(Map<String, dynamic>? data) {
    if (data == null) return Event();
    return Event(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      date: data['date'],
      type: data['type'],
    );
  }
}
