import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mpey/login.dart';

const String apiBaseUrl = 'https://test-mpay.onrender.com'; // Replace with your server URL

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _positionController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _roleController = TextEditingController();

  List<String> entities = [];
  List<String> entityNames = [];
  String? selectedEntity;
  String? selectedEntityName;

  String _errorMessage = '';

  // Entity to role number mapping
  final Map<String, String> _entityRoleMap = {
    'Sacco': '8',
    'Cargo Sacco': '9',
    'Matatu Sacco': '10',
    'Chama': '11',
    'company': '1',
    'Insurance Company': '12',
    // Add more entities and their corresponding role numbers as needed
  };


@override
  void initState() {
    super.initState();
    _loadEntities();
  }


  Future<void> _loadEntities() async {
    try {
      final response = await http.get(
        Uri.parse('$apiBaseUrl/get_entities.php'),
           headers: {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/85.0.4183.102 Safari/537.36",
            "Accept": "application/json",
  },
   
      );
      if (response.statusCode == 200) {
        setState(() {
          entities = List<String>.from(json.decode(response.body));
        });
      } else {
        if (mounted) { 
          setState(() {
          _errorMessage = 'Failed to load entities';
          });
        
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
        _errorMessage = 'Error loading entities: $e';
        });
      }
      
    }
  }

  Future<void> _loadEntityNames(String entity) async {
    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/get_entity_names.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'entity': entity}),
      );
      if (response.statusCode == 200) {
        setState(() {
          entityNames = List<String>.from(json.decode(response.body));
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load entity names';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading entity names: $e';
      });
    }
  }

Future<void> _register() async {
  if (_formKey.currentState!.validate()) {
    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/flutter_register.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'phone_number': _phoneNumberController.text,
          'entity': selectedEntity,
          'entity_name':selectedEntityName,
          'first_name': _firstNameController.text,
          'last_name': _lastNameController.text,
          'middle_name': _middleNameController.text,
          'position': _positionController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'role': _roleController.text,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Try to parse JSON
      try {
        final data = json.decode(response.body);
        if (data['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginWidget()),
          );
        } else {
          setState(() {
            _errorMessage = data['message'] ?? 'Registration failed';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Invalid server response: $e';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error during registration: $e';
      });
    }
  }
}

  @override
@override
Widget build(BuildContext context) {
  // Get screen size and orientation using MediaQuery
  final screenSize = MediaQuery.of(context).size;
  final double screenWidth = screenSize.width;
  final double screenHeight = screenSize.height;
  final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  // Define responsive padding and font sizes
  final double padding = screenWidth * 0.04; // 4% of screen width
  final double fontSize = screenWidth * 0.04; // Responsive font size
  final double textFieldWidth = screenWidth * 0.9; // 90% of screen width
  final double buttonHeight = screenHeight * 0.07; // 7% of screen height

  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Register',
        style: TextStyle(fontSize: fontSize * 1.2), // Larger font for title
      ),
    ),
    body: Padding(
      padding: EdgeInsets.all(padding), // Responsive padding
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              width: textFieldWidth,
              child: TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(fontSize: fontSize),
                ),
                style: TextStyle(fontSize: fontSize),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Responsive spacing
            SizedBox(
              width: textFieldWidth,
              child: DropdownButtonFormField<String>(
                initialValue: selectedEntity,
                decoration: InputDecoration(
                  labelText: 'Entity',
                  labelStyle: TextStyle(fontSize: fontSize),
                ),
                items: entities.map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(fontSize: fontSize)))).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedEntity = value;
                    entityNames = [];
                    selectedEntityName = null;
                    _roleController.text = value != null ? _entityRoleMap[value] ?? '' : '';
                  });
                  if (value != null) {
                    _loadEntityNames(value);
                  }
                },
                validator: (value) => value == null ? 'Required' : null,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              width: textFieldWidth,
              child: DropdownButtonFormField<String>(
                initialValue: selectedEntityName,
                decoration: InputDecoration(
                  labelText: 'Entity Name',
                  labelStyle: TextStyle(fontSize: fontSize),
                ),
                items: entityNames.map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(fontSize: fontSize)))).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedEntityName = value;
                  });
                },
                validator: (value) => value == null ? 'Required' : null,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              width: textFieldWidth,
              child: TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(fontSize: fontSize),
                ),
                style: TextStyle(fontSize: fontSize),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              width: textFieldWidth,
              child: TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(fontSize: fontSize),
                ),
                style: TextStyle(fontSize: fontSize),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              width: textFieldWidth,
              child: TextFormField(
                controller: _middleNameController,
                decoration: InputDecoration(
                  labelText: 'Middle Name',
                  labelStyle: TextStyle(fontSize: fontSize),
                ),
                style: TextStyle(fontSize: fontSize),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              width: textFieldWidth,
              child: TextFormField(
                controller: _positionController,
                decoration: InputDecoration(
                  labelText: 'Position',
                  labelStyle: TextStyle(fontSize: fontSize),
                ),
                style: TextStyle(fontSize: fontSize),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              width: textFieldWidth,
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(fontSize: fontSize),
                ),
                style: TextStyle(fontSize: fontSize),
                validator: (value) {
                  if (value!.isEmpty) return 'Required';
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Invalid email';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              width: textFieldWidth,
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: fontSize),
                ),
                style: TextStyle(fontSize: fontSize),
                obscureText: true,
                validator: (value) => value!.length < 6 ? 'At least 6 characters' : null,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              width: textFieldWidth,
              child: TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(fontSize: fontSize),
                ),
                style: TextStyle(fontSize: fontSize),
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) return 'Passwords do not match';
                  return null;
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              width: textFieldWidth,
              child: TextFormField(
                controller: _roleController,
                decoration: InputDecoration(
                  labelText: 'Role',
                  labelStyle: TextStyle(fontSize: fontSize),
                ),
                style: TextStyle(fontSize: fontSize),
                readOnly: true,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontSize: fontSize * 0.9),
              ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              width: textFieldWidth,
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: _register,
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: fontSize),
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