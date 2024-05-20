import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TotalContribution extends StatefulWidget {
  const TotalContribution({super.key});

  @override
  State<TotalContribution> createState() => _TotalContributionState();
}

class _TotalContributionState extends State<TotalContribution> {
  double totalContribution = 688490.23;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/total_contribution.png"),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            width: 340,
            height: 200,
            child: 
          Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10), // Increase the right padding value to increase the column gap
                      child: Image(
                        image: AssetImage("assets/rysco.png"),
                        width: 50,
                        height: 50,
                      ),
                    ),
                    Column (
                      children: [
                        Text(
                          '$totalContribution',
                          style: const TextStyle(
                            color: Color.fromARGB(255,206, 255, 241),
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          "Total Contribution",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 50, 0, 0),
                  child: Row(
                    children: [
                      
                      FilledButton(
                          onPressed: () {
                            // Add your button click logic here
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(211, 255, 222, 0.8),
                            padding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Wallet",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      const SizedBox(width: 10),
                      FilledButton(
                          onPressed: () {
                            // Add your button click logic here
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(211, 255, 222, 0.8),
                            padding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),  
                          ),
                          child: const Text(
                            "Share",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    
                    ],
                  ),
                   
                ),
              ],)
            ],
          ),
          ),
          
        ],
      ),
    );
  }
}

class MyContribution extends StatefulWidget {
  const MyContribution({super.key});

  @override
  State<MyContribution> createState() => _MyContributionState();
}

class _MyContributionState extends State<MyContribution> {
  double myContribution = 2800.23;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 340,
        height: 140,
        margin: const EdgeInsets.only(top: 230),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ]
          ),
        child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "My Contribution",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 10,top:10), // Increase the right padding value to increase the column gap
                              child: Image(
                                image: AssetImage("assets/rysco.png"),
                                width: 40,
                              ),
                            ),
                            Column (
                              children: [
                                Text(
                                  '$myContribution',
                                  style: const TextStyle(
                                    color: Color.fromRGBO(65, 154, 149, 1.0),
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ), 
                              ],
                            )
                          ],
                        ),
                      const Text(
                          "     in this week",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
        )
    );
  }
}

class LatestRysco extends StatefulWidget {
  const LatestRysco({super.key});

  @override
  State<LatestRysco> createState() => _LatestRyscoState();
}

class _LatestRyscoState extends State<LatestRysco> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 340,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ]
          ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 15, 0, 10),
          child: const Row(
            children: [
              Image(
                image: AssetImage("assets/rysco.png"),
                width: 40,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Colombo 10",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Type : Plastic : #001020\nRysco : 120",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}