import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fotogram/layouts/responsive_layout.dart';
import 'package:fotogram/layouts/web_layout.dart';
import 'package:fotogram/screens/login_screen.dart';
import 'layouts/mobile_layout.dart';
import 'pods/user_pod.dart';

void main() async {
  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDsy8hdkwQ1zgwlkQGqN_gzLwZNJfvz_QU",
          appId: "1:147057812381:android:287f2ccccdc64eae2a8574",
          messagingSenderId: "147057812381",
          projectId: "fotogram-backend",
          storageBucket: 'fotogram-backend.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fotogram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data != null) {
              return const ResponsiveLayout(
                webLayout: WebLayout(),
                mobileLayout: MobileLayout(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
