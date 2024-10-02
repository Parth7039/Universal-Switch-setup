import 'package:codeverse/adminpage.dart';
import 'package:flutter/material.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome message
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                    fontFamily: 'Courier',
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Please log in to continue.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[400],
                    fontFamily: 'Courier',
                  ),
                ),
                SizedBox(height: 40),
                // TextFields in a Form
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customTextField(
                        labelText: 'Username',
                        hintText: 'Enter the username',
                        controller: _usernameController,
                      ),
                      SizedBox(height: 20),
                      customTextField(
                        labelText: 'Password',
                        hintText: 'Enter the password',
                        controller: _passwordController,
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                // Login Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      String username = _usernameController.text;
                      String password = _passwordController.text;

                      // Validate if the username and password are both 'admin'
                      if (username == 'admin' && password == 'admin') {
                        // Navigate to Adminpage if credentials are correct
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Adminpage()),
                        );
                      } else {
                        // Show a Snackbar if credentials are incorrect
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Incorrect credentials'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5, // Add shadow for depth
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.greenAccent,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Rounded corners
                      ),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Courier',
                      ),
                    ),
                    child: Text('Login'),
                  ),
                ),
                SizedBox(height: 10),
                // Forgot Password (Optional)
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Implement forgot password functionality
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontFamily: 'Courier',
                        fontSize: 16,
                      ),
                    ),
                  ),
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
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
        labelStyle: TextStyle(color: Colors.greenAccent),
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(color: Colors.greenAccent),
    );
  }
}
