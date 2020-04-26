import 'package:flutter/material.dart';
import 'tab-list-view.dart';

class PopularTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: TabListView()
    );
  }

}