import 'dart:developer';
import 'dart:typed_data';
import 'package:restaurant/models/menu_item_model.dart';
import 'package:restaurant/models/menu_model.dart';
import 'package:restaurant/services/shared_preferences_service.dart';
import 'package:restaurant/shared/shared_dialog.dart';
import 'package:restaurant/shared/shared_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MenuData {
  final BuildContext context;

  MenuData({required this.context});

  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  List<Menu> menu = [
    Menu(
      menuID: "M01",
      menuName: "RAMEN",
      menuOrder: 1,
      menuItems: [
        MenuItem(
          menuItemID: "MI01",
          menuItemImage: "karashibi-miso-ramen.jpeg",
          menuItemName: "Karashibi Miso Ramen",
          menuItemPrice: 100.00,
          menuItemDescription:
              "A ramen with a specially designed noodles that retains it's taste and texture until the very last bite. And a broth made with the combination of pig bones, chicken bones and several kinds of vegetables that is stewed for more than 10 hours. Blended with carefully selected red peppers “kara”, fragrant numbness oil “shibi” and with an “original formulation miso” that gives you a memorable addictive sensation. Topped with stir fried bean sprouts, sweet young corn and star anise flavored sweet braised pork belly.",
          menuItemOrder: 1,
        ),
        MenuItem(
          menuItemID: "MI02",
          menuItemImage: "ajitama-karashibi-miso-ramen.jpeg",
          menuItemName: "Ajitama Karashibi Miso Ramen",
          menuItemPrice: 120.00,
          menuItemDescription:
              "A ramen with a specially designed noodles that retains it's taste and texture until the very last bite. And a broth made with the combination of pig bones, chicken bones and several kinds of vegetables that is stewed for more than 10 hours. Blended with carefully selected red peppers “kara”, fragrant numbness oil “shibi” and with an “original formulation miso” that gives you a memorable addictive sensation. Topped with stir fried bean sprouts, sweet young corn, marinated soft-boiled egg and star anise flavored sweet braised pork belly.",
          menuItemOrder: 2,
        ),
        MenuItem(
          menuItemID: "MI03",
          menuItemImage: "young-corn-karashibi-miso-ramen.jpeg",
          menuItemName: "Young Corn Karashibi Miso Ramen",
          menuItemPrice: 130.00,
          menuItemDescription:
              "A ramen with a specially designed noodles that retains it's taste and texture until the very last bite. And a broth made with the combination of pig bones, chicken bones and several kinds of vegetables that is stewed for more than 10 hours. Blended with carefully selected red peppers “kara”, fragrant numbness oil “shibi” and with an “original formulation miso” that gives you a memorable addictive sensation. Topped with stir fried bean sprouts, multiple sweet young corn and star anise flavored sweet braised pork belly.",
          menuItemOrder: 3,
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
          menuItemImage: "ajitama.jpeg",
          menuItemName: "Ajitama",
          menuItemPrice: 20.00,
          menuItemDescription:
              "Japanese soft-boiled egg marinated in a sweetened soy sauce mixture.",
          menuItemOrder: 1,
        ),
        MenuItem(
          menuItemID: "MI05",
          menuItemImage: "young-corn.jpeg",
          menuItemName: "Young Corn",
          menuItemPrice: 30.00,
          menuItemDescription:
              "A slighty toasted young corn with a hint of sweetness.",
          menuItemOrder: 2,
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
          menuItemImage: "",
          menuItemName: "Bottled Water",
          menuItemPrice: 25.00,
          menuItemDescription: "",
          menuItemOrder: 1,
        ),
        MenuItem(
          menuItemID: "MI07",
          menuItemImage: "",
          menuItemName: "Cola",
          menuItemPrice: 35.00,
          menuItemDescription: "",
          menuItemOrder: 2,
        ),
        MenuItem(
          menuItemID: "MI08",
          menuItemImage: "",
          menuItemName: "Beer",
          menuItemPrice: 45.00,
          menuItemDescription: "",
          menuItemOrder: 3,
        ),
      ],
    ),
  ];

  Future<void> setMenuData() async {
    await showSharedDialog(
      context: context,
      barrierDismissible: false,
      title: const Text("Set Menu Data"),
      content: const Text(
          "Setting-up initial menu data for the app's core functionality."),
      actionFunction1: () => Navigator.pop(context),
      actionLabel1: const Text("Set"),
    );

    showSharedLoading(context: context);

    for (Menu menu in menu) {
      await firestore
          .collection("menu")
          .doc(menu.menuID)
          .set(menu.toFirestore());

      for (MenuItem menuItem in menu.menuItems) {
        if (menuItem.menuItemImage.isNotEmpty) {
          menuItem.menuItemImage =
              await uploadMenuItemImage(menuItemImage: menuItem.menuItemImage);
        }

        await firestore
            .collection("menu")
            .doc(menu.menuID)
            .collection("menuItems")
            .doc(menuItem.menuItemID)
            .set(menuItem.toFirestore());
      }
    }
    await prefs.setBool("isSetMenuData", true);

    Navigator.pop(context);
  }

  Future<String> uploadMenuItemImage({required String menuItemImage}) async {
    String assetsPath = "assets/images/menu/menu_items/$menuItemImage";
    String referencePath = "menu/menu_items/$menuItemImage";

    ByteData byteData = await rootBundle.load(assetsPath);

    Uint8List data = byteData.buffer.asUint8List(
      byteData.offsetInBytes,
      byteData.lengthInBytes,
    );

    try {
      await storage.ref().child(referencePath).putData(data);

      return await storage.ref().child(referencePath).getDownloadURL();
    } on FirebaseException catch (e) {
      log(e.toString());

      return "";
    }
  }
}
