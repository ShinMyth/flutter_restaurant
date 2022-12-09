import 'package:restaurant/models/menu_item_model.dart';
import 'package:restaurant/models/menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<Menu> menu = [
  Menu(
    menuID: "M01",
    menuName: "RAMEN",
    menuOrder: 1,
    menuItems: [
      MenuItem(
        menuItemID: "MI01",
        menuItemName: "Karashibi Miso Ramen",
        menuItemPrice: 100.00,
      ),
      MenuItem(
        menuItemID: "MI02",
        menuItemName: "Ajitama Karashibi Miso Ramen",
        menuItemPrice: 120.00,
      ),
      MenuItem(
        menuItemID: "MI03",
        menuItemName: "Young Corn Karashibi Miso Ramen",
        menuItemPrice: 130.00,
      ),
    ],
  ),
  Menu(
    menuID: "M02",
    menuName: "ADD-ONS",
    menuOrder: 2,
    menuItems: [
      MenuItem(
        menuItemID: "MI04",
        menuItemName: "Ajitama",
        menuItemPrice: 20.00,
      ),
      MenuItem(
        menuItemID: "MI05",
        menuItemName: "Young Corn",
        menuItemPrice: 30.00,
      ),
    ],
  ),
  Menu(
    menuID: "M03",
    menuName: "DRINKS",
    menuOrder: 3,
    menuItems: [
      MenuItem(
        menuItemID: "MI06",
        menuItemName: "Water",
        menuItemPrice: 25.00,
      ),
      MenuItem(
        menuItemID: "MI07",
        menuItemName: "Cola",
        menuItemPrice: 35.00,
      ),
      MenuItem(
        menuItemID: "MI08",
        menuItemName: "Beer",
        menuItemPrice: 45.00,
      ),
    ],
  ),
];

Future<void> setMenuData() async {
  final db = FirebaseFirestore.instance;

  for (Menu menu in menu) {
    await db.collection("menu").doc(menu.menuID).set(menu.toFirestore());

    for (MenuItem menuItem in menu.menuItems) {
      await db
          .collection("menu")
          .doc(menu.menuID)
          .collection("menuItems")
          .doc(menuItem.menuItemID)
          .set(menuItem.toFirestore());
    }
  }
}
