
import 'package:flutter/material.dart';
//import './global_keys.dart';
import 'package:mpey/insurance/jubilee.dart';
import 'package:mpey/insurance/apa.dart';
import 'package:mpey/insurance/pioneer.dart';
import 'package:mpey/insurance/heritage.dart';
//import 'package:mpay/chamas/chamaB.dart';



class InsuranceDashboard extends StatefulWidget {
  const InsuranceDashboard({super.key});
  @override
  InsuranceDashboardState createState() => InsuranceDashboardState();
}

class InsuranceDashboardState extends State<InsuranceDashboard> {
  final List<String> saccoNames = [
    'JUBILEE INSURANCE',
    'HERITAGE INSURANCE',
    'AMACO INSURANCE',
    'MADISON INSURANCE',
    'MAYFAIR INSURANCE',
    'APA INSURANCE',
    'PIONEER INSURANCE',
    'OLD MUTUAL INSURANCE',
   
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Text('PREMIUMS PAYMENT DASHBOARD', style: TextStyle(color: Colors.white, fontSize: 14),),
           
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
              Color buttonColor = saccoNames[index] == 'JUBILEE INSURANCE, HERITAGE INSURANCE'
                  ? Colors.blue.shade300
                  : Colors.teal.shade300;
                  
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (saccoNames[index] == 'JUBILEE INSURANCE') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Jubilee(sacco: 'JUBILEE INSURANCE'),
                        ),
                      );
                    }
                    

                    else if (saccoNames[index] == 'APA INSURANCE') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Apa(sacco: 'APA INSURANCE'),
                        ),
                      );
                    }

                    else if (saccoNames[index] == 'PIONEER INSURANCE') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Pioneer(sacco: 'PIONEER INSURANCE'),
                        ),
                      );
                    }

                    else if (saccoNames[index] == 'HERITAGE INSURANCE') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Heritage(sacco: 'HERITAGE INSURANCE'),
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
