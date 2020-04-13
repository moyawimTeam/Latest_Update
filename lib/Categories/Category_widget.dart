import 'package:flutter/material.dart';
import 'package:two/Results_Page/Results_Page.dart';

class Category extends StatelessWidget {
  const Category({this.jobName});
  final String jobName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ResultsPage(
                job: jobName,
                city: 'All',
              );
            }));
          },
          child: Container(
              padding: EdgeInsets.all(9),
              child: Container(
                child: Center(
                  child: Text(
                    jobName,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(20)),
              )),
        ));
  }
}
