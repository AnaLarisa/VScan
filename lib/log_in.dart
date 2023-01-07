import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import 'package:vscan1/main.dart';

import 'scan.dart';
import 'sign_in.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 400,
                    child: const Center(
                      child: Text(
                        'VScan',
                        style: TextStyle(
                          color: Color.fromRGBO(13, 31, 45, 1),
                          fontStyle: FontStyle.italic,
                          fontSize: 50,
                        ),
                      ),
                    )),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _emailController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    labelText: 'Email',
                    hintText: 'Introdu o adresa vaida de e-mail'),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 40),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _passwordController,
                textInputAction: TextInputAction.next,
                obscureText: true,
                decoration: const InputDecoration(
                    fillColor: Color.fromRGBO(13, 31, 45, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    labelText: 'Parolă',
                    hintText: 'Introdu o parolă puternică'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(13, 31, 45, 1),
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: signIn,
                child: const Text(
                  'Autentificare',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SignInPage()));
              },
              child: const Text(
                'Crează-ți un cont nou',
                style: TextStyle(
                    color: Color.fromRGBO(13, 31, 45, 1),
                    decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showLogInErrorToast(BuildContext context) {
    ToastContext().init(context);
    Toast.show("E-mail/parolă incorectă",
        duration: Toast.lengthShort, gravity: Toast.bottom);
  }

  Future signIn() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    )
        .then((value) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => ScanPage()));
    }).catchError((error) {
      showLogInErrorToast(context);
      _emailController.clear();
      _passwordController.clear();
    });
  }
}
