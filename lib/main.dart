import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webqr/firebase_options.dart';
import 'package:webqr/pages/auth.dart';
import 'package:webqr/pages/home_page.dart';
import 'package:webqr/pages/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
      routes:{
        '/home':(context)=>HomePage(),
        '/signup':(context)=>SignupPage(),
        '/main':(context)=>LoginPage()
      
      }, 
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // String name = "";
  // bool changeButton = false;
  String? errorMessage = '';
  final formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var pass = TextEditingController();
  bool obscureText = true;
  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth()
          .signInWithEmailAndPassword(email: email.text, pass: pass.text);
      Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  HomePage(),
                  ),
                );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.brown
          ),

          // filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(10),
              height: 400,
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
                      'Login',
                      style: GoogleFonts.baskervville(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          fontSize: 50),
                    ),
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
                    SizedBox(
                      height: 10,
                    ),
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
                          "Don't have an account?,",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            "SignUp",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     TextButton(onPressed: () {
                    //       Naviga
                    //     })
                    //   ],

                    // )
                    SizedBox(
                      height: 10,
                    ),

                    FilledButton(onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await signInWithEmailAndPassword();
                      }
                    },
                    child: Text("Login",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                    ),),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.brown[900])
                    ),),
                      // Text(
                      //   errorMessage == '' ? '' : ' $errorMessage',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     color: Colors.white70
                      //   ),),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}