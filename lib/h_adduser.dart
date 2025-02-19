import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:matrihoney/h_favourite.dart';
import 'package:matrihoney/h_userlist.dart';
import 'package:matrihoney/homepagebuilder.dart';
import 'database.dart';
// import 'package:line_icons/line_icons.dart';

//DATABASE////////////////////////

final dbHelper = DatabaseHelper();


List<Map<String,dynamic>> dataList = [
{'name' : 'Dustin Handerson',
  'email' : 'dustybun@gmail.com',
  'number' : '1234567890',
  'date' : '12-12-1212',
  'city' : 'surat',
  'gender' : 'Male',
  'favourite' : false,
  'photo' : 'null',
  'gender': 'Male',
  'hobbies': ['Games', 'Movies','Music', 'Dance'],
},
{
  'name' : 'Max Mayfild',
  'email' : 'madmax@gmail.com',
  'number' : '1234567890',
  'date' : '13-02-2006',
  'city' : 'Ahemdabad',
  'gender' : 'Female',
  'favourite' : false,
  'photo' : 'null',
  'gender': 'Female',
  'hobbies': ['Games','Movies','Music','Dance'],
}

];
String? gender;

class addUser extends StatefulWidget {
  const addUser({super.key});

  @override
  State<addUser> createState() => _addUserState();
}

class _addUserState extends State<addUser> {
    TextEditingController temp = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey();

  //variables....................................
  bool isVisible = true;
  String? val;

  bool isGames = false;
  bool isMovies = false;
  bool isMusic = false;
  bool isDance = false;

    int updateIndex = 0;


  //METHODS.....................................

  void addData()async{
    List<String> hobbies = [];
    if (isGames) hobbies.add("Games");
    if (isMovies) hobbies.add("Movies");
    if (isMusic) hobbies.add("Music");
    if (isDance) hobbies.add("Dance");

      Map<String,dynamic> tempMap = {
        'name' : nameController.text,
        'email' : emailController.text,
        'number' : numberController.text,
        'date' : dateController.text,
        'city' : val,
        'gender' : gender,
        'favourite' : 0,
        'hobbies' : hobbies.join(','),
        'photo' : 'null'
      };
      await dbHelper.insertUser(tempMap);
      setState(() {
          print('hello');
      });
    setState(() {
      dataList.add(tempMap);

      print('<><><><><><><><><><><><><><${DataFromDB}.<><><><><><><><><><><><>');

      nameController.clear();
      emailController.clear();
      numberController.clear();
      dateController.clear();
      dateController.clear();
      passwordController.clear();
      gender = null;
      isDance = false;
      isMusic = false;
      isGames = false;
      isMovies = false;
    });
      // print(dataList);
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

                      const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(221, 94, 137, 1),
                        ),
                      ),
                      const SizedBox(height: 15),
                      //name
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        maxLength: 40,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: 'Name',
                          prefixIcon: const Icon(Icons.person_2_outlined, color: Color.fromRGBO(221, 94, 137, 1)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent, width: 1.2),

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
                      const SizedBox(height: 15),
                      // Email
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        maxLength: 40,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email_outlined, color: Color.fromRGBO(221, 94, 137, 1)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent, width: 1.5),

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
                          if(dataList.any((map) => map['email'] == value)){
                            return 'This email already exist, Enter new email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      // Mobile NUmber
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: numberController,
                        maxLength: 10,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: 'Mobile Number',
                          prefixIcon: const Icon(Icons.phone_enabled_outlined, color: Color.fromRGBO(221, 94, 137, 1)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent, width: 1.5),

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
                          if(dataList.any((map) => map['number'] == value)){
                            return 'This number already exist, Enter new number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      // password
                      TextFormField(
                        controller: passwordController,
                        maxLength: 20,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline, color: Color.fromRGBO(221, 94, 137, 1)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: Icon(
                              isVisible ? Icons.visibility_sharp : Icons.visibility_off_sharp,
                              color: Colors.grey,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent, width: 1.5),

                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 4) {
                            return 'Enter a valid password.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      //date
                      TextFormField(

                        controller: dateController,
                        onTap: ()async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
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
                          prefixIcon: const Icon(Icons.calendar_month_outlined, color: Color.fromRGBO(221, 94, 137, 1)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent, width: 1.5),
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

                        child: DropdownButtonFormField(

                          decoration: InputDecoration(

                            labelText: 'City',
                            prefixIcon: const Icon(Icons.location_city_outlined, color: Color.fromRGBO(221, 94, 137, 1)),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent, width: 1.5),

                            ),
                          ),
                            items:['Rajkot','Surat','Jamnagar'].map((option) => DropdownMenuItem(child:Text(option) ,value: option,)).toList(),
                            value: val,
                            onChanged: (value) {
                              setState(() {
                                val  = value;
                              });
                            },),
                      ),

                      //Genter
                      SizedBox(height:5),
                      Text('Gender'),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Radio(
                              value: "Male",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {gender = value.toString();});
                              },
                            ),
                            Text("Male",style: TextStyle(color: Colors.black,fontSize: 15),),

                            SizedBox(width: 20), // Space between options

                            Radio(
                              value: "Female",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {gender = value.toString();});
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
                          Row(
                            children: [
                              Checkbox(value: isGames, onChanged: (value){setState(() {isGames = value!;});},activeColor: Colors.pinkAccent,),
                              Text('Games',style: TextStyle(color: Colors.black),),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(value: isMovies, onChanged: (value){setState(() {isMovies = value!;});},activeColor: Colors.pinkAccent,),
                              Text('Movies',style: TextStyle(color: Colors.black),),
                            ],
                          ),

                          Row(
                            children: [
                              Checkbox(value: isMusic, onChanged: (value){setState(() {isMusic = value!;});},activeColor: Colors.pinkAccent,),
                              Text('Music',style: TextStyle(color: Colors.black),),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(value: isDance, onChanged: (value){setState(() {isDance = value!;});},activeColor: Colors.pinkAccent,),
                              Text('Dance',style: TextStyle(color: Colors.black),),
                            ],
                          ),

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
                          onPressed: (){
                             if (formKey.currentState!.validate()){

                              addData();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('You are Registered!')),
                              );
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => Homebuilder(initialIndex: 1))
                              );
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
}

