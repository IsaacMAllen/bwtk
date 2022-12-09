import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3C3F42),
        body: Row(
          children: [
            Expanded(child: Container(), flex: 1,),
                Card(
                elevation: 15,
                margin: EdgeInsets.all(50),
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                          Container(height: 15),
                          const Text('Login', style: TextStyle(fontSize: 20.0)),
                          Container(height: 15),
                          Container(
                            width: 250,
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                hintText: 'Enter Email Address',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(color: Color(0xff3C3F42), width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(color: Colors.green, width: 2.0),
                                ),
                              ),
                              onFieldSubmitted: (value) {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  logInToFb();
                                }
                              },
                              validator: (value) {
                                const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                final regExp = RegExp(pattern);
                                if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
                                  return 'Please enter a valid Email Address';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            width: 250,
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: const InputDecoration(
                                hintText: 'Enter Password',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(color: Color(0xff3C3F42), width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(color: Colors.green, width: 2.0),
                                ),
                              ),
                              onFieldSubmitted: (value) {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  logInToFb();
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Password';
                                } else if (value.length < 6) {
                                  return 'Password must be atleast 6 characters!';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  logInToFb();
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          )
                        ]))),
              ),
            Expanded(child: Container(), flex: 1),
          ],
        ));
  }

  void logInToFb() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text)
        .then((result) {
      isLoading = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }).catchError((err) {
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(err.message),
              actions: [
                ElevatedButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => EmailLogin()));
                  },
                )
              ],
            );
          });
    });
  }
}