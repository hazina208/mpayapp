import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mpey/start.dart'; // Import Start screen for navigation
import 'package:mpey/busfare/busfare_dashboard.dart';
import 'package:mpey/cargo/cargo_dashboard.dart';
import 'package:mpey/chamas/chama_dashboard.dart';
import 'package:mpey/insurance/insurance_dashboard.dart';
import 'package:mpey/events/events_dashboard.dart';
import 'package:mpey/church/church_dashboard.dart';
import 'package:mpey/schoolfee/schools_dashboard.dart';
import 'package:mpey/hospital/hospital_dashboard.dart';
import 'package:mpey/businesses/bizs_dashboard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _userEmail; // To store user email for logout

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userEmail = prefs.getString('user_email');
    });
  }

  Future<void> _logout() async {
    if (_userEmail == null || _userEmail!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user session found')),
      );
      return;
    }
    final response = await http.post(
      Uri.parse('https://test-mpay.onrender.com/flutter_logout.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': _userEmail,
      }),
    );
    if (response.statusCode == 200) {
      if (response.headers['content-type']?.contains('application/json') ?? false) {
        try {
          final data = json.decode(response.body);
          if (data['success']) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove('user_email'); // Clear user session
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logout successful!')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Start()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(data['message'] ?? 'Logout failed')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid response format: $e')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server returned non-JSON response: ${response.body}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Server error: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MPAY',
          style: TextStyle(
            fontSize: screenWidth * 0.06, // Responsive font size (6% of screen width)
          ),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              size: screenWidth * 0.07, // Responsive icon size
            ),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            _buildDrawerItem(
              context: context,
              title: 'Bus Fare',
              destination: const BusfareDashboard(),
              fontSize: screenWidth * 0.045, // Responsive font size
              margin: EdgeInsets.only(left: screenWidth * 0.04, top: screenHeight * 0.02),
            ),
            _buildDrawerItem(
              context: context,
              title: 'Cargo Transport',
              destination: const CargoDashboard(),
              fontSize: screenWidth * 0.045,
              margin: EdgeInsets.only(left: screenWidth * 0.04, top: screenHeight * 0.02),
            ),
            _buildDrawerItem(
              context: context,
              title: 'Events Tickets',
              destination: const EventsDashboard(),
              fontSize: screenWidth * 0.045,
              margin: EdgeInsets.only(left: screenWidth * 0.04, top: screenHeight * 0.02),
            ),
            //_buildDrawerItem(
              //context: context,
              //title: //'Chama Remittances',
              //destination: const ChamaDashboard(),
              //fontSize: screenWidth * 0.045,
              //margin: EdgeInsets.only(left: screenWidth * 0.04, top: screenHeight * 0.02),
            //),
            _buildDrawerItem(
              context: context,
              title: 'Insurance Premiums',
              destination: const InsuranceDashboard(),
              fontSize: screenWidth * 0.045,
              margin: EdgeInsets.only(left: screenWidth * 0.04, top: screenHeight * 0.02),
            ),
            //_buildDrawerItem(
              //context: context,
              //title: 'Church Remittances',
              //destination: const ChurchDashboard(),
              //fontSize: screenWidth * 0.045,
              //margin: EdgeInsets.only(left: screenWidth * 0.04, top: screenHeight * 0.02),
            //),
            //_buildDrawerItem(
              //context: context,
              //title: 'School Fees',
              //destination: const SchoolDashboard(),
              //fontSize: screenWidth * 0.045,
              //margin: EdgeInsets.only(left: screenWidth * 0.04, top: screenHeight * 0.02),
            //),
            //_buildDrawerItem(
              //context: context,
              //title: 'Hospitals',
              //destination: const HospitalDashboard(),
              //fontSize: screenWidth * 0.045,
              //margin: EdgeInsets.only(left: screenWidth * 0.04, top: screenHeight * 0.02),
            //),

             _buildDrawerItem(
              context: context,
              title: 'Businesses',
              destination: const BusinessesDashboard(),
              fontSize: screenWidth * 0.045,
              margin: EdgeInsets.only(left: screenWidth * 0.04, top: screenHeight * 0.02),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(screenWidth * 0.08), // Responsive margin (8% of screen width)
              child: Image.asset(
                'assets/mobilemoney/pay.jpg',
                width: screenWidth * 0.9, // 90% of screen width
                height: isPortrait ? screenHeight * 0.3 : screenHeight * 0.5, // Adjust height based on orientation
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.all(screenWidth * 0.08),
              child: Image.asset(
                'assets/mobilemoney/payment_successful.jpg',
                width: screenWidth * 0.9,
                height: isPortrait ? screenHeight * 0.3 : screenHeight * 0.5,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build drawer items
  Widget _buildDrawerItem({
    required BuildContext context,
    required String title,
    required Widget destination,
    required double fontSize,
    required EdgeInsets margin,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        alignment: Alignment.centerLeft,
        margin: margin,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}