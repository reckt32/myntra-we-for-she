// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAHSKIpRPYfu7t8XduimhVc4_E1TYXGt2k',
    appId: '1:919679697867:web:e3b7f9689e6962e178ac4e',
    messagingSenderId: '919679697867',
    projectId: 'myntra-24875',
    authDomain: 'myntra-24875.firebaseapp.com',
    storageBucket: 'myntra-24875.appspot.com',
    measurementId: 'G-W9W5KXQ8B5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAsrce0BzczL5t-zoQSNM3kvSdv8wAyT6E',
    appId: '1:919679697867:android:578009ab1217564778ac4e',
    messagingSenderId: '919679697867',
    projectId: 'myntra-24875',
    storageBucket: 'myntra-24875.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBji9CVGUlY3We74iA6n8ob6yBZoTIci9o',
    appId: '1:919679697867:ios:c4e015899b7ae0cd78ac4e',
    messagingSenderId: '919679697867',
    projectId: 'myntra-24875',
    storageBucket: 'myntra-24875.appspot.com',
    iosBundleId: 'com.example.myntra',
  );
}