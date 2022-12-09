import 'package:cloud_firestore/cloud_firestore.dart';

class MenuItem {
  String menuItemID;
  String menuItemName;
  double menuItemPrice;

  MenuItem({
    required this.menuItemID,
    required this.menuItemName,
    required this.menuItemPrice,
  });

  Map<String, dynamic> toFirestore() {
    return {
      "menuItemName": menuItemName,
      "menuItemPrice": menuItemPrice,
    };
  }

  factory MenuItem.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final id = snapshot.id;
    final data = snapshot.data();

    return MenuItem(
      menuItemID: id,
      menuItemName: data?['menuItemName'],
      menuItemPrice: data?['menuItemPrice'],
    );
  }
}
