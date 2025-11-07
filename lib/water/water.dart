
import 'package:flutter/material.dart';
//import './global_keys.dart';
import 'package:mpey/water/kitui.dart';
import 'package:mpey/water/nairobi.dart';
import 'package:mpey/water/muranga.dart';



class WaterBills extends StatefulWidget {
  const WaterBills({super.key});
  @override
  WaterBillsState createState() => WaterBillsState();
}

class WaterBillsState extends State<WaterBills> {
  final List<String> agencyNames = [
    'NCWSC',
    'MUWASCO',
    'KITWASCO',
   
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Text('WATER BIILLS PAYMENT DASHBOARD', style: TextStyle(color: Colors.white, fontSize: 14),),
           
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
              Color buttonColor = agencyNames[index] == 'MURANGA, NAIROBI'
                  ? Colors.blue.shade300
                  : Colors.teal.shade300;
                  
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (agencyNames[index] == 'NCWSC') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NairobiWater(agency: 'NCWSC'),
                        ),
                      );
                    }
                    else if (agencyNames[index] == 'MUWASCO') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MurangaWater(agency: 'MUWASCO'),
                        ),
                      );
                    }

                    else if (agencyNames[index] == 'KITWASCO') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KituiWater(agency: 'KITWASCO'),
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
