import 'package:flutter/material.dart';
import 'package:matrihoney/homePage.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController temp = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isVisible = true;
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
                color: Colors.white.withOpacity(0.9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(221, 94, 137, 1),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        maxLength: 40,
                        decoration: InputDecoration(
                          labelText: 'Name',

                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Icon(
                                  Icons.person_outline_sharp,
                                  color: Colors.black,
                                  size: 22,
                                ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pinkAccent, width: 1.5),

                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 2) {
                            return 'Enter a name at least 2 characters long.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        maxLength: 40,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(11),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                                size: 22,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pinkAccent, width: 1.5),

                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 5 || !value.contains('@')) {
                            return 'Enter a valid email.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        maxLength: 40,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(11),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.lock_outline,
                                color: Colors.black,
                                size: 22,
                              ),
                            ),
                          ),
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
                            borderRadius: BorderRadius.circular(50),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pinkAccent, width: 1.5),

                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 5) {
                            return 'Enter a valid password.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
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
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => (homePage())));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Form Submitted Successfully!')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Sign In',
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
//
// import 'package:matrihoney/homePage.dart';
// import 'package:flutter/material.dart';
//
// class SignIn extends StatefulWidget {
//   const SignIn({super.key});
//
//   @override
//   State<SignIn> createState() => _SignInState();
// }
//
// class _SignInState extends State<SignIn> {
//   final GlobalKey<FormState> formKey = GlobalKey();
//   bool isVisible = true;
//   bool isLoading = false;
//
//   // Custom text field style
//   InputDecoration _buildInputDecoration({
//     required String label,
//     required String hint,
//     required IconData icon,
//     Widget? suffixIcon,
//   }) {
//     return InputDecoration(
//       labelText: label,
//       hintText: hint,
//       labelStyle: TextStyle(
//         color: Colors.pink.shade400,
//         fontWeight: FontWeight.w500,
//         fontSize: 16,
//       ),
//       hintStyle: TextStyle(
//         color: Colors.grey.shade400,
//         fontSize: 14,
//       ),
//       prefixIcon: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 8),
//         decoration: BoxDecoration(
//           color: Colors.pink.shade50,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         padding: const EdgeInsets.all(8),
//         child: Icon(
//           icon,
//           color: Colors.pink.shade400,
//           size: 22,
//         ),
//       ),
//       suffixIcon: suffixIcon,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15),
//         borderSide: BorderSide(
//           color: Colors.pink.shade100,
//           width: 2.0,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15),
//         borderSide: BorderSide(
//           color: Colors.pink.shade400,
//           width: 2.0,
//         ),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15),
//         borderSide: BorderSide(
//           color: Colors.red.shade200,
//           width: 2.0,
//         ),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15),
//         borderSide: BorderSide(
//           color: Colors.red.shade400,
//           width: 2.0,
//         ),
//       ),
//       filled: true,
//       fillColor: Colors.white,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.pink.shade50,
//               Colors.white,
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Logo
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.pink.shade100.withOpacity(0.5),
//                           blurRadius: 20,
//                           spreadRadius: 5,
//                         ),
//                       ],
//                     ),
//                     child: Icon(
//                       Icons.favorite,
//                       size: 64,
//                       color: Colors.pink.shade400,
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//
//                   // Login Card
//                   Card(
//                     elevation: 8,
//                     shadowColor: Colors.pink.shade100.withOpacity(0.5),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Container(
//                       padding: const EdgeInsets.all(32),
//                       width: double.infinity,
//                       child: Form(
//                         key: formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Welcome Back',
//                               style: TextStyle(
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.pink.shade400,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               'Sign in to continue',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.grey.shade600,
//                               ),
//                             ),
//                             const SizedBox(height: 32),
//
//                             // Name Field with enhanced style
//                             TextFormField(
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               decoration: _buildInputDecoration(
//                                 label: 'Name',
//                                 hint: 'Enter your name',
//                                 icon: Icons.person_outline,
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty || value.length < 2) {
//                                   return 'Please enter a valid name';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: 24),
//
//                             // Email Field with enhanced style
//                             TextFormField(
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               decoration: _buildInputDecoration(
//                                 label: 'Email',
//                                 hint: 'Enter your email',
//                                 icon: Icons.email_outlined,
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty || !value.contains('@')) {
//                                   return 'Please enter a valid email';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: 24),
//
//                             // Password Field with enhanced style
//                             TextFormField(
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               obscureText: isVisible,
//                               decoration: _buildInputDecoration(
//                                 label: 'Password',
//                                 hint: 'Enter your password',
//                                 icon: Icons.lock_outline,
//                                 suffixIcon: Container(
//                                   margin: const EdgeInsets.only(right: 8),
//                                   decoration: BoxDecoration(
//                                     color: Colors.pink.shade50,
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: IconButton(
//                                     icon: Icon(
//                                       isVisible
//                                           ? Icons.visibility_outlined
//                                           : Icons.visibility_off_outlined,
//                                       color: Colors.pink.shade400,
//                                       size: 22,
//                                     ),
//                                     onPressed: () => setState(() => isVisible = !isVisible),
//                                   ),
//                                 ),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty || value.length < 6) {
//                                   return 'Password must be at least 6 characters';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: 12),
//
//                             // Forgot Password Link
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: TextButton(
//                                 onPressed: () {
//                                   // Add forgot password functionality
//                                 },
//                                 style: TextButton.styleFrom(
//                                   foregroundColor: Colors.pink.shade400,
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 16,
//                                     vertical: 8,
//                                   ),
//                                 ),
//                                 child: const Text(
//                                   'Forgot Password?',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 24),
//
//                             // Sign In Button
//                             SizedBox(
//                               width: double.infinity,
//                               height: 56,
//                               child: ElevatedButton(
//                                 onPressed: isLoading
//                                     ? null
//                                     : () async {
//                                   if (formKey.currentState!.validate()) {
//                                     setState(() => isLoading = true);
//                                     await Future.delayed(const Duration(seconds: 1));
//                                     setState(() => isLoading = false);
//
//                                     if (mounted) {
//                                       Navigator.of(context).pushReplacement(
//                                         MaterialPageRoute(builder: (context) => const homePage()),
//                                       );
//                                       ScaffoldMessenger.of(context).showSnackBar(
//                                         SnackBar(
//                                           content: const Text('Welcome back!'),
//                                           backgroundColor: Colors.pink.shade400,
//                                           behavior: SnackBarBehavior.floating,
//                                         ),
//                                       );
//                                     }
//                                   }
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.pink.shade400,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   elevation: 2,
//                                 ),
//                                 child: isLoading
//                                     ? const CircularProgressIndicator(color: Colors.white)
//                                     : const Text(
//                                   'Sign In',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//                             // Sign Up Link
//                             const SizedBox(height: 24),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "Don't have an account? ",
//                                   style: TextStyle(
//                                     color: Colors.grey.shade600,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     // Add sign up navigation
//                                   },
//                                   style: TextButton.styleFrom(
//                                     foregroundColor: Colors.pink.shade400,
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 8,
//                                       vertical: 4,
//                                     ),
//                                   ),
//                                   child: const Text(
//                                     'Sign Up',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
