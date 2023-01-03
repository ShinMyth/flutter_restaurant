import 'package:restaurant/models/menu_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  String menuID;
  String menuName;
  int menuOrder;
  List<MenuItem> menuItems = [];

  Menu({
    required this.menuID,
    required this.menuName,
    required this.menuOrder,
    required this.menuItems,
  });

  // Map<String, dynamic> toFirestore() {
  //   return {
  //     "menuName": menuName,
  //     "menuOrder": menuOrder,
  //   };
  // }

  factory Menu.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final id = snapshot.id;
    final data = snapshot.data();

    return Menu(
      menuID: id,
      menuName: data?['menuName'],
      menuOrder: data?['menuOrder'],
      menuItems: [],
    );
  }
}
