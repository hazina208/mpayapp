
import 'package:flutter/material.dart';
//import './global_keys.dart';
import 'package:mpey/electricity/kengen.dart';
import 'package:mpey/electricity/kplc.dart';



class Electricity extends StatefulWidget {
  const Electricity({super.key});
  @override
  ElectricityState createState() => ElectricityState();
}

class ElectricityState extends State<Electricity> {
  final List<String> agencyNames = [
    'KPLC',
    'KENGEN',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Text('ELECTRICITY BIILLS PAYMENT DASHBOARD', style: TextStyle(color: Colors.white, fontSize: 14),),
           
          ],
        ),
      ),
      body: Container(
        color: Colors.grey.shade100, // ListView background color
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: agencyNames.length,
            itemBuilder: (context, index) {
              Color buttonColor = agencyNames[index] == 'KPLC, KENGEN'
                  ? Colors.blue.shade300
                  : Colors.teal.shade300;
                  
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (agencyNames[index] == 'KPLC') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KplcPower(agency: 'KPLC'),
                        ),
                      );
                    }
                    else if (agencyNames[index] == 'KENGEN') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KengenPower(agency: 'KENGEN'),
                        ),
                      );
                    }

                    
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${agencyNames[index]} pressed! Coming soon...')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(agencyNames[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
