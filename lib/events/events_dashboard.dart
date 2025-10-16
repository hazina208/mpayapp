
import 'package:flutter/material.dart';
//import './global_keys.dart';
import 'package:mpey/events/eventA.dart';
import 'package:mpey/events/eventB.dart';



class EventsDashboard extends StatefulWidget {
  const EventsDashboard({super.key});
  @override
  EventsDashboardState createState() => EventsDashboardState();
}

class EventsDashboardState extends State<EventsDashboard> {
  final List<String> saccoNames = [
    'EVENT A',
    'EVENT B',
   
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Text('EVENT PAYMENT DASHBOARD', style: TextStyle(color: Colors.white, fontSize: 14),),
           
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
              Color buttonColor = saccoNames[index] == 'EVENT A, EVENT B'
                  ? Colors.blue.shade300
                  : Colors.teal.shade300;
                  
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (saccoNames[index] == 'EVENT A') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventA(sacco: 'EVENT A'),
                        ),
                      );
                    }
                    else if (saccoNames[index] == 'EVENT B') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventB(sacco: 'EVENT B'),
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
