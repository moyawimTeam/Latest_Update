import 'package:flutter/material.dart';
import 'package:two/Categories/Category_widget.dart';
import 'package:two/Data.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.count(
      crossAxisCount: 2,
      children: List.generate(jobsList.length, (index) {
        // I used Row() because Expanded() widget should be inside Row, Column, or Flex only
        return Row(
          children: <Widget>[
            Category(
              jobName: jobsList[index],
            ),
          ],
        );
      }),
    ));
  }
}
