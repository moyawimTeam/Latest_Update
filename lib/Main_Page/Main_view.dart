import 'package:flutter/material.dart';
import 'package:two/Categories/Categories.dart';

import 'Bottom_Bar.dart';
import 'Search_Bar.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'مياوم',
      home: Scaffold(
        appBar: AppBar(
          title: SearchBar(),
        ),
        body: Categories(),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
