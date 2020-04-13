import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:two/Results_Page/Results_Profile_widget.dart';

class ResultsPage extends StatelessWidget {
  final String city;
  final String job;
  const ResultsPage({
    this.city,
    this.job,
  });

  Widget _buildProfileWidgets(BuildContext context, DocumentSnapshot document) {
    return MyProfileWidget(
      name: document['name'],
      lastName: document['lastname'],
      phoneNumber: document['phone number'],
      job: document['job'],
      desc: document['description'],
      city: document['city'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: city == 'All'
            ? Firestore.instance
                .collection('Employees')
                .where('job', isEqualTo: job)
                .snapshots()
            : Firestore.instance
                .collection('Employees')
                .where('city', isEqualTo: city)
                .where('job', isEqualTo: job)
                .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: const Text(
              "لا مياومون حاليا",
              style: TextStyle(fontSize: 50),
            ));
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildProfileWidgets(context, snapshot.data.documents[index]),
            );
          }
        },
      ),
    );
  }
}
