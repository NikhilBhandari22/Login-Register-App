import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/screens/register.dart';

class LoginPAge extends StatefulWidget {
  const LoginPAge({super.key});

  @override
  State<LoginPAge> createState() => _LoginPAgeState();
}

class _LoginPAgeState extends State<LoginPAge> {
  //----------------textfield Controller----------------

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // ------------------Firebase Auth instance---------------
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // --------------------loginUser function-------------------

  Future<void> _loginUser() async {
    try {
      // Sign in with Firebase
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (!mounted) return;
      // Navigate to HomePage if sign-in is successful
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      // Handle login errors here (e.g., invalid password, user not found)
      developer.log("Login Error: $e");
      if (!mounted) return;
      //Optionally show a snackbar or dialog with error message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login failed: $e")));
    }
  }

  // ---------------------UI of Homepage------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // body starts from here
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.deepPurple,
          ),
          height: 500,
          width: 300,

          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter Username',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.deepPurple,
                          ),
                          hintStyle: TextStyle(color: Colors.deepPurple),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          prefixIcon: Icon(
                            Icons.password_outlined,
                            color: Colors.deepPurple,
                          ),
                          hintStyle: TextStyle(color: Colors.deepPurple),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 400,
                        child: ElevatedButton(
                          onPressed: _loginUser,
                          child: Text('Login'),
                        ),
                      ),
                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't Have a Account ? ",
                            style: TextStyle(color: Colors.white),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Create Here",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
