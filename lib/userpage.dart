import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart'; // Import WebSocket package
import 'package:animated_text_kit/animated_text_kit.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  String _encryptedMessage = "";
  String _decryptedMessage = "No message Decrypted";
  bool isEncrypting = false;
  bool isDecrypting = false;
  late AnimationController _slideAnimationController;
  late Animation<double> _slideAnimation;

  // WebSocket channel for receiving messages
  late WebSocketChannel channel;

  // API URLs
  final String encryptUrl = "http://192.168.67.198:5001/encrypt";
  final String decryptUrl = "http://192.168.67.198:5002/decrypt";

  @override
  void initState() {
    super.initState();

    // Initialize WebSocket connection
    channel = WebSocketChannel.connect(Uri.parse('ws://localhost:5002'));

    // Listen to WebSocket stream for incoming messages
    channel.stream.listen((message) {
      setState(() {
        _decryptedMessage = json.decode(message)['decrypted_data'];
      });
    });

    // Initialize animation controller for sliding the encrypted message
    _slideAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _slideAnimation = Tween<double>(begin: 0.0, end: -50.0).animate(
      CurvedAnimation(parent: _slideAnimationController, curve: Curves.easeOut),
    );

    // Add listener to show decrypted message once the slide animation is finished
    _slideAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _decryptedMessage = _messageController.text;
        });
      }
    });
  }

  @override
  void dispose() {
    _slideAnimationController.dispose();
    channel.sink.close(); // Close the WebSocket connection
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
      'algorithm': 'rsa',
    });

    final response = await http.post(
      Uri.parse("http://192.168.67.198:5001/encrypt"),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      setState(() {
        _encryptedMessage = json.decode(response.body)['encrypted_data'];
        _decryptedMessage = ""; // Clear the decrypted message until animation finishes
      });
      _slideAnimationController.forward(); // Start the animation
    } else {
      print('Failed to encrypt message');
    }

    setState(() {
      isEncrypting = false;
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
            color: Colors.greenAccent,
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
                      animation: _slideAnimationController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(_slideAnimation.value, 0),
                          child: Container(
                            width: double.infinity,
                            child: _encryptedMessage.isNotEmpty
                                ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    _encryptedMessage,
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.greenAccent,
                                      fontFamily: 'Courier',
                                    ),
                                    speed: Duration(milliseconds: 50),
                                  ),
                                ],
                                isRepeatingAnimation: false,
                              ),
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
            SizedBox(width: 20),
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
                      isRepeatingAnimation: false,
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
