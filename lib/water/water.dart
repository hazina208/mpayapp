import 'package:flutter/material.dart';

class WaterBills extends StatefulWidget {
  const WaterBills({super.key});

  @override
  State<WaterBills> createState() => _WaterBillsState();
}

class _WaterBillsState extends State<WaterBills> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Text('PAY WATER BILLS', style: TextStyle(color: Colors.white, fontSize: 14),),
           
          ],
        ),

      ),
    );
  }
}