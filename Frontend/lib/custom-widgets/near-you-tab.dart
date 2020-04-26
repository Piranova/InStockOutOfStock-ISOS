import 'package:flutter/material.dart';
import 'package:letsfightcovid19/custom-widgets/tab-list-view.dart';

class NearYouTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: TabListView()
    );
  }

}