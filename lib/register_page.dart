import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  bool _registrationSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[200]!, Colors.blue[900]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        border: InputBorder.none,
                        errorText:
                            _errorMessage.isNotEmpty ? _errorMessage : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        border: InputBorder.none,
                        errorText:
                            _errorMessage.isNotEmpty ? _errorMessage : null,
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _errorMessage = '';
                      });
                      try {
                        await _auth.createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        setState(() {
                          _registrationSuccess = true;
                        });

                        Timer(Duration(seconds: 3), () {
                          Navigator.pushReplacementNamed(context, '/login');
                        });
                      } catch (e) {
                        setState(() {
                          _errorMessage = e.toString(); // Set error message
                        });
                      }
                    },
                    child: Text('Register'),
                  ),
                  SizedBox(height: 16.0),
                  _registrationSuccess
                      ? Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.green,
                          child: Text('Akun berhasil dibuat!'),
                        )
                      : Container(
                          padding: EdgeInsets.all(8.0),
                          color: _errorMessage.isNotEmpty
                              ? Colors.red
                              : Colors.transparent,
                          child: Text(
                              _errorMessage.isNotEmpty ? _errorMessage : ''),
                        ),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Sudah punya akun? Login disini'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
