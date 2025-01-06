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
  // Function to authenticate a session in Firestore
Future<void> _authenticateSession(String sessionId) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null && user.uid != null) {
    // User is already logged in, directly update Firestore
    await FirebaseFirestore.instance
        .collection('web_sessions')
        .doc(sessionId)
        .update({
      'isAuthenticated': true,
      'userId': user.uid,
      'email': user.email,
      'displayName': user.displayName ?? 'No Name',
      'photoURL': user.photoURL ?? '',
      'timestamp': FieldValue.serverTimestamp(),
    });
    print("Session authenticated for user: ${user.uid}");
    _showSuccessDialog("Session authenticated successfully!");
    return;
  }

  // If user is not logged in, proceed with previous logic...
}

  // Function to show success dialog
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
        ),
        onDetect: (capture) async {
          final List<Barcode> barcodes = capture.barcodes;

          for (Barcode barcode in barcodes) {
            final String? rawValue = barcode.rawValue;

            if (rawValue != null) {
              print('Scanned QR Code: $rawValue');

              // Authenticate the session using the scanned QR code
              await _authenticateSession(rawValue);
            }
          }
        },
      ),
    );
  }
}
