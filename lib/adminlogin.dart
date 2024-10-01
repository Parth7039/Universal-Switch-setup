import 'package:flutter/material.dart';
import 'dashboard.dart'; // Import your DashboardPage

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Admin Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                    fontFamily: 'Courier',
                  ),
                ),
                SizedBox(height: 40),
                customTextField(
                  labelText: 'Username',
                  hintText: 'Enter the username',
                  controller: _usernameController,
                ),
                SizedBox(height: 16),
                customTextField(
                  labelText: 'Password',
                  hintText: 'Enter the password',
                  controller: _passwordController,
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate directly to DashboardPage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.greenAccent,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Courier',
                    ),
                  ),
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextField({
    required String labelText,
    required String hintText,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent),
          ),
          labelStyle: TextStyle(color: Colors.greenAccent),
          hintStyle: TextStyle(color: Colors.grey),
        ),
        style: TextStyle(color: Colors.greenAccent),
      ),
    );
  }
}
