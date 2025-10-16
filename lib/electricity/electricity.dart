import 'package:flutter/material.dart';

class Electricity extends StatefulWidget {
  const Electricity({super.key});

  @override
  State<Electricity> createState() => _ElectricityState();
}

class _ElectricityState extends State<Electricity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Text('PAY ELECTRICITY BILL', style: TextStyle(color: Colors.white, fontSize: 14),),
           
          ],
        ),

      ),
    );
  }
}