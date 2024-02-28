import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(const MapGoogle());
}
class MapGoogle extends StatelessWidget {
  const MapGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

