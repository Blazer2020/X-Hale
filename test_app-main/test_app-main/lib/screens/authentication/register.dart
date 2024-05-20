import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app/models/user_model.dart';
import 'package:test_app/services/auth.dart';
import 'package:test_app/widgets/buttons.dart';
import 'package:test_app/widgets/form.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:test_app/widgets/navbar.dart';
import 'package:toastification/toastification.dart';

class Register extends StatefulWidget {
  final Function toggle;
  const Register({Key? key, required this.toggle}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthServices _auth =
      AuthServices(); // Assuming this is correctly set up
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";
  String phone = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 50),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
                child: Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.rectangle,
                        ),
                        child: Column(
                          children: [
                            // Row(
                            //   children: [
                            //     OutlinedButtonPrimary(
                            //       onPressed: () {
                            //         Navigator.pop(context);
                            //       },
                            //       child: const Icon(
                            //         Icons.arrow_back_ios_new,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Text('Hello! Register to get started',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )),
                            const SizedBox(height: 30),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    const InputName(labelText: 'First Name'),
                                    const SizedBox(height: 20),
                                    const InputName(labelText: 'Last Name'),
                                    const SizedBox(height: 20),
                                    InputEmail(
                                        labelText: 'Email',
                                        onChange: (String? value) {
                                          setState(() {
                                            email = value!;
                                          });
                                        }),
                                    const SizedBox(height: 20),
                                    const InputPhone(labelText: 'Phone'),
                                    const SizedBox(height: 20),
                                    InputPassword(
                                      labelText: 'Password',
                                      onChange: (String? value) {
                                        setState(() {
                                          password = value!;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    FilledButtonSecondary(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            dynamic result = await _auth
                                                .registerWithEmailAndPassword(
                                                    email, password);
                                            if (result == null) {
                                              setState(() {
                                                error =
                                                    'Please supply a valid email';
                                              });
                                            }
                                          }
                                        },
                                        text: "Register"),
                                    const SizedBox(height: 20),
                                  ],
                                )),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 24),
                              child: Container(
                                width: 370,
                                child: Stack(
                                  alignment: const AlignmentDirectional(0, 0),
                                  children: [
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 12, 0, 12),
                                        child: Container(
                                          width: double.infinity,
                                          height: 1.6,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outlineVariant,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      child: Container(
                                        width: 70,
                                        height: 32,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        alignment:
                                            const AlignmentDirectional(0, 0),
                                        child: Text(
                                          'OR',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            OutlinedButtonPrimary(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      dynamic result = await _auth
                                          .registerWithEmailAndPassword(
                                              email, password);
                                      if (result != null) {
                                        UserModel(uid: result.uid);
                                        toastification.show(
                                          context: context,
                                          title: Text('Hello, world!'),
                                          autoCloseDuration:
                                              const Duration(seconds: 5),
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NavBar()),
                                        );
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      switch (e.code) {
                                        case 'email-already-in-use':
                                          print("hi");
                                          toastification.show(
                                            context: context,
                                            type: ToastificationType.error,
                                            alignment: Alignment.bottomCenter,
                                            title: const Text(
                                                'Email Already in use'),
                                            autoCloseDuration:
                                                const Duration(seconds: 5),
                                          );
                                          break;
                                        default:
                                          toastification.show(
                                            context: context,
                                            type: ToastificationType.error,
                                            alignment: Alignment.bottomCenter,
                                            title: const Text(
                                                'An unexpected error occured.'),
                                            autoCloseDuration:
                                                const Duration(seconds: 5),
                                          );
                                      }
                                    } catch (e) {
                                      // Handle any other exceptions
                                      setState(() {
                                        error =
                                            'An error occurred. Please try again.';
                                      });
                                    }
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(PhosphorIcons.google_logo_bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .shadow),
                                    const SizedBox(width: 10),
                                    Text('Continue With Google',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .shadow,
                                            ))
                                  ],
                                )),
                            const SizedBox(height: 10),
                            OutlinedButtonPrimary(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        error = 'registration failed';
                                      });
                                    }
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(PhosphorIcons.apple_logo_bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .shadow),
                                    const SizedBox(width: 10),
                                    Text('Continue With Apple',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .shadow,
                                            )),
                                  ],
                                )),
                            const SizedBox(height: 10),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Already have an account?',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .shadow,
                                          )),
                                  TextButton(
                                      onPressed: () {
                                        widget.toggle();
                                      },
                                      child: Text('Login Now',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              )))
                                ],
                              ),
                            )
                          ],
                        ))))),
      ),
    );
  }
}
