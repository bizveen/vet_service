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
    apiKey: 'AIzaSyDMaLcWYz4hJ6OMd5m5eL0MbDXNi8jRxZg',
    appId: '1:702504483082:web:6c84ee6669414b80c162f3',
    messagingSenderId: '702504483082',
    projectId: 'client-care-105c5',
    authDomain: 'client-care-105c5.firebaseapp.com',
    databaseURL: 'https://client-care-105c5-default-rtdb.firebaseio.com',
    storageBucket: 'client-care-105c5.appspot.com',
    measurementId: 'G-E989DGJ69K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyALNX90f34gj1XTkWYuJtZIR2-_o8R_jhE',
    appId: '1:702504483082:android:4bf33006232dc8b6c162f3',
    messagingSenderId: '702504483082',
    projectId: 'client-care-105c5',
    databaseURL: 'https://client-care-105c5-default-rtdb.firebaseio.com',
    storageBucket: 'client-care-105c5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAkEbpHh9OCb-Ygu2782R1e6UbUOFsXByA',
    appId: '1:702504483082:ios:775c6d615b16cf36c162f3',
    messagingSenderId: '702504483082',
    projectId: 'client-care-105c5',
    databaseURL: 'https://client-care-105c5-default-rtdb.firebaseio.com',
    storageBucket: 'client-care-105c5.appspot.com',
    iosClientId: '702504483082-vof4c0da1b30lkqmc4l7mn41sl61thv7.apps.googleusercontent.com',
    iosBundleId: 'com.vetpower.vetService',
  );
}
