import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:matrihoney/h_aboutus.dart';
import 'package:matrihoney/h_adduser.dart';
import 'package:matrihoney/h_favourite.dart';
import 'package:matrihoney/h_userlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

int currentIndex = 0;

class Homebuilder extends StatefulWidget {
  final initialIndex;
  const Homebuilder({super.key,required this.initialIndex});

  @override
  State<Homebuilder> createState() => _HomebuilderState();
}

class _HomebuilderState extends State<Homebuilder> {


  PageController pageController = PageController();
  var PagesList = [addUser(),userList(),favourite(),AboutUsPage()];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    pageController = PageController(initialPage: currentIndex);
  }

  Future<void> _logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("isLoggedIn");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo.png',height: 90,width: 90,),
        title: Text('MatriHoney',style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_sharp,color: Colors.white,),
            onPressed: () => _logout(context),
          ),
        ],
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: PageView(
        controller: pageController,
        children: PagesList,
        onPageChanged: (value){
          setState(() {
            currentIndex = value;
          });
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black87,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.pinkAccent.withOpacity(0.1),
              color: Colors.black54,
              tabs: [
                GButton(
                  icon: Icons.person_add_alt,
                  text: 'add person',

                ),
                GButton(
                  icon: Icons.list_sharp,
                  text: 'person list',

                ),
                GButton(
                  icon:Icons.favorite_border_sharp,
                  text: 'favourites',
                ),
                GButton(
                  icon: Icons.account_box_outlined,
                  text: 'about us',
                ),
              ],
              selectedIndex: currentIndex,
              onTabChange: (index) {
                setState(() {
                  currentIndex = index;
                  pageController.animateToPage(currentIndex, duration: Duration(microseconds: 200), curve: Easing.emphasizedAccelerate);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
