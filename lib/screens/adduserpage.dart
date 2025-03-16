import 'package:flutter/material.dart';
import 'package:myapp/screens/register.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:RegisterPage(),// calling the Register Stfl Widget
    );
  }
}