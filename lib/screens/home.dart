import 'package:flutter/material.dart';
import 'package:test_app/services/auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 30,top: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Hi!!\nGood Morning,\nYehen",style: TextStyle(fontSize:30,fontWeight:FontWeight.w500,color: Color.fromRGBO(55, 159, 153, 1.0)))),
                ),     
                Stack(
                  children : [
                    Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/keels.png"),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(78, 158, 158, 158),
                          blurRadius: 5.0,
                          offset: Offset(0.0, 2.0),
                        )
                      ],
                    ),
                    width: 340,
                    height: 140,
                    margin: const EdgeInsets.only(top: 20),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 255, 179, 1),
                      borderRadius: BorderRadius.circular(10),  
                    ),
                    width: 55,
                    height: 25,
                    padding: const EdgeInsets.all(3),
                    margin: const EdgeInsets.only(top: 30,left: 15),
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Promo",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  ],
                ),
                const SizedBox(height: 2),
                Center(child: Image.asset('assets/DailyProgress.png',height: 200,)),
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                        Image.asset('assets/box-1.png',height: 100,), 
                        Image.asset('assets/box-2.png',height: 100,)
                      ], ),
                      // const SizedBox(width:50,),
                      Center(child: Image.asset('assets/Donut.png',height: 210,))
                    ],
                  ),
              const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


