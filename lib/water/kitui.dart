import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KituiWater extends StatefulWidget {
  final String agency;
  const KituiWater({super.key, required this.agency});

  @override
  _KituiWaterState createState() => _KituiWaterState();
}

class _KituiWaterState extends State<KituiWater> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _phoneController = TextEditingController();
 
  String? errorMessage;
  bool _isLoading = false;



  @override
  void dispose() {
    _amountController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

 

  String _formatPhoneNumber(String phone) {
    if (phone.startsWith('07') && phone.length == 10) {
      return '254${phone.substring(1)}';
    }
    return phone;
  }

  Future<void> initiatePayment() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }
    setState(() => _isLoading = true);
    final formattedPhone = _formatPhoneNumber(_phoneController.text);

    final url = Uri.parse('https://test-mpay.onrender.com/mpesa/water/stk_push.php');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer your_token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'agency': widget.agency,
        'amount': double.parse(_amountController.text),
        'phone_number': formattedPhone,
      }),
    );

    try {
      final result = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Can not Complete STK Push.')),
      );
    }
    finally {
      setState(() => _isLoading = false); // always stop spinner
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Text(
              '${widget.agency} PAYMENTS',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount (KES)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter amount' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number (07xxxxxxxx)',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter phone number';
                  }
                  if (!RegExp(r'^07[0-9]{8}$').hasMatch(value)) {
                    return 'Enter a valid phone number (e.g., 07xxxxxxxx)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: initiatePayment,
                      child: const Text('Pay with M-Pesa'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}