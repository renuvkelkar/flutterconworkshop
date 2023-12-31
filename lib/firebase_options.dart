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
        return macos;
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
    apiKey: 'AIzaSyCeuVBob0_S34UYuCpyWWCXE7RiIrSmuLQ',
    appId: '1:626275468590:web:510e7c31f4855cf3d2a6bf',
    messagingSenderId: '626275468590',
    projectId: 'fluttercon-workshop',
    authDomain: 'fluttercon-workshop.firebaseapp.com',
    storageBucket: 'fluttercon-workshop.appspot.com',
    measurementId: 'G-P0T9E1HXGN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBks6ZbZoDWhzNhvw6lWX4CbStyT97nBBA',
    appId: '1:626275468590:android:ffc2ef705ac19b46d2a6bf',
    messagingSenderId: '626275468590',
    projectId: 'fluttercon-workshop',
    storageBucket: 'fluttercon-workshop.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSFP7BhUqNGO9oXQTXRF361OIIoQmiQZg',
    appId: '1:626275468590:ios:38e7af5161017e06d2a6bf',
    messagingSenderId: '626275468590',
    projectId: 'fluttercon-workshop',
    storageBucket: 'fluttercon-workshop.appspot.com',
    iosClientId: '626275468590-t7ct8bl5dbbghv6525t8kvjjjrlvsicf.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterconworkshop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDSFP7BhUqNGO9oXQTXRF361OIIoQmiQZg',
    appId: '1:626275468590:ios:38e7af5161017e06d2a6bf',
    messagingSenderId: '626275468590',
    projectId: 'fluttercon-workshop',
    storageBucket: 'fluttercon-workshop.appspot.com',
    iosClientId: '626275468590-t7ct8bl5dbbghv6525t8kvjjjrlvsicf.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterconworkshop',
  );
}
