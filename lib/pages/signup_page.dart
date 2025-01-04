import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  String? errorMessage = '';
  final formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var pass = TextEditingController();
  
  bool obscureText = true;
  Future<void> createUserWithEmailAndPassword() async {
    try { UserCredential userCredential=
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: pass.text);
        String userId = userCredential.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': name.text,
        'email': email.text,
        
      },SetOptions(merge: true)
      );
      
      
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.brown
            ),

            // filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                height: 540,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.brown.shade800),
                    color: Colors.black38.withOpacity(0.6)),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'SignUp',
                        style: GoogleFonts.baskervville(
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            fontSize: 50),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                          controller: name,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.man, color: Colors.white70),
                              hintText: 'enter username',
                              labelText: 'username',
                              hintStyle: TextStyle(color: Colors.white38),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.blueAccent,
                                  ))),
                          validator: (name) {
                            if (name!.isEmpty) {
                              return 'enter valid username';
                            } else
                              return null;
                          }),
                      SizedBox(
                        height: 10 + 10,
                      ),
                      TextFormField(
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                          controller: email,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Colors.white70,
                              ),
                              hintText: 'enter email',
                              labelText: 'Email',
                              hintStyle: TextStyle(color: Colors.white38),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.blueAccent,
                                  ))),
                          validator: (email) {
                            if (email!.isEmpty ||
                                !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                    .hasMatch(email)) {
                              return 'enter valid email';
                            } else
                              return null;
                          }),
                           SizedBox(height: 10),
                      
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 16,
                        ),
                        controller: pass,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white70,
                          ),
                          hintText: 'enter password',
                          labelText: 'password',
                          hintStyle: TextStyle(color: Colors.white38),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.blueAccent,
                              )),
                        ),
                        validator: (pass) {
                          if (pass!.isEmpty) {
                            return "password cannot be empty ";
                          } else if (pass.length < 6) {
                            return "password length should be atleast 6";
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Account already exist ?,",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/main');
                            },
                            child: Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      FilledButton(
                        onPressed: () async {
                          String email_ = email.text;
                          String pass_ = pass.text;
                          print('name $email_ - password $pass_');
                          if (formKey.currentState!.validate()) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.transparent,
                              content: Text(
                                'Sign-up Successful!',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white70),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            await createUserWithEmailAndPassword();
                          }
                        },
                        child: Text(
                          'Sign-up',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.brown[900]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}