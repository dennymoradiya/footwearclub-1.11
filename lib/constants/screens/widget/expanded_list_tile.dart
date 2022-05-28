import 'package:flutter/material.dart';

class ExpandedListTile extends StatelessWidget {
  final String? titles;
  final String? text;
  const ExpandedListTile({Key? key, this.titles, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          childrenPadding: EdgeInsets.all(15),
          title: Text(
            titles!,
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
          collapsedTextColor: Colors.black,
          collapsedIconColor: Colors.black,
          children: [Text(text!)],
          trailing: Icon(
            Icons.add,
            size: 30,
            color: Colors.black,
          ),
        ),
        Divider(
          height: 2,
          color: Colors.black,
        )
      ],
    );
  }
}
