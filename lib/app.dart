import 'package:flutter/material.dart';

import 'features/scanner/presentation/scanner_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pehchaan',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ScannerPage(),
    );
  }
}
