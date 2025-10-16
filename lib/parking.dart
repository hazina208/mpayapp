import 'package:flutter/material.dart';

class Parking extends StatefulWidget {
  const Parking({super.key});

  @override
  State<Parking> createState() => _ParkingState();
}

class _ParkingState extends State<Parking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Text('PAY COUNTY FEE', style: TextStyle(color: Colors.white, fontSize: 14),),
           
          ],
        ),

      ),
    );
  }
}