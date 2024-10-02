import 'package:flutter/material.dart';

class Adminpage extends StatefulWidget {
  const Adminpage({super.key});

  @override
  State<Adminpage> createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {
  String? selectedAlgorithm; // Variable to hold the selected algorithm

  void _showCustomSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.black), // Customize text color
      ),
      backgroundColor: Colors.greenAccent, // Customize background color
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      padding: EdgeInsets.all(16), // Padding inside the snackbar
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Admin Configuration',
          style: TextStyle(color: Colors.greenAccent),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding around the column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Switch Configuration Panel',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
              ),
              SizedBox(height: 20), // Space between texts
              Text(
                'Select your algorithm for encryption:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.greenAccent,
                ),
              ),
              SizedBox(height: 20), // Space before dropdown
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.greenAccent), // Border color
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                child: DropdownButton<String>(
                  value: selectedAlgorithm, // Current selected value
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Choose an algorithm',
                      style: TextStyle(color: Colors.greenAccent),
                    ),
                  ),
                  dropdownColor: Colors.black, // Background color of dropdown
                  items: <String>['RSA', 'AES'] // Options for the dropdown
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.greenAccent), // Text color
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedAlgorithm = newValue; // Update selected algorithm
                    });
                    // Show custom styled snackbar
                    _showCustomSnackbar('Selected: $newValue');
                  },
                  style: TextStyle(color: Colors.greenAccent), // Text style
                  iconEnabledColor: Colors.greenAccent, // Icon color
                  underline: Container(), // No underline
                ),
              ),
              SizedBox(height: 20), // Space before button
              ElevatedButton(
                onPressed: selectedAlgorithm != null
                    ? () {
                  // Logic for applying the selected algorithm
                  print('Algorithm applied: $selectedAlgorithm');
                  _showCustomSnackbar('Algorithm applied: $selectedAlgorithm');
                }
                    : null, // Disable if no selection
                child: Text(
                  'Apply',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Logic for resetting the selection
                  setState(() {
                    selectedAlgorithm = null; // Reset selection
                  });
                  _showCustomSnackbar('Selection reset.');
                },
                child: Text(
                  'Reset',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
