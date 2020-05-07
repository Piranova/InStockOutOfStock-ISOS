import 'package:flutter/material.dart';
import 'package:InStockOrOutOfStock/custom-widgets/tab-list-view.dart';

class NearYouTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(margin: EdgeInsets.only(top: 10.0), child: TabListView())
    );
  }

}