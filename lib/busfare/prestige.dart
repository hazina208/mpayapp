import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Prestige extends StatefulWidget {
  final String sacco;
  const Prestige({super.key, required this.sacco});

  @override
  _PrestigeState createState() => _PrestigeState();
}

class _PrestigeState extends State<Prestige> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _phoneController = TextEditingController();
  List<String> fleetNumbers = [];
  String? selectedFleet;
  String? errorMessage;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFleetNumbers();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> fetchFleetNumbers() async {
    final url = Uri.parse("https://test-mpay.onrender.com/mpesa/busfares/get_fleet.php?sacco=${widget.sacco}");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        fleetNumbers = data.map((e) => e['fleet_no'].toString()).toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception("Failed to load fleet numbers");
    }
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

    final url = Uri.parse('https://test-mpay.onrender.com/mpesa/busfares/stk_push.php');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer your_token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'sacco': widget.sacco,
        'amount': double.parse(_amountController.text),
        'fleet_no': selectedFleet,
        'phone_number': formattedPhone,
      }),
    );
    setState(() => _isLoading = false);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Text(
              '${widget.sacco} SACCO FARE PAYMENT',
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
              // Autocomplete for fleet number selection
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return fleetNumbers;
                  }
                  return fleetNumbers.where((fleet) => fleet
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                },
                onSelected: (String selection) {
                  setState(() {
                    selectedFleet = selection;
                  });
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController fieldTextEditingController,
                    FocusNode fieldFocusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextFormField(
                    controller: fieldTextEditingController,
                    focusNode: fieldFocusNode,
                    decoration: const InputDecoration(
                      labelText: 'Select Fleet No',
                      hintText: 'Type or select a fleet number',
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please select a fleet number' : null,
                    onChanged: (value) {
                      setState(() {
                        selectedFleet = value.isNotEmpty &&
                                fleetNumbers.contains(value)
                            ? value
                            : null;
                      });
                    },
                  );
                },
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<String> onSelected,
                    Iterable<String> options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4.0,
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        width: MediaQuery.of(context).size.width - 32,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final String option = options.elementAt(index);
                            return GestureDetector(
                              onTap: () {
                                onSelected(option);
                              },
                              child: ListTile(
                                title: Text(option),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
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