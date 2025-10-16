
import 'package:flutter/material.dart';
//import './global_keys.dart';
import 'package:mpey/businesses/bizA.dart';
import 'package:mpey/businesses/bizB.dart';



class BusinessesDashboard extends StatefulWidget {
  const BusinessesDashboard({super.key});
  @override
  BusinessesDashboardState createState() => BusinessesDashboardState();
}

class BusinessesDashboardState extends State<BusinessesDashboard> {
  final List<String> bizNames = [
    'OSCAR MOBILES',
    'WALTEX TECHNOLOGIES',
   
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Text('BUSINESS PAYMENT DASHBOARD', style: TextStyle(color: Colors.white, fontSize: 14),),
           
          ],
        ),
      ),
      body: Container(
        color: Colors.grey.shade100, // ListView background color
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: bizNames.length,
            itemBuilder: (context, index) {
              Color buttonColor = bizNames[index] == 'OSCAR MOBILES, WALTEX TECHNOLOGIES'
                  ? Colors.blue.shade300
                  : Colors.teal.shade300;
                  
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (bizNames[index] == 'OSCAR MOBILES') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Oscars(biz: 'OSCAR MOBILES'),
                        ),
                      );
                    }
                    else if (bizNames[index] == 'WALTEX TECHNOLOGIES') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Waltexs(biz: 'WALTEX TECHNOLOGIES'),
                        ),
                      );
                    }
                    
                    
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${bizNames[index]} pressed! Coming soon...')),
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
                  child: Text(bizNames[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
