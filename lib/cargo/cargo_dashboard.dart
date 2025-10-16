
import 'package:flutter/material.dart';
//import './global_keys.dart';
import 'package:mpey/cargo/bahari.dart';
import 'package:mpey/cargo/dreamline.dart';
import 'package:mpey/cargo/gurdian.dart';
import 'package:mpey/cargo/nakufleet.dart';
import 'package:mpey/cargo/sslfreight.dart';


class CargoDashboard extends StatefulWidget {
  const CargoDashboard({super.key});
  @override
  CargoDashboardState createState() => CargoDashboardState();
}

class CargoDashboardState extends State<CargoDashboard> {
  final List<String> saccoNames = [
    'BAHARI',
    'DREAMLINE',
    'GURDIAN',
    'NAKUFLEET',
    'SSLFREIGHT',
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Text('CARGO PAYMENT DASHBOARD', style: TextStyle(color: Colors.white, fontSize: 14),),
           
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
              Color buttonColor = saccoNames[index] == 'BAHARI, NAKUFLEET'
                  ? Colors.blue.shade300
                  : Colors.teal.shade300;
                  
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (saccoNames[index] == 'BAHARI') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Bahari(sacco: 'BAHARI'),
                        ),
                      );
                    }
                    else if (saccoNames[index] == 'NAKUFLEET') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Nakufleet(sacco: 'NAKUFLEET'),
                        ),
                      );
                    }
                    else if (saccoNames[index] == 'GURDIAN') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Gurdian(sacco: 'GURDIAN'),
                        ),
                      );
                    }
                    else if (saccoNames[index] == 'DREAMLINE') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dreamline(sacco: 'DREAMLINE'),
                        ),
                      );
                    
                    }
                    else if (saccoNames[index] == 'SSLFREIGHT') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Sslfreight(sacco: 'SSLFREIGHT'),
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
