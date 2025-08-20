import 'package:cloud_firestore/cloud_firestore.dart';

class Event{
  String? id;
  String? title;
  String? description;
  String? type;
  Timestamp? date;
  double? latitude;
  double? longitude;
  Event({this.date , this.id , this.title , this.description ,this.type, this.latitude ,this.longitude});

  Event.fromFirestore(Map<String,dynamic>? data){
    id = data?["id"];
    title = data?["title"];
    description = data?["description"];
    type = data?["type"];
    date = data?["date"];
    latitude = data?["latitude"];
    longitude = data?["longitude"];
  }

  Map<String,dynamic> toFirestore(){
    return {
      "id":id,
      "description":description,
      "title":title,
      "type":type,
      "date":date,
      "latitude":latitude,
      "longitude":longitude,
    };
  }
}