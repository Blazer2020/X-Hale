import 'package:flutter/material.dart';
import 'package:test_app/screens/authentication/register.dart';
import 'package:test_app/screens/authentication/sign_in.dart';

class Authenticate extends StatefulWidget {
  final bool isSignIn;
  const Authenticate({Key? key, required this.isSignIn}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  late bool
      signinPage; // Declare signinPage as late, to be initialized in initState()

  @override
  void initState() {
    super.initState();
    signinPage = widget
        .isSignIn; // Initialize signinPage with the value of isSignIn passed to the widget
  }

  void switchPages() {
    setState(() {
      signinPage = !signinPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (signinPage == true) {
      return Sign_In(toggle: switchPages);
    } else {
      return Register(toggle: switchPages);
    }
  }
}
