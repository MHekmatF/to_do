import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;
  TaskModel(
      {this.id = '',
      required this.title,
      required this.description,
      required this.dateTime,
      this.isDone = false});
  // factory TaskModel.fromJson(Map<String, dynamic> json) {
  //   return TaskModel(
  //       id: json['id'],
  //       title: json['title'],
  //       description: json['description'],
  //       dateTime: json['dateTime'],
  //       isDone: json['isDone']);
  // }

  /*
  * here named constructure coz i don't have dart object i have json and i wnat to create object from it
  *
  * */
  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            title: json['title'],
            description: json['description'],
            // dateTime: json['dateTime'].toDate(),
            dateTime: (json['dateTime'] as Timestamp).toDate(),
            isDone: json['isDone']);
/*
* here method coz i have dart object i will call it from object
*
* */
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "dateTime": Timestamp.fromDate(dateTime),
        "isDone": isDone,
      };
}

//Json -> Map<String,dynamic>
//Json -> Map<String,Object?>
