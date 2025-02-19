// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAXUVRYoqfQxQ9kQVdcNOTxTq047YNaK3M',
    appId: '1:702583657846:web:3b268304b9d7849b06d657',
    messagingSenderId: '702583657846',
    projectId: 'webqr-f48b3',
    authDomain: 'webqr-f48b3.firebaseapp.com',
    storageBucket: 'webqr-f48b3.firebasestorage.app',
    measurementId: 'G-7SBLV47Q51',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0NrSLwCJa23QnkKiN-Bn9YM1X850ps1o',
    appId: '1:702583657846:android:284136f857f36f3006d657',
    messagingSenderId: '702583657846',
    projectId: 'webqr-f48b3',
    storageBucket: 'webqr-f48b3.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnJ9FmcPA_oyyYxr6A1grzP8KuDtrCYew',
    appId: '1:702583657846:ios:a1a429be8b3cd52706d657',
    messagingSenderId: '702583657846',
    projectId: 'webqr-f48b3',
    storageBucket: 'webqr-f48b3.firebasestorage.app',
    iosBundleId: 'com.example.webqr',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAnJ9FmcPA_oyyYxr6A1grzP8KuDtrCYew',
    appId: '1:702583657846:ios:a1a429be8b3cd52706d657',
    messagingSenderId: '702583657846',
    projectId: 'webqr-f48b3',
    storageBucket: 'webqr-f48b3.firebasestorage.app',
    iosBundleId: 'com.example.webqr',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAXUVRYoqfQxQ9kQVdcNOTxTq047YNaK3M',
    appId: '1:702583657846:web:72084db21f5867bf06d657',
    messagingSenderId: '702583657846',
    projectId: 'webqr-f48b3',
    authDomain: 'webqr-f48b3.firebaseapp.com',
    storageBucket: 'webqr-f48b3.firebasestorage.app',
    measurementId: 'G-4RKEWVW0VM',
  );
}
