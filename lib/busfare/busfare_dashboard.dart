
import 'package:flutter/material.dart';
//import './global_keys.dart';
import 'package:mpey/busfare/manatwa.dart';
import 'package:mpey/busfare/kinatwa.dart';
import 'package:mpey/busfare/supermetro.dart';
import 'package:mpey/busfare/naekana.dart';
import 'package:mpey/busfare/prestige.dart';
import 'package:mpey/busfare/umoinner.dart';
import 'package:mpey/busfare/utimo.dart';
import 'package:mpey/busfare/foward.dart';

class BusfareDashboard extends StatefulWidget {
  const BusfareDashboard({super.key});
  @override
  BusfareDashboardState createState() => BusfareDashboardState();
}

class BusfareDashboardState extends State<BusfareDashboard> {
  final List<String> saccoNames = [
    'MANATWA SACCO',
    'KINATWA SACCO',
    'NAEKANA SACCO',
    'PRESTIGE SACCO',
    'SUPERMETRO SACCO',
    'UMOINNER SACCO',
    'UTIMO SACCO',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Text('PAY BUSFARE DASHBOARD', style: TextStyle(color: Colors.white, fontSize: 14),),
           
          ],
        ),
      ),
      body: Container(
        color: Colors.grey.shade100, // ListView background color
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: saccoNames.length,
            itemBuilder: (context, index) {
              Color buttonColor = saccoNames[index] == 'MANATWA SACCO, KINATWA SACCO'
                  ? Colors.blue.shade300
                  : Colors.teal.shade300;
                  
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (saccoNames[index] == 'MANATWA SACCO') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Manatwa(sacco: 'MANATWA'),
                        ),
                      );
                    }
                    else if (saccoNames[index] == 'NAEKANA SACCO') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Naekana(sacco: 'NAEKANA'),
                        ),
                      );
                    }
                    else if (saccoNames[index] == 'KINATWA SACCO') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Kinatwa(sacco: 'KINATWA'),
                        ),
                      );
                    }
                    else if (saccoNames[index] == 'PRESTIGE SACCO') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Prestige(sacco: 'PRESTIGE'),
                        ),
                      );
                    
                    }
                    else if (saccoNames[index] == 'SUPERMETRO SACCO') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Supermetro(sacco: 'SUPERMETRO'),
                        ),
                      );
                    
                    }
                    else if (saccoNames[index] == 'UMOINNER SACCO') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Umoinner(sacco: 'UMOINNER'),
                        ),
                      );
                    
                    }
                    else if (saccoNames[index] == 'UTIMO SACCO') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Utimo(sacco: 'UTIMO'),
                        ),
                      );
                    
                    }

                    else if (saccoNames[index] == 'FOWARD SACCO') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Foward(sacco: 'FOWARD'),
                        ),
                      );
                    
                    }  
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${saccoNames[index]} pressed! Coming soon...')),
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
                  child: Text(saccoNames[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
