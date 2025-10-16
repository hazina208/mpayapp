
import 'package:flutter/material.dart';
//import './global_keys.dart';
import 'package:mpey/schoolfee/schoolA.dart';
import 'package:mpey/schoolfee/schoolB.dart';



class SchoolDashboard extends StatefulWidget {
  const SchoolDashboard({super.key});
  @override
  SchoolDashboardState createState() => SchoolDashboardState();
}

class SchoolDashboardState extends State<SchoolDashboard> {
  final List<String> schoolNames = [
    'SCHOOL A',
    'SCHOOL B',
   
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Text('SCHOOL FEE PAYMENT DASHBOARD', style: TextStyle(color: Colors.white, fontSize: 14),),
           
          ],
        ),
      ),
      body: Container(
        color: Colors.grey.shade100, // ListView background color
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: schoolNames.length,
            itemBuilder: (context, index) {
              Color buttonColor = schoolNames[index] == 'SCHOOL A, SCHOOL B'
                  ? Colors.blue.shade300
                  : Colors.teal.shade300;
                  
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (schoolNames[index] == 'SCHOOL A') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SchoolA(school: 'SCHOOL A'),
                        ),
                      );
                    }
                    else if (schoolNames[index] == 'SCHOOL B') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SchoolB(school: 'SCHOOL B'),
                        ),
                      );
                    }
                    
                    
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${schoolNames[index]} pressed! Coming soon...')),
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
                  child: Text(schoolNames[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
