import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:matrihoney/h_adduser.dart';
import 'package:matrihoney/h_userlist.dart';
import 'package:intl/intl.dart';
import 'package:matrihoney/homepagebuilder.dart';
import 'database.dart';


class update extends StatefulWidget {
  const update({super.key});

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {

  @override
  void initState() {
    dbHelper.fetchUsers();
    initializeHobbies(updateData);
    super.initState();
  }

  final dbHelper = DatabaseHelper();

  //Bottom navigation bar.......................

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  //--------------------------------------------

  TextEditingController temp = TextEditingController();
  TextEditingController nameController = TextEditingController(text: updateData['name'].toString());
  TextEditingController emailController = TextEditingController(text: updateData['email'].toString());
  TextEditingController numberController = TextEditingController(text: updateData['number'].toString());
  TextEditingController dateController = TextEditingController(text: updateData['date'].toString());
  TextEditingController genderController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController photoController = TextEditingController(text: updateData['photo'].toString());
  GlobalKey<FormState> formKey = GlobalKey();


  bool isVisible = true;
  String? val = updateData['city'].toString();
  List<String> cityOptions = ['Rajkot', 'Surat', 'Jamnagar'];
  var gender2 = updateData['gender'];

  List<String> hobbies = [];
  late bool isGames;
  late bool isMovies;
  late bool isMusic;
  late bool isDance;

///to update database
  void updateUserState(Map<String,dynamic> mapMap,int idx) async{
      await dbHelper.updateUser(mapMap,idx);
    setState((){
    });
  }

  void initializeHobbies(Map<String, dynamic> updateData) {
    hobbies = updateData['hobbies'].split(',');

    isGames = hobbies.contains('Games');
    isMovies = hobbies.contains('Movies');
    isMusic = hobbies.contains('Music');
    isDance = hobbies.contains('Dance');
  }

  void addData() {

    List<String> hobbiesList = [];

    if (isGames) hobbies.add("Games");
    if (isMovies) hobbies.add("Movies");
    if (isMusic) hobbies.add("Music");
    if (isDance) hobbies.add("Dance");

    Map<String, dynamic> tempMap = {

      'name': nameController.text,
      'email': emailController.text,
      'number': numberController.text,
      'date': dateController.text,
      'city': val,
      'gender': updateData['gender'],
      'favourite': updateData['favourite'],
      'hobbies': hobbiesList.join(','),
      'photo' : photoController.text
      };
      setState((){
        updateUserState(tempMap,updateData['id']);
      });





      setState(() {
      nameController.clear();
      emailController.clear();
      numberController.clear();
      dateController.clear();
      dateController.clear();
      passwordController.clear();
      photoController.clear();
      gender = null;
      isGames = true;
      isMovies = false;
      isMusic = false;
      isDance = false;
      });
      print(dataList);
    setState(() {});
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo.png',height: 90,width: 90,),
        title: Text('Update Profile',style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.white,
              Color.fromRGBO(255, 219, 218, 1),
            ],
            center: Alignment.topCenter,
            radius: 1.5,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Card(

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(height: 16),

                      Container(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 3.5,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: CircleAvatar(
                                radius: 55.0,
                                backgroundImage: updateData['photo']== 'null'?(updateData['gender'] == 'Male' ?AssetImage('assets/man.png'): AssetImage('assets/girl.png')): NetworkImage(updateData['photo']),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Enter URL"),
                                        content: TextFormField(
                                          controller: photoController,
                                          decoration: InputDecoration(
                                            labelText: 'URL',
                                            // prefixIcon: const Icon(Icons.person_2_outlined, color: Color.fromRGBO(221, 94, 137, 1)),
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black12, width: 1.5),
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {

                                              Navigator.of(context).pop(); // Close the dialog
                                            },
                                            child: Text("OK"),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  padding: EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      SizedBox(height: 16),
                      //name
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        maxLength: 40,
                        decoration: InputDecoration(
                          labelText: 'name',
                          prefixIcon: const Icon(Icons.person_2_outlined, color: Colors.black26),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12, width: 1.5),

                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 3 || value.length > 50) {
                            return 'Enter a name at least 2 characters long and max 30 characters.';
                          }
                          final nameRegex = RegExp(r"^[a-zA-Z\s']{3,50}$");
                          if (!nameRegex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      // Email
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        maxLength: 40,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          // prefixIcon: const Icon(Icons.email_outlined, color: Colors.black26),
                          prefixIcon: const Icon(Icons.email_outlined, color: Colors.black26),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12, width: 1.5),

                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 5 || !value.contains('@')) {
                            return 'Enter a valid email.';
                          }
                          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      // Mobile NUmber
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: numberController,
                        maxLength: 10,
                        decoration: InputDecoration(
                          labelText: 'Mobile number',
                          prefixIcon: const Icon(Icons.phone_enabled_outlined, color: Colors.black26),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12, width: 1.5),

                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 10) {
                            return 'Enter a valid number.';
                          }
                          final numberRegex = RegExp(r'^\+?[0-9]{10,15}$');
                          if (!numberRegex.hasMatch(value)) {
                            return 'Enter a valid Phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),

                      //date
                      TextFormField(

                        controller: dateController,
                        onTap: ()async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          setState(() {
                            dateController.text =
                                DateFormat('dd-MM-yyyy').format(selectedDate!);
                          });
                        },

                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Date',
                          prefixIcon: const Icon(Icons.calendar_month_outlined, color: Colors.black26),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12, width: 1.5),

                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'YY-MM-YYYY';
                          }
                          int calcAge(String val){
                            List split = val.split('-');
                            return ((DateTime.now().year)) - int.parse(split[2]);
                          }
                          if(calcAge(value) < 18){
                            return 'User should be above 18';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      //City
                      Container(

                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: updateData['city'].toString(),
                            prefixIcon: const Icon(Icons.location_city_outlined, color: Color.fromRGBO(221, 94, 137, 1)),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12, width: 1.5),
                            ),
                          ),
                          items: cityOptions.map((option) => DropdownMenuItem(
                            child: Text(option),
                            value: option,
                          )).toList(),
                          // value: val,
                          onChanged: (value) {
                            setState(() {
                              val = value;
                            });
                          },
                        )


                      ),

                      //Genter
                      SizedBox(height:5),
                      Text('Gender'),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // Expanded(child: RadioListTile(value: 'Male',title: Text('Male',style: TextStyle(color: Colors.black),), groupValue: gender, onChanged: (value){setState(() {gender = value.toString();});})),
                            // Expanded(child: RadioListTile(value: 'Female',title: Text('Female',style: TextStyle(color: Colors.black),), groupValue: gender, onChanged: (value){setState(() {gender = value.toString();});})),
                            Radio(
                              value: "Male",
                              groupValue: gender2,
                              onChanged: (value) {
                                setState(() {gender2 = value.toString();});
                              },
                            ),
                            Text("Male",style: TextStyle(color: Colors.black,fontSize: 15),),

                            SizedBox(width: 20),

                            Radio(
                              value: "Female",
                              groupValue: gender2,
                              onChanged: (value) {
                                setState(() {gender2 = value.toString();});
                              },
                            ),
                            Text("Female",style: TextStyle(color: Colors.black,fontSize: 15),),
                          ],
                        ),
                      ),

                      //Hobbies
                      Text('Hobbies',style: TextStyle(color: Colors.black),),
                      SizedBox(height: 5,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildCheckbox("Games", isGames, (value) {
                            setState(() {
                              isGames = value!;
                            });
                          }),
                          buildCheckbox("Movies", isMovies, (value) {
                            setState(() {
                              isMovies = value!;
                            });
                          }),
                          buildCheckbox("Music", isMusic, (value) {
                            setState(() {
                              isMusic = value!;
                            });
                          }),
                          buildCheckbox("Dance", isDance, (value) {
                            setState(() {
                              isDance = value!;
                            });
                          }),
                        ],
                      ),

                      SizedBox(height: 30,),

                      //BUTTON
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(221, 94, 137, 1),
                              Color.fromRGBO(247, 187, 151, 1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('You are Registered!')),

                              );
                              addData();
                              setState(() {

                              });
                              dataList.remove(updateData);

                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => (Homebuilder(initialIndex:1))));

                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),


    );
  }
  Widget buildCheckbox(String title, bool value, Function(bool?) onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.black12,
        ),
        Text(title, style: TextStyle(color: Colors.black)),
      ],
    );
  }
}



