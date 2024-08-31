import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/pages/main_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _docnameController = TextEditingController();
  final TextEditingController _docnumberController = TextEditingController();
  final TextEditingController _medicalController = TextEditingController();

  String? gender;
  String? _imagePath;

  final _formKey = GlobalKey<FormState>();

  Future<void> saveDetailsToDevice() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("User details", [
      _usernameController.text,
      _passwordController.text,
      _birthdayController.text,
      gender ?? "",
      _numberController.text,
      _docnameController.text,
      _docnumberController.text,
      _medicalController.text,
      _imagePath ?? "",
    ]);
    await prefs.setBool("isSignedIn", true);

    if (_imagePath != null) {
    await prefs.setString("userImagePath", _imagePath!);
  }
  }

  Future<void> _chooseImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                onTap: () async {
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _imagePath = pickedFile.path;
                    });
                  }
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () async {
                  final pickedFile = await picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _imagePath = pickedFile.path;
                    });
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Signup Page"),
        backgroundColor: Color(0xFF81C9F3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () => _chooseImage(context),
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: _imagePath != null
                        ? FileImage(File(_imagePath!))
                        : AssetImage("assets/images/user.png") as ImageProvider,
                    child: Icon(Icons.camera_alt, size: 30, color: Colors.white.withOpacity(0.8)),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "User Details",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xFF1A237E),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _usernameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "User Name",
                    hintText: "Enter user name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a valid username";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter password (min. 6 characters)",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return "Please enter a valid password (min. 6 characters)";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    hintText: "Re-enter password",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _birthdayController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: "Birthday",
                    hintText: "DD/MM/YYYY",
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      _birthdayController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    }
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.male),
                    labelText: 'Gender',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  value: gender,
                  items: [
                    DropdownMenuItem(
                      value: "",
                      child: Text("Select Gender"),
                    ),
                    DropdownMenuItem(
                      value: "Male",
                      child: Text("Male"),
                    ),
                    DropdownMenuItem(
                      value: "Female",
                      child: Text("Female"),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      gender = newValue;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _numberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Contact Number",
                    hintText: "07xxxxxxxx",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _docnameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Family Doctor's Name",
                    hintText: "Enter family doctor's name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _docnumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Family Doctor's Contact Number",
                    hintText: "07xxxxxxxx",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _medicalController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Medical Concerns (If any)",
                    hintText: "Enter any medical concerns",
                    prefixIcon: Icon(Icons.medical_services),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    color: Color(0xFF81C9F3),
                    textColor: Color(0xFF1A237E),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await saveDetailsToDevice();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Successfully Signed Up!"),
                              icon: Icon(Icons.check_circle, color: Colors.green),
                              content: Text("Your details have been saved."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainPage(
                                              name: _usernameController.text, 
                                              imagePath: _imagePath ?? "")),
                                    );
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text("Sign Up", style: TextStyle(fontSize: 15.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
