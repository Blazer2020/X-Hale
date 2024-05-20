import 'package:flutter/material.dart';
import 'package:test_app/screens/profile/profile_widgets.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 30),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Profile",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Stack(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      TotalContribution(),
                      MyContribution(),
                      Padding(
                        padding: EdgeInsets.only(top: 140, left: 190),
                        child: Image(
                          image: AssetImage("assets/vase.png"),
                          width: 120,
                          height: 120,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 340,
                height: 175,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/garbage_circle.png"),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
              ),
              const LatestRysco(),
              const SizedBox(
                width: 375,
                height: 140,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                      image: AssetImage("assets/graph.png"),
                      width: 225,
                      height: 155,
                      fit: BoxFit.fill,
                    ),
                   
                    Image(
                      image: AssetImage("assets/goalsBox.png"),
                      width: 135,
                      height: 155,
                      fit: BoxFit.fill,
                    ),
                    
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      );
  }
}
