import 'dart:ffi';
import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart' as native_wrappers;
import 'dart:typed_data';

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