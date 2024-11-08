import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDxvz19yXryoSrtdN7c_UAH6SI2HG_eUE8",
            authDomain: "teste-b6c59.firebaseapp.com",
            projectId: "teste-b6c59",
            storageBucket: "teste-b6c59.appspot.com",
            messagingSenderId: "575597174889",
            appId: "1:575597174889:web:1e6c7710c86a5915ec82f8"));
  } else {
    await Firebase.initializeApp();
  }
}
