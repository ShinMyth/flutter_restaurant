import 'package:restaurant/models/menu_item_model.dart';
import 'package:restaurant/models/menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuScreenController {
  List<Menu> menu = [];

  Future<void> getMenuData() async {
    menu.clear();
    final db = FirebaseFirestore.instance;

    await db
        .collection("menu")
        .orderBy("menuOrder", descending: false)
        .get()
        .then((value) async {
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in value.docs) {
        Menu menuDoc = Menu.fromFirestore(doc);

        menu.add(menuDoc);

        await db
            .collection("menu")
            .doc(menuDoc.menuID)
            .collection("menuItems")
            .orderBy("menuItemOrder", descending: false)
            .get()
            .then((value) {
          for (QueryDocumentSnapshot<Map<String, dynamic>> doc in value.docs) {
            MenuItem menuItemDoc = MenuItem.fromFirestore(doc);

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
}
