
import 'package:flutter/material.dart';

class UnderDevelopmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlankPageWithName(title: "Under Development");
  }
}

class BlankPageWithName extends StatelessWidget {
  final String title;

  BlankPageWithName({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}
