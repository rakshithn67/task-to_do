// class Task {
//   late String? id;
//   late String title;
//   late String description;
//
//   Task({this.id, required this.title, required this.description});
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//     };
//   }
// }

class User {
  String id;
  String title;
  String description;

  User({required this.id, required this.title, required this.description});
}