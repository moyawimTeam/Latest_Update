import 'package:flutter/material.dart';
import 'package:two/Search_Page/Search_Page.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      height: 50,
      child: Builder(
        builder: (context) => FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            showSearch(
              context: context,
              delegate: Data(),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Text(
                  'ابحث عن خدمات',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              Expanded(
                child: IconButton(
                    iconSize: 30,
                    color: Colors.white,
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(context: context, delegate: Data());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
