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
    apiKey: 'AIzaSyBIKaWikYrfzpP3ShbluOW1fACaOqA3bmQ',
    appId: '1:402589289662:web:93e9440041b28fad67a2ef',
    messagingSenderId: '402589289662',
    projectId: 'python-216da',
    authDomain: 'python-216da.firebaseapp.com',
    storageBucket: 'python-216da.firebasestorage.app',
    measurementId: 'G-QRKBHZ7Q3P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRQ7Oiv6PWRfWiFu-s45qpYuSY6GXcOcU',
    appId: '1:402589289662:android:441bcf343b63faa167a2ef',
    messagingSenderId: '402589289662',
    projectId: 'python-216da',
    storageBucket: 'python-216da.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDG2A4R-FEejcCeaIi6WX4_ZG7Tsoq6VMU',
    appId: '1:402589289662:ios:409b9a913c58116267a2ef',
    messagingSenderId: '402589289662',
    projectId: 'python-216da',
    storageBucket: 'python-216da.firebasestorage.app',
    iosBundleId: 'com.example.pythonCompiler',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDG2A4R-FEejcCeaIi6WX4_ZG7Tsoq6VMU',
    appId: '1:402589289662:ios:409b9a913c58116267a2ef',
    messagingSenderId: '402589289662',
    projectId: 'python-216da',
    storageBucket: 'python-216da.firebasestorage.app',
    iosBundleId: 'com.example.pythonCompiler',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBIKaWikYrfzpP3ShbluOW1fACaOqA3bmQ',
    appId: '1:402589289662:web:94978cf015d32d3867a2ef',
    messagingSenderId: '402589289662',
    projectId: 'python-216da',
    authDomain: 'python-216da.firebaseapp.com',
    storageBucket: 'python-216da.firebasestorage.app',
    measurementId: 'G-LT5DM82D48',
  );
}