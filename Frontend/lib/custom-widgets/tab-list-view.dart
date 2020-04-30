import 'package:flutter/material.dart';
import '../models/item-model.dart';

class TabListView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => TabListViewState();

}

class TabListViewState extends State<TabListView>{
  @override
  Widget build(BuildContext context) {
    return buildList();
  }

  ListView buildList(){


    return ListView.builder(
      shrinkWrap: true,
        itemCount: prepareData.length,
        itemBuilder: (BuildContext context, int index) {
          final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent,  dividerTheme: DividerThemeData(thickness: 4.0, ), unselectedWidgetColor:  Color.fromRGBO(35, 44, 77, 1) );
          if (index.isOdd) return new Divider(color: Color.fromRGBO(133, 201, 255, 1), indent: 48.5,thickness: 4.0, endIndent: 223.5,);
          return

//            Container(
//                decoration: BoxDecoration(border: new Border(bottom: BorderSide(color: Color.fromRGBO(133, 201, 255, 1), width: 4.0 ), top: BorderSide.none)),

//                child:
                  Theme(data: theme, child: ExpansionTile(
                    title: Container(
                      padding: EdgeInsets.only(left: 38, top:10,),
                      child: Text(prepareData[index].header,
                          style:
                          TextStyle(color: Color(0xFF232C4D), fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w400)),
                    ),
                    children:[
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 30, top: 15, bottom: 10, right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  'Available At : ${prepareData[index].availableAt.storeName}',
                                  style: TextStyle(
                                      color: Color.fromRGBO(35, 44, 77,1), fontSize: 13,fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'Address : ${prepareData[index].availableAt.streetName}',
                                  style: TextStyle(
                                      color: Color.fromRGBO(35, 44, 77,1), fontSize: 13,fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'Area: ${prepareData[index].availableAt.zipCode}',
                                  style: TextStyle(
                                      color: Color.fromRGBO(35, 44, 77,1), fontSize: 13,fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                                )
                    ]
                  ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(79.0, 25.0, 69.0, 61.0),
                            child: Text(
                                "Please log in or Sign Up to add Comments.",
                                style: TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,

                            ),
                          )
                        ],

                      )
          ]
            ));
//            );

//            Theme(data: theme, child: ExpansionPanelList(
//              animationDuration: Duration(seconds: 1),
//              children: [
//                ExpansionPanel(
//                  body: Container(
//                      padding: EdgeInsets.all(10),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Text(
//                            'Available At : ${prepareData[index].availableAt.storeName}',
//                            style: TextStyle(
//                                color: Colors.amber[100], fontSize: 18),
//                          ),
//                          Text(
//                            'Address : ${prepareData[index].availableAt.streetName}',
//                            style: TextStyle(
//                                color: Colors.amber[100], fontSize: 18),
//                          ),
//                          Text(
//                            'Area: ${prepareData[index].availableAt.zipCode}',
//                            style: TextStyle(
//                                color: Colors.amber[100], fontSize: 18),
//                          )
//                        ],
//                      )),
//
//                  headerBuilder: (BuildContext context, bool isExpanded) {
//                    return Container(
//                      padding: EdgeInsets.only(left: 50, top:10),
//                      child: Text(prepareData[index].header,
//                          style:
//                          TextStyle(color: Color(0xFF232C4D), fontSize: 20, fontFamily: 'Montserrat')),
//                    );
//                  },
//                  isExpanded: prepareData[index].isExpanded,
//                )
//              ],
//              expansionCallback: (int item, bool status) {
//                setState(() {
//                  prepareData[index].isExpanded =
//                  !prepareData[index].isExpanded;
//                });
//              },
//            )
//          );
        });
  }

  List<ItemModel> prepareData = <ItemModel>[
    ItemModel(
        header: 'Milk',
        availableAt:
        AvailableAt(storeName: 'Costco', streetName: 'xyz', zipCode: '123')),
    ItemModel(
        header: 'Toilet Paper',
        availableAt:
        AvailableAt(storeName: 'Costco', streetName: 'xyz', zipCode: '123')),
    ItemModel(
        header: 'Cereals',
        availableAt:
        AvailableAt(storeName: 'Costco', streetName: 'xyz', zipCode: '123')),
    ItemModel(
        header: 'Water',
        availableAt:
        AvailableAt(storeName: 'Costco', streetName: 'xyz', zipCode: '123')),
    ItemModel(
        header: 'Chips',
        availableAt:
        AvailableAt(storeName: 'Costco', streetName: 'xyz', zipCode: '123')),
    ItemModel(
        header: 'Bread',
        availableAt:
        AvailableAt(storeName: 'Costco', streetName: 'xyz', zipCode: '123')),
  ];
}

