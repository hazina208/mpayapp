import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mpey/home.dart'; // Already present, good for navigation

const String apiBaseUrl = 'https://test-mpay.onrender.com'; // Replace with your server URL

class LoginWidget extends StatefulWidget {
 
  const LoginWidget({super.key});
  

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/flutter_login.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'identifier': _identifierController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        if (response.headers['content-type']?.contains('application/json') ?? false) {
          try {
            final data = json.decode(response.body);
            if (data['success']) {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('user_email', data['email']);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login successful!')),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              }
            } else {
              if (mounted) {
                setState(() {
                  _errorMessage = data['message'] ?? 'Login failed';
                });
              }
            }
          } catch (e) {
            if (mounted) {
              setState(() {
                _errorMessage = 'Invalid response format: $e';
              });
            }
          }
        } else {
          if (mounted) {
            setState(() {
              _errorMessage = 'Server returned non-JSON response: ${response.body}';
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            _errorMessage = 'Server error: ${response.statusCode}';
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size using MediaQuery
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    // Calculate responsive padding (e.g., 4% of screen width)
    final padding = screenSize.width * 0.04;
    // Calculate responsive font size (e.g., 4% of screen height)
    final fontSize = screenSize.height * 0.02;
    // Calculate button width (e.g., 80% of screen width, max 400)
    final double buttonWidth = screenSize.width * 0.8 > 400 ? 400 : screenSize.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(fontSize: fontSize * 1.5), // Responsive font size
        ),
      ),
      // Use SafeArea to avoid notches and status bars
      body: SafeArea(
        child: Padding(
          // Responsive padding
          padding: EdgeInsets.all(padding),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              // Make form scrollable for smaller screens
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add spacing at the top for larger screens
                  SizedBox(height: screenSize.height * 0.05),
                  TextFormField(
                    controller: _identifierController,
                    decoration: InputDecoration(
                      labelText: 'Email / Phone',
                      labelStyle: TextStyle(fontSize: fontSize),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(fontSize: fontSize),
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: padding), // Responsive spacing
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: fontSize),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(fontSize: fontSize),
                    obscureText: true,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: padding * 1.5),
                  if (_errorMessage.isNotEmpty)
                    Text(
                      _errorMessage,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: fontSize * 0.9,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  SizedBox(height: padding),
                  SizedBox(
                    width: buttonWidth, // Responsive button width
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: padding * 0.8),
                        textStyle: TextStyle(fontSize: fontSize * 1.1),
                      ),
                      child: const Text('Login'),
                    ),
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