class ItemModel {
  bool isExpanded;
  String header;
  DateTime dateTime;
  AvailableAt availableAt;
  
  ItemModel({this.isExpanded:false, this.header, this.availableAt});

}

class AvailableAt {
  String storeName;
  String streetName;
  String zipCode;

  AvailableAt({this.storeName, this.streetName, this.zipCode});
}