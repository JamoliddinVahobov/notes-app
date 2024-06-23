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
    apiKey: 'AIzaSyCn0huKug-e6lF7csa4xsuER9_VrSVmfCQ',
    appId: '1:533341657086:web:cb0c257e0cdc834899d2af',
    messagingSenderId: '533341657086',
    projectId: 'mynotes-2bd91',
    authDomain: 'mynotes-2bd91.firebaseapp.com',
    storageBucket: 'mynotes-2bd91.appspot.com',
    measurementId: 'G-B49TYHZERX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8ifMhauSKI1VKWno97cgHBDLDztXROwQ',
    appId: '1:533341657086:android:72a2abbdb5fbcea499d2af',
    messagingSenderId: '533341657086',
    projectId: 'mynotes-2bd91',
    storageBucket: 'mynotes-2bd91.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnatns005AQNvLeV89GKP0LsszM_6XcIo',
    appId: '1:533341657086:ios:d71f069ccb5d8d2199d2af',
    messagingSenderId: '533341657086',
    projectId: 'mynotes-2bd91',
    storageBucket: 'mynotes-2bd91.appspot.com',
    iosBundleId: 'com.example.myNotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCnatns005AQNvLeV89GKP0LsszM_6XcIo',
    appId: '1:533341657086:ios:d71f069ccb5d8d2199d2af',
    messagingSenderId: '533341657086',
    projectId: 'mynotes-2bd91',
    storageBucket: 'mynotes-2bd91.appspot.com',
    iosBundleId: 'com.example.myNotes',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCn0huKug-e6lF7csa4xsuER9_VrSVmfCQ',
    appId: '1:533341657086:web:dc816c769073eda099d2af',
    messagingSenderId: '533341657086',
    projectId: 'mynotes-2bd91',
    authDomain: 'mynotes-2bd91.firebaseapp.com',
    storageBucket: 'mynotes-2bd91.appspot.com',
    measurementId: 'G-KVZFYHY0M9',
  );
}
