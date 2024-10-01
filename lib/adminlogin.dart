import 'package:flutter/material.dart';

class Adminlogin extends StatefulWidget {
  const Adminlogin({super.key});

  @override
  State<Adminlogin> createState() => _AdminloginState();
}

class _AdminloginState extends State<Adminlogin> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background for hacker-style
      body: Center(
        child: SingleChildScrollView( // Add scrolling if needed
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
                SizedBox(height: 40), // Spacing between title and fields
                customTextField(
                  labelText: 'Username',
                  hintText: 'Enter the username',
                  controller: _usernameController,
                ),
                SizedBox(height: 16), // Space between text fields
                customTextField(
                  labelText: 'Password',
                  hintText: 'Enter the password',
                  controller: _passwordController,
                  obscureText: true, // Password field should obscure text
                ),
                SizedBox(height: 20), // Space before button
                ElevatedButton(
                  onPressed: () {
                    // Handle login logic
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.greenAccent, // Text color
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
    bool obscureText = false, // default is false
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0), // Added padding for better layout
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
        style: TextStyle(color: Colors.greenAccent), // Text color
      ),
    );
  }
}
