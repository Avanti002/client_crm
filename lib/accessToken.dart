// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:quantbit_crm/login.dart';

String tokenAccess = "token ";

class AccessToken extends StatefulWidget {
  const AccessToken({Key? key}) : super(key: key);
  @override
  _AccessTokenState createState() => _AccessTokenState();
}

class _AccessTokenState extends State<AccessToken> {
  bool _passwordVisible = false;
  @override
  void initState() {
    setState(() {
      tokenAccess = tokenAccess + passwordController.text;
      tokenAccess = "token 94133f5eab07810:15bfb8b48ed4b73";
    });
    _passwordVisible = false;
    super.initState();
  }

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 35, right: 35),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        style: const TextStyle(),
                        obscureText: !_passwordVisible,
                        controller: passwordController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                }),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "api_key:api_secret",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: 200, // <-- Your width
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              tokenAccess =
                                  tokenAccess + passwordController.text;
                              tokenAccess =
                                  "token 94133f5eab07810:15bfb8b48ed4b73";
                            });

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyLogin(),
                                ));
                          },
                          label: const Text('Validate',
                              style: TextStyle(fontSize: 20)),
                          icon: const Icon(
                            // <-- Icon
                            Icons.check_circle_outline,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
