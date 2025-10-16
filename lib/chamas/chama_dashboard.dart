
import 'package:flutter/material.dart';
//import './global_keys.dart';
import 'package:mpey/chamas/chamaA.dart';
import 'package:mpey/chamas/chamaB.dart';



class ChamaDashboard extends StatefulWidget {
  const ChamaDashboard({super.key});
  @override
  ChamaDashboardState createState() => ChamaDashboardState();
}

class ChamaDashboardState extends State<ChamaDashboard> {
  final List<String> saccoNames = [
    'CHAMA A',
    'CHAMA B',
   
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Text('CHAMA PAYMENT DASHBOARD', style: TextStyle(color: Colors.white, fontSize: 14),),
           
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
              Color buttonColor = saccoNames[index] == 'CHAMA A, CHAMA B'
                  ? Colors.blue.shade300
                  : Colors.teal.shade300;
                  
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (saccoNames[index] == 'CHAMA A') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChamaA(sacco: 'CHAMA A'),
                        ),
                      );
                    }
                    else if (saccoNames[index] == 'CHAMA B') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChamaB(sacco: 'CHAMA B'),
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
