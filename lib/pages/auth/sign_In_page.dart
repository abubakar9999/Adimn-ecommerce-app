import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/tost_message.dart';
import '../bottomNavigation.dart';

class SingInPage extends StatefulWidget {
  SingInPage({Key? key}) : super(key: key);

  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  final formkey = GlobalKey<FormState>();
  bool _isObscure = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  SharedPreferences? sharedPreferences;
  String? token;
  String loginLlink = "https://apihomechef.antopolis.xyz/api/admin/sign-in";

  isLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences!.getString("token");
    if (token!.isNotEmpty) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => TabMenu()));
    } else {
      print("token is null");
    }
  }

  getLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var map = Map<String, dynamic>();
    map["email"] = emailController.text.toString();
    map["password"] = passwordController.text.toString();
    var responce = await http.post(
      Uri.parse(loginLlink),
      body: map,
    );
    final data = jsonDecode(responce.body);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh$data");
    if (responce.statusCode == 200) {
      setState(() {
        sharedPreferences!.setString("token", data["access_token"]);
      });
      token = sharedPreferences!.getString("token");
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => TabMenu()));
      print("Token Saved $token");

      showInToast("Login Succesfull");
    } else {
      showInToast("Login Failed");
    }
  }

  void initState() {
    // TODO: implement initState
    isLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: const Center(
                  child: Text(
                "Sign In",
                style: TextStyle(fontSize: 40, color: Color(0xff0d964c)),
              )),
            ),
            Image.asset(
              "assets/singin.gif",
              height: 250,
              width: 250,
            ),
            Text(
              "Enter your phone number and password to access your account",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 15,
            ),
            Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
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
                              Icon(Icons.person, color: Color(0xff0d964c)),
                          hintText: 'Enter your Email',
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Color(0xff0d964c)),
                          fillColor: Colors.grey,
                          focusColor: Colors.grey),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Email';
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
                  ],
                )),
            InkWell(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
              },
              child: Text(
                "Forget password ?",
                style: TextStyle(fontSize: 16, color: Colors.red.shade500),
                textAlign: TextAlign.right,
              ),
            ),
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
                      if (formkey.currentState!.validate()) {
                        getLogin();
                      }
                    },
                    child: Text(
                      "Sign In",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ))),
          ],
        ),
      ),
    );
  }
}
