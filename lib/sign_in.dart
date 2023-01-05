import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth_email/main.dart';
//import 'package:firebase_auth_email/utils/utils.dart';

import 'scan.dart';
import 'log_in.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 400,
                    child: Center(
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    labelText: 'E-mail',
                    hintText: 'Introdu o adresă validă de e-mail'),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    fillColor: Color.fromRGBO(13, 31, 45, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    labelText: 'Parolă',
                    hintText: 'Introdu o parolă puternică'),
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 40),
              child: TextField(
                obscureText: true,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    fillColor: Color.fromRGBO(13, 31, 45, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    labelText: 'Parolă',
                    hintText: 'Re-introdu parola aleasă'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(13, 31, 45, 1),
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: signUp,
                // () {
                //   Navigator.push(
                //       context, MaterialPageRoute(builder: (_) => ScanPage()));
                // },
                child: const Text(
                  'Înregistrează-te',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 75,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LogInPage()));
              },
              child: const Text(
                'Ai deja un cont? Autentifică-te',
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

  Future signUp() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }
}
