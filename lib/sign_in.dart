import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import 'package:vscan1/firestore_services.dart';
import 'package:vscan1/scan.dart';

import 'log_in.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _secondPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _secondPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 350,
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
                controller: _emailController,
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
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _passwordController,
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 40),
              child: TextField(
                controller: _secondPasswordController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
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
                child: const Text(
                  'Înregistrare',
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

  void showLogInErrorToastAndClearFields(
      BuildContext context, String errorMessage) {
    ToastContext().init(context);
    Toast.show(errorMessage, duration: Toast.lengthLong, gravity: Toast.bottom);
    _emailController.clear();
    _passwordController.clear();
    _secondPasswordController.clear();
  }

  Future signUp() async {
    if (_passwordController.text == _secondPasswordController.text) {
    } else {
      showLogInErrorToastAndClearFields(
          context, "Parola introdusă nu este aceeași in ambele câmpuri");
    }

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    )
        .then((value) {
      addUser();
      return Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => ScanPage()));
    }).catchError((error) {
      showLogInErrorToastAndClearFields(
          context, "Adresa de e-mail/ parola e invalidă");
    });
  }
}
