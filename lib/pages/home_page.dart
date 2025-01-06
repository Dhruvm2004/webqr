
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR code'),
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates
      
        ),
        onDetect:(capture){
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
          for (Barcode barcode in barcodes){
            print('Barcode: ${barcode.rawValue}');
          }
          if (image != null){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Text(barcodes.first.rawValue ?? ""),
                content: Image(image: MemoryImage(image)),);
            });
          }
        },
      ),
    );
  }
}
Future<void> _authenticateSession(String sessionId) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('web_sessions')
          .doc(sessionId)
          .update({
        'isAuthenticated': true,
        'userId': user.uid,
        'email': user.email,
        'displayName': user.displayName,
        'photoURL': user.photoURL,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Session authenticated for user: ${user.uid}");
    } else {
      print("User not logged in.");
    }
  }


