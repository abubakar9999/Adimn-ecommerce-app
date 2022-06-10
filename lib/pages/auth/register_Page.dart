import 'dart:convert';

import 'package:admin_ecommarce/http/coustom_http_request.dart';
import 'package:admin_ecommarce/pages/auth/sign_In_page.dart';
import 'package:flutter/material.dart';

import '../../widgets/tost_message.dart';

import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

Future<bool> check() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
    // I am connected to a mobile network.
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
    // I am connected to a wifi network.
  }
  showInToast("No Internet");
  return false;
}

getRegester() async {
  check().then((internet) async {
    if (internet != null && internet) {
      var map = Map<String, dynamic>();
      map["name"] = nameController.text.toString();
      map["email"] = emailController.text.toString();
      map["password"] = passwordController.text.toString();
      map["password_confirmation"] = confromPassword.text.toString();

      var respons = await http.post(
        Uri.parse(
            "https://apihomechef.antopolis.xyz/api/admin/create/new/admin"),
        body: map,
        headers: CustomHttpRequest.defaultHeader,
      );

      print("${respons.body}");

      final data = jsonDecode(respons.body);
      if (respons.statusCode == 201) {
        showInToast("Registation Successful");
      } else {
        showInToast("registaion Faield");
      }
    } else {
      showInToast("No Internet");
    }
  });
}

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confromPassword = TextEditingController();

class _RegisterState extends State<Register> {
  final formkey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(right: 20, left: 20),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 40, color: Color(0xff0d964c)),
                  ),
                ),
              ),
              Image.asset(
                "assets/registar.gif",
                height: 250,
                width: 250,
              ),

              //Text Form Field *********************
              Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  color: Color(0xff0d964c), width: 1.7)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  color: Color(0xff0d964c), width: 1.7)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  color: Color(0xff0d964c), width: 1.7)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(
                                  color: Color(0xff0d964c), width: 1.7)),
                          contentPadding: EdgeInsets.zero,
                          prefixIcon:
                              Icon(Icons.person, color: Color(0xff0d964c)),
                          hintText: 'Enter your full name',
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Color(0xff0d964c)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Name';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 15),

                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide(
                                    color: Color(0xff0d964c), width: 1.7)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide(
                                    color: Color(0xff0d964c), width: 1.7)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide(
                                    color: Color(0xff0d964c), width: 1.7)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide(
                                    color: Color(0xff0d964c), width: 1.7)),
                            contentPadding: EdgeInsets.zero,
                            prefixIcon:
                                Icon(Icons.call, color: Color(0xff0d964c)),
                            hintText: 'Enter your Email',
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Color(0xff0d964c)),
                            fillColor: Colors.grey,
                            focusColor: Colors.grey),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your phone number';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 15),

                      TextFormField(
                        controller: passwordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide(
                                    color: Color(0xff0d964c), width: 1.7)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide(
                                    color: Color(0xff0d964c), width: 1.7)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide(
                                    color: Color(0xff0d964c), width: 1.7)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide(
                                    color: Color(0xff0d964c), width: 1.7)),
                            contentPadding: EdgeInsets.zero,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            prefixIcon:
                                Icon(Icons.lock, color: Color(0xff0d964c)),
                            hintText: 'Enter your password',
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Color(0xff0d964c)),
                            fillColor: Colors.grey,
                            focusColor: Colors.grey),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Password';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 15),

                      TextFormField(
                        controller: confromPassword,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide(
                                    color: Color(0xff0d964c), width: 1.7)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide(
                                    color: Color(0xff0d964c), width: 1.7)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide(
                                    color: Color(0xff0d964c), width: 1.7)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide(
                                    color: Color(0xff0d964c), width: 1.7)),
                            contentPadding: EdgeInsets.zero,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            prefixIcon:
                                Icon(Icons.lock, color: Color(0xff0d964c)),
                            hintText: 'Enter your Confraom',
                            labelText: 'Confrom pass',
                            labelStyle: TextStyle(color: Color(0xff0d964c)),
                            fillColor: Colors.grey,
                            focusColor: Colors.grey),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Password';
                          }
                          return null;
                        },
                      ),

                      //Sign Up **********  Button  *********
                      SizedBox(height: 45),
                      SizedBox(
                          width: (MediaQuery.of(context).size.width) - 50,
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff0d964c),
                                  onPrimary: Colors.white,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32))),
                              onPressed: () {
                                if (formkey.currentState!.validate() &&
                                    getRegester()) {}
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ))),
                    ],
                  )),

              SizedBox(
                height: 10,
              ),

              //**************   RichText ************
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account ? ",
                    style: TextStyle(fontSize: 15, color: Color(0xff0d964c)),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SingInPage()));
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(fontSize: 15, color: Colors.red),
                      )),
                ],
              ),

              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
