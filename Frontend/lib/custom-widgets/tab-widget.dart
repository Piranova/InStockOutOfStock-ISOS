import 'package:flutter/material.dart';
import 'package:letsfightcovid19/custom-widgets/near-you-tab.dart';
import 'package:letsfightcovid19/custom-widgets/popular-tab.dart';
import 'package:underline_indicator/underline_indicator.dart';


List<String> tabTitles = ['Near You', 'Popular'];

class TabWidget extends StatefulWidget{
  @override
  TabWidgetState createState() => TabWidgetState();
}

class TabWidgetState extends State<TabWidget> with SingleTickerProviderStateMixin{
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TabBar _getTabBar() {
    return TabBar(
      tabs: tabTitles.map((String title){
        return Container(
          height: 20.0,
          child: Text(title),
          alignment: Alignment.center,
          margin: EdgeInsets.all(9.0),
        );
      }).toList(),
      controller: _controller,
      indicator:  UnderlineIndicator(
          strokeCap: StrokeCap.round,// Set your line endings.
          borderSide: BorderSide(
            color: Color(0xFF232C4D),
            width: 3.2,
          ),
          insets: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 5.0)),
    );
  }

  Widget _getTabBarView(tabs) {
    return
      Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 5.0),

                decoration: new BoxDecoration(
                  color: const Color(0xFFF5FBFF),
                  borderRadius: new BorderRadius.only(
                      topLeft:  const  Radius.circular(10.0),
                      topRight: const  Radius.circular(10.0)
                  )
                ),
                child: TabBarView(
                children: tabs,
                controller: _controller,
                )
              ),
            );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Container(
            height: 276
          ),
          _getTabBar(),
          _getTabBarView(
          [
            NearYouTab(),
            PopularTab()
          ]
          )
        ]
    );
  }
}