import 'package:flutter/material.dart';
import 'package:matrihoney/h_adduser.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:matrihoney/h_favourite.dart';
import 'package:matrihoney/update.dart';

import 'database.dart';

int updateIndex = 0;

List<Map<String,dynamic>> favList = [];
Map<String,dynamic> updateData = {};


final dbHelper = DatabaseHelper();


class userList extends StatefulWidget {
  const userList({super.key});

  @override
  State<userList> createState() => _userListState();
}

class _userListState extends State<userList>{

  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredUsers = [];

  //sort lists

  List<Map<String,dynamic>> sortedList = List.from(DataFromDB);

  String sortValue = '';

  void getDataList()async{
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    dbHelper.fetchUsers();
    dbHelper.initDatabase();

    super.initState();
    dbHelper.fetchUsers().then((value) {
      setState(() {
        filteredUsers = List.from(DataFromDB);
      });
    });
  }

  void filterUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredUsers = List.from(DataFromDB);
      } else {
        filteredUsers = DataFromDB
            .where((user) => user['name'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void sortList(String sortName){
    setState(() {
      if (filteredUsers.isNotEmpty) {
        sortedList = List.from(filteredUsers);
      } else {
        sortedList = List.from(DataFromDB);
      }


      if(sortName == 'A-Z'){
        sortedList.sort((a, b) => a['name'].toString().compareTo(b['name'].toString()));
        print(sortedList);
      }
      else if(sortName == 'Z-A'){
        sortedList.sort((a, b) => a['name'].toString().compareTo(b['name'].toString()));
        sortedList = sortedList.reversed.toList();
        print(sortedList);
      }
      else if(sortName == 'City'){
        sortedList.sort((a, b) => a['city'].toString().compareTo(b['city'].toString()));
        print(sortedList);
      }
      filteredUsers = List.from(sortedList);
    });
  }

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
            // center: Alignment.topCenter,
            radius: 0.5,
          ),
        ),
        child: SafeArea(
          child:
          Column(
            children: [
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: filterUsers,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    hintText: 'Search Users',
                    prefixIcon: Icon(Icons.search),
                    // suffixIcon: Icon(Icons.clear),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 5),
                // padding: EdgeInsets.symmetric(horizontal: ),
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(color: Colors.black12),
                ),
                child: DropdownButton<String>(
                  icon: Icon(Icons.sort, color: Colors.black54),
                  value: sortValue.isEmpty ? null : sortValue,
                  // hint: Text('sort', style: TextStyle(fontSize: 18)),
                  underline: Container(),
                  isExpanded: false,
                  isDense: true, // Makes the dropdown more compact
                  items: ['A-Z', 'Z-A', 'City']
                      .map((option) => DropdownMenuItem(
                    value: option,
                    child: Text(
                      option,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      sortValue = value!;
                      sortList(sortValue);
                    });
                  },
                ),
              )
            ],
          ),
        ),
          Expanded(
            child:
            filteredUsers.isEmpty
                ? Center(child: Text('No users available'))
                : ListView.builder(
              itemCount:  filteredUsers.isEmpty ? (sortValue ==''? DataFromDB.length:sortedList.length) : filteredUsers.length,
              itemBuilder: (context, index) {

                final user = filteredUsers.isEmpty ?(sortValue == ''? DataFromDB[index] : sortedList[index]) : filteredUsers[index];

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
                                    color: Colors.black12,
                                    width: 2.5,
                                  ),
                                  borderRadius: BorderRadius.circular(100)),
                              child: CircleAvatar(

                                radius: 20.0,
                                backgroundImage: user['photo'] == 'null' ?(user['gender'] == 'Male' ?AssetImage('assets/man.png'): AssetImage('assets/girl.png')): NetworkImage(user['photo']),
                              ),
                            ),
                            Padding(

                              padding: const EdgeInsets.all(8.0),
                              child: Text(user['name'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                            ),
                            Spacer(),
                            IconButton(icon: user['favourite'] == 1? Icon(Icons.favorite_sharp,color: Colors.red,) : Icon(Icons.favorite_border_sharp),
                              onPressed: () async{
                                await dbHelper.updateFav(user['id'], user['favourite']);
                                await dbHelper.fetchUsers();

                              setState(() {
                                filteredUsers = List.from(DataFromDB);
                              });
                              },)
                          ],
                        ),

                        //DATA
                        //Number
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              Text('Number :',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),),
                              SizedBox(width: 4,),
                              Text(user['number'].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
                            ],
                          ),

                        ),
                        SizedBox(height: 4,),
                        //Email
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              Text('Email :',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),),
                              SizedBox(width: 4,),
                              Text(user['email'].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
                            ],
                          ),

                        ),
                        Divider(color: Colors.black12,),
                        Row(

                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(onPressed: (){
                              setState(() {
                                // DataFromDB.removeAt(index);
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
                                            await dbHelper.deleteUser(DataFromDB[index]['id']);
                                          setState(() {
                                            print('hello');
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text("Delete", style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );

                              });
                              // setState(() {
                              //
                              // });
                            },
                              icon: Icon(Icons.delete_rounded),
                              color: Colors.red.shade200,
                            ),

                            IconButton(
                              onPressed: ()async{
                              setState(() {
                                updateData = user;
                                updateIndex = index;


                              });
                                await Navigator.of(context).push(MaterialPageRoute(builder: (context) => (update())));
                            },
                              icon: Icon(Icons.edit_note),
                              color: Colors.blue.shade200,
                            ),

                            InkWell(
                              onTap:(){
                                setState(() {

                                  Widget _buildInfoRow(IconData icon, String label, String value) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Row(
                                        children: [
                                          Icon(icon, color: Colors.black26, size: 22),
                                          SizedBox(width: 10),
                                          Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                          Expanded(
                                            child: Text(
                                              value,
                                              style: TextStyle(fontSize: 16),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }


                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                    ),
                                    isScrollControlled: true,
                                    builder: (context) => Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 50,
                                            backgroundImage: user['photo'] == 'null'
                                                ? (user['gender'] == 'Male'
                                                ? AssetImage('assets/man.png')
                                                : AssetImage('assets/girl.png'))
                                                : NetworkImage(user['photo']) as ImageProvider,
                                          ),
                                          SizedBox(height: 15),
                                          Text(
                                            user['name'],
                                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          Divider(color: Colors.grey[300]),
                                          SizedBox(height: 10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              _buildInfoRow(Icons.email_outlined, "Email:", user['email']),
                                              _buildInfoRow(Icons.phone, "Phone:", user['number']),
                                              _buildInfoRow(Icons.person_outline_sharp, "Gender:", user['gender']),
                                              _buildInfoRow(Icons.location_city_sharp, "City:", user['city']),
                                              _buildInfoRow(Icons.cake_outlined, "Age:", "${user['age']} Years"),
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: Text("Close", style: TextStyle(color: Colors.red, fontSize: 16)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );

                                });
                              },
                              child: Row(
                                children: [

                                  Text('More Data',style: TextStyle(color: Colors.black54),),
                                  IconButton(onPressed: (){
                                    setState(() {

                                      Widget _buildInfoRow(IconData icon, String label, String value) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                          child: Row(
                                            children: [
                                              Icon(icon, color: Colors.black26, size: 22),
                                              SizedBox(width: 10),
                                              Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                              Expanded(
                                                child: Text(
                                                  value,
                                                  style: TextStyle(fontSize: 16),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }


                                      showModalBottomSheet(
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                        ),
                                        isScrollControlled: true,
                                        builder: (context) => Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 50,
                                                backgroundImage: user['photo'] == 'null'
                                                    ? (user['gender'] == 'Male'
                                                    ? AssetImage('assets/man.png')
                                                    : AssetImage('assets/girl.png'))
                                                    : NetworkImage(user['photo']) as ImageProvider,
                                              ),
                                              SizedBox(height: 15),
                                              Text(
                                                user['name'],
                                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                              Divider(color: Colors.grey[300]),
                                              SizedBox(height: 10),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  _buildInfoRow(Icons.email_outlined, "Email:", user['email']),
                                                  _buildInfoRow(Icons.phone, "Phone:", user['number']),
                                                  _buildInfoRow(Icons.person_outline_sharp, "Gender:", user['gender']),
                                                  _buildInfoRow(Icons.location_on_outlined, "City:", user['city']),
                                                  _buildInfoRow(Icons.cake_outlined, "Age:", "${user['age']} Years"),
                                                ],
                                              ),
                                              SizedBox(height: 15),
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: Text("Close", style: TextStyle(color: Colors.red, fontSize: 16)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );

                                    });

                                  },
                                    icon: Icon(Icons.keyboard_arrow_right_outlined),
                                    color: Colors.black54,

                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ])
    ),
      ),

    );
  }
}