import 'package:restaurant/models/menu_item_model.dart';
import 'package:restaurant/models/menu_model.dart';
import 'package:restaurant/services/firebase_authentication_service.dart';
import 'package:restaurant/shared/shared_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuScreenController {
  final Function() setstate;
  final BuildContext context;

  MenuScreenController({required this.setstate, required this.context});

  final firestore = FirebaseFirestore.instance;

  List<Menu> menu = [];

  Future<void> getMenuData() async {
    menu.clear();

    await firestore
        .collection("menu")
        .orderBy("menuOrder", descending: false)
        .get()
        .then((value) async {
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in value.docs) {
        Menu menuDoc = Menu.fromFirestore(doc);

        menu.add(menuDoc);

        await firestore
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

    setstate();
  }

  Future<void> signOut() async {
    showSharedDialog(
      context: context,
      barrierDismissible: true,
      title: const Text("Confirm Sign out"),
      content: const Text("Are you sure you want to sign out?"),
      actionFunction1: () => Navigator.pop(context),
      actionLabel1: const Text("Cancel"),
      actionFunction2: () async {
        Navigator.pop(context);

        await FirebaseAuthenticationService().signOut();

        Navigator.pop(context);
        setstate();
      },
      actionLabel2: const Text("Sign out"),
    );
  }
}
