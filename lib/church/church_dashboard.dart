
import 'package:flutter/material.dart';
//import './global_keys.dart';
import 'package:mpey/church/churchA.dart';
import 'package:mpey/church/churchB.dart';



class ChurchDashboard extends StatefulWidget {
  const ChurchDashboard({super.key});
  @override
  ChurchDashboardState createState() => ChurchDashboardState();
}

class ChurchDashboardState extends State<ChurchDashboard> {
  final List<String> churchNames = [
    'CHURCH A',
    'CHURCH B',
   
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Text('CHURCH REMITTANCES DASHBOARD', style: TextStyle(color: Colors.white, fontSize: 14),),
           
          ],
        ),
      ),
      body: Container(
        color: Colors.grey.shade100, // ListView background color
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: churchNames.length,
            itemBuilder: (context, index) {
              Color buttonColor = churchNames[index] == 'CHURCH A, CHURCH B'
                  ? Colors.blue.shade300
                  : Colors.teal.shade300;
                  
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (churchNames[index] == 'CHURCH A') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChurchA(church: 'CHURCH A'),
                        ),
                      );
                    }
                    else if (churchNames[index] == 'CHURCH B') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChurchB(church: 'CHAMA B'),
                        ),
                      );
                    }
                    
                    
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${churchNames[index]} pressed! Coming soon...')),
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
                  child: Text(churchNames[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
