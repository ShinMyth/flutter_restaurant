import 'package:cloud_firestore/cloud_firestore.dart';

class MenuItem {
  String menuItemID;
  String menuItemImage;
  String menuItemName;
  double menuItemPrice;
  String menuItemDescription;
  int menuItemOrder;

  MenuItem({
    required this.menuItemID,
    required this.menuItemImage,
    required this.menuItemName,
    required this.menuItemPrice,
    required this.menuItemDescription,
    required this.menuItemOrder,
  });

  // Map<String, dynamic> toFirestore() {
  //   return {
  //     "menuItemImage": menuItemImage,
  //     "menuItemName": menuItemName,
  //     "menuItemPrice": menuItemPrice,
  //     "menuItemDescription": menuItemDescription,
  //     "menuItemOrder": menuItemOrder,
  //   };
  // }

  factory MenuItem.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final id = snapshot.id;
    final data = snapshot.data();

    return MenuItem(
      menuItemID: id,
      menuItemImage: data?['menuItemImage'],
      menuItemName: data?['menuItemName'],
      menuItemPrice: data?['menuItemPrice'],
      menuItemDescription: data?['menuItemDescription'],
      menuItemOrder: data?['menuItemOrder'],
    );
  }
}
