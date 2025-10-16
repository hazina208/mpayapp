
import 'package:flutter/material.dart';
//import './global_keys.dart';
import 'package:mpey/hospital/hospitalA.dart';
import 'package:mpey/hospital/hospitalB.dart';



class HospitalDashboard extends StatefulWidget {
  const HospitalDashboard({super.key});
  @override
  HospitalDashboardState createState() => HospitalDashboardState();
}

class HospitalDashboardState extends State<HospitalDashboard> {
  final List<String> hospitalNames = [
    'HOSPITAL A',
    'HOSPITAL B',
   
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Text('HOSPITAL PAYMENT DASHBOARD', style: TextStyle(color: Colors.white, fontSize: 14),),
           
          ],
        ),
      ),
      body: Container(
        color: Colors.grey.shade100, // ListView background color
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: hospitalNames.length,
            itemBuilder: (context, index) {
              Color buttonColor = hospitalNames[index] == 'HOSPITAL A, HOSPITAL B'
                  ? Colors.blue.shade300
                  : Colors.teal.shade300;
                  
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (hospitalNames[index] == 'HOSPITAL A') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HospitalA(hospital: 'HOSPITAL A'),
                        ),
                      );
                    }
                    else if (hospitalNames[index] == 'HOSPITAL B') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HospitalB(hospital: 'HOSPITAL B'),
                        ),
                      );
                    }
                    
                    
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${hospitalNames[index]} pressed! Coming soon...')),
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
                  child: Text(hospitalNames[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
