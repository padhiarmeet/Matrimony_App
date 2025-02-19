// import 'package:flutter/material.dart';
// import 'package:matrihoney/database.dart';
//
//
// class dbChecker extends StatefulWidget {
//   const dbChecker({super.key});
//
//   @override
//   State<dbChecker> createState() => _dbCheckerState();
// }
//
// class _dbCheckerState extends State<dbChecker> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Text(test().toString()),
//     );
//   }
// }
//
//
// Future test()async{
//   Map<String, dynamic> user = {
//     'name': 'John Doe',
//     'email': 'johndoe@example.com',
//     'number': '1234567890',
//     'date': '1995-05-10',
//     'city': 'New York',
//     'gender': 'Male',
//     'favourite': '1',
//     'photo': 'path/to/photo.jpg',
//     'hobbies': 'Reading, Gaming',
//   };
//
//   final dbHelper = DatabaseHelper();
//
//   await dbHelper.insertUser(user);
//   List<Map<String,dynamic>> usersFromDB = await dbHelper.fetchUsers();
//   print('????????????????????????????????????????????????????????????????????? : ${usersFromDB}');
//   return(usersFromDB);
// }
//
//
