import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fotogram/layouts/responsive_layout.dart';
import 'package:fotogram/layouts/web_layout.dart';
import 'layouts/mobile_layout.dart';
import 'pods/user_pod.dart';

void main() {
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
      home: const ResponsiveLayout(
        webLayout: WebLayout(),
        mobileLayout: MobileLayout(),
      ),
    );
  }
}
