import 'package:flutter/material.dart';

TextEditingController controller = new TextEditingController();

Future<String> createAlertDialog(BuildContext context, String title) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          content: TextFormField(
            validator: (String val) =>
                val.isEmpty ? 'لا يمكن أن تكون فارغة' : null,
            controller: controller,
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text(
                'حفظ',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop(controller.text.toString());
                controller.clear();
              },
            )
          ],
        );
      });
}
