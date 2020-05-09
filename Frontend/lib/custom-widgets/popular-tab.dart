import 'package:flutter/material.dart';
import 'tab-list-view.dart';

class PopularTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(margin: EdgeInsets.only(top: 10.0), child: TabListView())
    );
  }

}