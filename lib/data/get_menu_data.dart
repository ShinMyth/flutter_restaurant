import 'dart:developer';
import 'package:restaurant/models/menu_item_model.dart';
import 'package:restaurant/models/menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<Menu> menu = [];

Future<void> getMenuData() async {
  menu.clear();
  final db = FirebaseFirestore.instance;

  await db.collection("menu").get().then((value) async {
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in value.docs) {
      Menu menuDoc = Menu.fromFirestore(doc);
      log(menuDoc.toString());
      menu.add(menuDoc);

      await db
          .collection("menu")
          .doc(menuDoc.menuID)
          .collection("menuItems")
          .get()
          .then((value) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in value.docs) {
          MenuItem menuItemDoc = MenuItem.fromFirestore(doc);
          log(menuItemDoc.toString());

          for (Menu menu in menu) {
            if (menu.menuID == menuDoc.menuID) {
              menu.menuItems.add(menuItemDoc);
            }
          }
        }
      });
    }
  });
}
