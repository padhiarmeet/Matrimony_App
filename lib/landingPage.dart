import 'package:flutter/material.dart';
import 'package:matrihoney/login.dart';
import 'package:matrihoney/signin.dart';
import 'package:matrihoney/homePage.dart';

class landing extends StatefulWidget {
  const landing({super.key});

  @override
  State<landing> createState() => _landingState();
}

class _landingState extends State<landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(255, 219, 218, 100),
      // backgroundColor: Color.fromRGBO(255,219,219, 100),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.white,
              Color.fromRGBO(255, 219, 218,1),
            ], // Gradient colors

          ),
        ),
        child: Column(
          children: [

            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                // gradient: RadialGradient(
                //   colors: [
                //     Colors.white,
                //     Color.fromRGBO(255, 219, 218,1)
                //   ], // Gradient colors
                //
                // ),
                color: Colors.transparent
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                              'assets/logo.png',
                            width: 150,
                            height: 150,
                          ),
                          Text(
                            'MatriHoney',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(221, 94, 137, 1),
                            ),
                          ),
                           Text(
                            'Find your PERFECT match',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.pinkAccent[100],
                            ),
                          ),

                        ],

                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    Container(
                      width: 200,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(221, 94, 137, 1),
                            Color.fromRGBO(247, 187, 151, 1)
                          ], // Gradient colors
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignIn()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    const SizedBox(height: 10),

                    Container(
                      width: 200,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(221, 94, 137, 1),
                            Color.fromRGBO(247, 187, 151, 1)
                          ], // Gradient colors
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),

                    SizedBox(height: 3),
                    const Text('Already have an Account?',style: TextStyle(fontSize: 11,color: Colors.black54),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





