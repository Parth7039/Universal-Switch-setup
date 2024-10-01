import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart'; // Import for animations

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  String _encryptedMessage = "";
  String _decryptedMessage = "";
  bool isEncrypting = false;
  bool isDecrypting = false;
  late AnimationController _fadeSlideAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  // API URLs
  final String encryptUrl = "http://localhost:5000/encrypt";
  final String decryptUrl = "http://localhost:5000/decrypt";

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for fading and sliding the encrypted message
    _fadeSlideAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeSlideAnimationController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<double>(begin: 0.0, end: -50.0).animate(
      CurvedAnimation(parent: _fadeSlideAnimationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _fadeSlideAnimationController.dispose();
    super.dispose();
  }

  // Function to call the encryption API
  Future<void> encryptMessage(String message) async {
    setState(() {
      isEncrypting = true;
      _encryptedMessage = ""; // Clear previous encrypted message
    });

    // Create a request body with the data and algorithm
    final body = json.encode({
      'data': message,
      'algorithm': 'rsa', // or 'aes' or 'des' depending on what you want to use
    });

    final response = await http.post(
      Uri.parse("http://192.168.139.96:5001/encrypt"),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    // Print the status code and response body
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      setState(() {
        _encryptedMessage = json.decode(response.body)['encrypted_data'];
      });
    } else {
      print('Failed to encrypt message');
    }

    setState(() {
      isEncrypting = false;
    });
  }


  // Function to call the decryption API
  Future<void> decryptMessage(String encryptedMessage) async {
    setState(() {
      isDecrypting = true;
      _decryptedMessage = ""; // Clear previous decrypted message
      _fadeSlideAnimationController.reset(); // Reset the animation controller
    });

    final response = await http.post(
      Uri.parse(decryptUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'encrypted_message': encryptedMessage}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _decryptedMessage = json.decode(response.body)['decrypted_message'];
      });

      // Start the fade and slide animation
      _fadeSlideAnimationController.forward();
    } else {
      print('Failed to decrypt message');
    }

    setState(() {
      isDecrypting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Hacker-style dark background
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Universal Switch Setup',
          style: TextStyle(
            color: Colors.greenAccent, // Green text for hacker feel
            fontFamily: 'Courier',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Sender Server Section
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.greenAccent),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.6),
                      blurRadius: 8.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sender Server',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent,
                        fontFamily: 'Courier',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      style: TextStyle(color: Colors.greenAccent),
                      controller: _messageController,
                      decoration: InputDecoration(
                        labelText: 'Enter Message',
                        labelStyle: TextStyle(color: Colors.greenAccent),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.greenAccent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.greenAccent),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: isEncrypting
                          ? null
                          : () => encryptMessage(_messageController.text),
                      child: isEncrypting
                          ? CircularProgressIndicator(
                        color: Colors.black,
                      )
                          : Text(
                        'Encrypt Message',
                        style: TextStyle(fontFamily: 'Courier'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Encrypted Message:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent,
                        fontFamily: 'Courier',
                      ),
                    ),
                    SizedBox(height: 10),
                    AnimatedBuilder(
                      animation: _fadeSlideAnimationController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeAnimation.value,
                          child: Transform.translate(
                            offset: Offset(_slideAnimation.value, 0), // Move the text left
                            child: _encryptedMessage.isNotEmpty
                                ? AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  _encryptedMessage,
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.greenAccent,
                                    fontFamily: 'Courier',
                                  ),
                                  speed: Duration(milliseconds: 10),
                                ),
                              ],
                              isRepeatingAnimation: false,
                            )
                                : SelectableText(
                              "No message encrypted yet.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.greenAccent,
                                fontFamily: 'Courier',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 20), // Space between the two sections
            // Receiver Server Section
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.greenAccent),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.6),
                      blurRadius: 8.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Receiver Server',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent,
                        fontFamily: 'Courier',
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: isDecrypting
                          ? null
                          : () => decryptMessage(_encryptedMessage),
                      child: isDecrypting
                          ? CircularProgressIndicator(
                        color: Colors.black,
                      )
                          : Text(
                        'Decrypt Message',
                        style: TextStyle(fontFamily: 'Courier'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Decrypted Message:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent,
                        fontFamily: 'Courier',
                      ),
                    ),
                    SizedBox(height: 10),
                    _decryptedMessage.isNotEmpty
                        ? AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          _decryptedMessage,
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.greenAccent,
                            fontFamily: 'Courier',
                          ),
                          speed: Duration(milliseconds: 50),
                        ),
                      ],
                      isRepeatingAnimation: false, // Only show once
                    )
                        : SelectableText(
                      "No message decrypted yet.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.greenAccent,
                        fontFamily: 'Courier',
                      ),
                    ),
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
