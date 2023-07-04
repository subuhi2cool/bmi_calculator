import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var weightController = TextEditingController();
  var heightFeetController = TextEditingController();
  var heightInchesController = TextEditingController();
  var result = "";
  var txtColor = Colors.black;

  void _calculateBMI(){
    var weight =  weightController.text.toString();
    var heightFeet = heightFeetController.text.toString();
    var heightInches = heightInchesController.text.toString();
    txtColor = Colors.black;
    FocusManager.instance.primaryFocus?.unfocus();

    if( weight != "" && heightFeet != "" && heightInches != "" ){
      //    BMI Calculation
      var weightInt = int.parse(weight);
      var heightFeetInt = int.parse(heightFeet);
      var heightInchesInt = int.parse(heightInches);
      var totalHeightInInches = ( heightFeetInt * 12 )+ heightInchesInt;
      var totalHeightInCms = ( totalHeightInInches * 2.54 );
      var totalHeightInM = totalHeightInCms / 100 ;
      var bmi = weightInt / (totalHeightInM * totalHeightInM)  ;
      var msg = "";

      if(bmi>25) {
        msg = "You are OverWeight!!";
        txtColor = Colors.deepOrangeAccent;
      }
      else if (bmi<18) {
        msg = "You are UnderWeight!!";
        txtColor = Colors.red;
      }
      else {
        msg = "You are Healthy!!";
        txtColor = Colors.green.shade800;
      }

      result = "$msg \nYour BMI is : ${bmi.toStringAsFixed(2)}";
    }
    else{
        result = "Please fill all the required fields!!";
      }

    setState(() {

    });

    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Calulate Your BMI", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Container(
        color: Colors.white,
            child: Center(
              child: SizedBox(
                width: 300,
                child: Column(

                  children: [
                    const SizedBox(height: 11,),
                    const Text('BMI',style: TextStyle(
                      fontSize: 34,fontWeight: FontWeight.w700
                    ),),
                    const SizedBox(height: 11,),
                  // Weight
                    const Text('Enter your weight',textAlign: TextAlign.start,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    TextField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text('(Kg)'),
                        prefixIcon: Icon(Icons.line_weight_outlined),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    //Height
                    const Text('Enter your height',textAlign: TextAlign.start,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              Row(
                                children: [
                                  Expanded(
                                        child: TextField(
                                        controller: heightFeetController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          label: Text('(feet)'),
                                          prefixIcon: Icon(Icons.height),
                                        ),
                                      ),

                                  ),

                                  Expanded(
                                      child: TextField(
                                        controller: heightInchesController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          label: Text('(inches)'),
                                          prefixIcon: Icon(Icons.height),
                                        ),
                                      ),
                                    ),
                                ],
                              ),


                    const SizedBox(height: 16,),
                    ElevatedButton(onPressed: _calculateBMI, child: const Text('Calculate')),
                    const SizedBox(height: 11),
                    Text(result, style: TextStyle(color: txtColor,fontSize: 19,fontWeight: FontWeight.bold)),
                  ],
                ),
          ),
            ),
      ),
      );
  }
}
