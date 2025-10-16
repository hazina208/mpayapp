import 'package:flutter/material.dart';
import 'package:mpey/login.dart';
import 'package:mpey/register.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    // Get screen size using MediaQuery
    final screenSize = MediaQuery.of(context).size;
    // Define responsive margins and image sizes
    final double marginSize = screenSize.width * 0.05; // 5% of screen width
    final double imageWidth = screenSize.width * 0.9; // 90% of screen width
    final double imageHeight = screenSize.height * 0.3; // 30% of screen height
    final double appBarFontSize = screenSize.width * 0.05; // Scale AppBar title

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MPAY',
          style: TextStyle(fontSize: appBarFontSize), // Responsive title size
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          // Login menu button
          IconButton(
            icon: Icon(
              Icons.login,
              size: screenSize.width * 0.06, // Scale icon size
            ),
            tooltip: 'Login',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginWidget()),
              );
            },
          ),
          // Register menu button
          IconButton(
            icon: Icon(
              Icons.person_add,
              size: screenSize.width * 0.06, // Scale icon size
            ),
            tooltip: 'Register',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterWidget()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(marginSize),
              child: Image.asset(
                'assets/mobilemoney/pay.jpg',
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.all(marginSize),
              child: Image.asset(
                'assets/mobilemoney/payment_successful.jpg',
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}