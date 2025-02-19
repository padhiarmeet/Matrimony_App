import 'package:flutter/material.dart';
import 'package:matrihoney/h_adduser.dart';
import 'package:matrihoney/h_userlist.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:matrihoney/homepagebuilder.dart';
import 'package:matrihoney/update.dart';

import 'database.dart';

class favourite extends StatefulWidget {
  const favourite({super.key});

  @override
  State<favourite> createState() => _favouriteState();
}

class _favouriteState extends State<favourite> {

  final dbHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.white,
              Color.fromRGBO(255, 219, 218, 1),
            ],

            radius: 0.5,
          ),
        ),
        child: SafeArea(
          child: ListView.builder(
            itemCount: DataFromDB.length,
            itemBuilder: (context, index) {

              final users = DataFromDB[index];
              print('${users['favourite']} is type ${users['favourite'].runtimeType}');
              print(users['favourite']);
              // print(DataFromDB);
              if(users['favourite'] == 0){
                return SizedBox(height:0,);
              }
              else{
                return Card(

                  color: Colors.white.withOpacity(0.8),
                  elevation: 0,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),

                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black26,
                                    width: 2.5,
                                  ),
                                  borderRadius: BorderRadius.circular(100)),
                              child: CircleAvatar(
                                backgroundImage: users['photo']== 'null'?(users['gender'] == 'Male' ?AssetImage('assets/man.png'): AssetImage('assets/girl.png')): NetworkImage(users['photo']),
                                radius: 20.0,
                              ),
                            ),
                            //Name
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(users['name'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                            ),
                            Spacer(),
                          ],
                        ),

                        //DATA
                        //Numeber
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              Text('Number :',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),),
                              SizedBox(width: 4,),
                              Text(users['number'].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
                            ],
                          ),

                        ),
                        SizedBox(height: 4,),
                        // Email
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              Text('Email :',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),),
                              SizedBox(width: 4,),
                              Text(users['email'].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
                            ],
                          ),

                        ),
                        SizedBox(height: 4,),
                        Row(

                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(onPressed: (){
                              setState(() {

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Confirm"),
                                    content: Text("Are you sure?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("Cancel", style: TextStyle(color: Colors.grey)),
                                      ),
                                      TextButton(
                                        onPressed: () async{
                                          await dbHelper.updateFav(users['id'], users['favourite']);
                                          setState(() {
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Text("Delete", style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                              icon: Icon(Icons.delete_outline_sharp),
                              color: Colors.red,
                            ),
                            IconButton(onPressed: (){
                              setState(() {

                                updateData = users;
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => (update())));
                              });
                            },
                              icon: Icon(Icons.mode_edit_outline_outlined),
                              color: Colors.blue,
                            ),
                            Row(
                              children: [

                                Text('More Data',style: TextStyle(color: Colors.black54),),
                                IconButton(onPressed: (){
                                  setState(() {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => (Homebuilder(initialIndex:1))));


                                  });
                                },
                                  icon: Icon(Icons.keyboard_arrow_right_outlined),
                                  color: Colors.black54,

                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),

    );
  }
}

