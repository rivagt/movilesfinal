import 'dart:convert';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:movilesfinal/pages/aparments_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  static String id = 'login_page';
  static const routeName = '/login_page';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff7289EA),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                './img/logo.png',
                width: 100.0,
                height: 100.0,
              ),
              const SizedBox(
                height: 50.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: 'Email',
                    hintText: 'ejemplo@tupuedes.com',
                  ),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    labelText: 'Password',
                  ),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              RawMaterialButton(
                fillColor: const Color(0xff1A4B89),
                padding: const EdgeInsets.symmetric(
                  horizontal: 110.0,
                  vertical: 18.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
                onPressed: () async {
                  var url = Uri.parse('http://34.135.64.65:3003/api/signin');
                  var res = await http.post(url, body: {
                    'email': _emailController.text,
                    'password': _passwordController.text
                  });
                  if (res.statusCode == 404 || res.statusCode == 500) {
                    print('Error');
                  } else {
                    Map<String, dynamic> user = jsonDecode(res.body);
                    // var user = userMap['token'];
                    print('Hello with token: ${user['token']}');
                    print('Response status: ${res.statusCode}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AparmentPage()),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
