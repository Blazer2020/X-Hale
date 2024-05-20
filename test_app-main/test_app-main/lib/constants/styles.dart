import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
                        constraints: BoxConstraints(maxWidth: 350),
                        hintText: '    Email',
                        hintStyle: TextStyle(color: Color.fromARGB(255, 114, 189, 86),fontSize: 15),
                        fillColor: Color.fromARGB(255, 197, 253, 44),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:BorderSide(width: 1) ,
                          borderRadius: BorderRadius.all(Radius.circular(100))
                        )

                      );