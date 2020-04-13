import 'package:flutter/material.dart';
import 'package:two/Data.dart';
import 'package:two/Results_Page/Results_Page.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "My app",
    home: new SearchPage(),
  ));
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class Data extends SearchDelegate<String> {
  final jobList = jobsList;
  var searchHistory = recentSearchHistory;
  String city;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () {
//            final city = await Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => popUP(),
//              ),
//            );
//            print(city);
            popUpDialog1(context, 'المدينة').then((value) => city = value);
          }),
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return ResultsPage(
      job: query,
      city: city,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = query.isEmpty
        ? searchHistory
        : jobList.where((s) => s.startsWith(query)).toList();
    return ListView.builder(
      addAutomaticKeepAlives: false,
      itemBuilder: (context, index) => ListTile(
          onTap: () {
            showResults(context);
            query = suggestion[index];
          },
          leading: Icon(Icons.verified_user),
          title: RichText(
            text: TextSpan(
                text: suggestion[index].substring(0, query.length),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                      text: suggestion[index].substring(query.length),
                      style: TextStyle(color: Colors.grey, fontSize: 18))
                ]),
          )),
      itemCount: suggestion.length,
    );
  }

  Future<String> popUpDialog1(BuildContext context, String post) {
    TextEditingController _controller = TextEditingController();
    return showDialog(
        context: context,
        // ignore: missing_return
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: Colors.grey.shade100,
            title: Text(
              post,
              textAlign: TextAlign.center,
            ),
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _controller,
                autofocus: true,
                style: TextStyle(fontSize: 19.0),
                keyboardType: (post == "الخبرة")
                    ? TextInputType.number
                    : TextInputType.text,
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red.shade500),
                    hintText: " ادخل $post",
                    labelText: " فلتر حسب $post"),
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                textColor: Colors.white,
                child: Text("إلغاء"),
                onPressed: () => Navigator.of(context).pop(),
                elevation: 5.0,
                color: Colors.blue.shade400,
              ),
              MaterialButton(
                textColor: Colors.white,
                child: Text("فلتر"),
                onPressed: () =>
                    Navigator.of(context).pop(_controller.text.toString()),
                elevation: 5.0,
                color: Colors.blue.shade400,
              ),
            ],
          );
        });
  }
}
