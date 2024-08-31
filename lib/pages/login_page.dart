import 'package:app/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late String savedUsername = '';
  late String savedPassword = '';
  late String imagePath;

  Future<void> fetchDetailsFromDevice() async {
    final prefs = await SharedPreferences.getInstance();
    final userDetails = prefs.getStringList("User details");
    if (userDetails != null && userDetails.length >= 2) {
      setState(() {
        savedUsername = userDetails[0];
        savedPassword = userDetails[1];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDetailsFromDevice();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login Page"),
        backgroundColor: Color(0xFF81C9F3),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('assets/images/logo.png', height: 150),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Color(0xFF1A237E),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(
                    controller: _usernameController,
                    label: "User Name",
                    hint: "Enter user name",
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(
                    controller: _passwordController,
                    label: "Password",
                    hint: "Enter password",
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth > 600 ? 50 : 10,
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      color: Colors.lightBlueAccent,
                      textColor: Color(0xFF1A237E),
                      onPressed: _handleLogin,
                      child: Text("Login"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth > 600 ? 50 : 10,
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      color: Colors.lightBlueAccent,
                      textColor: Color(0xFF1A237E),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupPage()),
                      ),
                      child: const Text("New user? Signup here."),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter a valid $label";
        }
        return null;
      },
    );
  }

  void _handleLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    if (username == savedUsername && password == savedPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(name: username,imagePath: imagePath,),
        ),
      );
      _usernameController.clear();
      _passwordController.clear();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Invalid Details!"),
          content: Text("Please check your username and password."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}
