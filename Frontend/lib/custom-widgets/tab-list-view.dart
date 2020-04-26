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
        itemCount: prepareData.length,
        itemBuilder: (BuildContext context, int index) {
          return ExpansionPanelList(
            animationDuration: Duration(seconds: 1),
            children: [
              ExpansionPanel(
                body: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Available At : ${prepareData[index].availableAt.storeName}',
                          style: TextStyle(
                              color: Colors.amber[100], fontSize: 18),
                        ),
                        Text(
                          'Address : ${prepareData[index].availableAt.streetName}',
                          style: TextStyle(
                              color: Colors.amber[100], fontSize: 18),
                        ),
                        Text(
                          'Area: ${prepareData[index].availableAt.zipCode}',
                          style: TextStyle(
                              color: Colors.amber[100], fontSize: 18),
                        )
                      ],
                    )),
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Text(prepareData[index].header,
                        style:
                        TextStyle(color: Colors.black38, fontSize: 19)),
                  );
                },
                isExpanded: prepareData[index].isExpanded,
              )
            ],
            expansionCallback: (int item, bool status) {
              setState(() {
                prepareData[index].isExpanded =
                !prepareData[index].isExpanded;
              });
            },
          );
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

