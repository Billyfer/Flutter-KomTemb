import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KomTemb Login'),
        backgroundColor: Color.fromARGB(255, 55, 57, 165),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Card(
              elevation: 10,
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 20),
                    Image.asset(
                      'assets/images/login_image.png',
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(height: 20),
                    _buildTextField(_emailController, "Email", Icons.email),
                    SizedBox(height: 20),
                    _buildTextField(_passwordController, "Password", Icons.lock,
                        isPassword: true),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        onPrimary: Colors.white,
                      ),
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading
                          ? CircularProgressIndicator() // Menampilkan loading ketika sedang loading
                          : Text('Log In'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text('Dont have an account? Sign up here'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
      obscureText: isPassword,
    );
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true; // Menampilkan loading indicator
    });
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigate to dashboard page after successful login
      Navigator.pushReplacementNamed(context, '/Dashboard');
    } catch (e) {
      // Handle error
      print(e.toString());
      setState(() {
        _isLoading =
            false; // Menghentikan loading indicator jika terjadi kesalahan
      });
    }
  }
}
