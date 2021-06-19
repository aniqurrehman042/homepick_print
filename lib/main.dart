import 'package:flutter/material.dart';
import 'package:homepick_print/providers/home_page_provider.dart';
import 'package:homepick_print/views/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomePageProvider(),
      child: MaterialApp(
        title: 'Home Pick Print',
        home: MyHomePage(),
      ),
    );
  }
}
