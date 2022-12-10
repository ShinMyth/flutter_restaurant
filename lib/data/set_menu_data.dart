import 'dart:developer';
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
        menuItemImage:
            "https://kikanbo.co.jp/wp-content/themes/standard_black_cmspro/img/3e0e022620eca5b5e69b5dc8465b0a45-1000x667.jpg",
        menuItemName: "Karashibi Miso Ramen",
        menuItemPrice: 100.00,
        menuItemDescription:
            "A ramen with a specially designed noodles that retains it's taste and texture until the very last bite. And a broth made with the combination of pig bones, chicken bones and several kinds of vegetables that is stewed for more than 10 hours. Blended with carefully selected red peppers “kara”, fragrant numbness oil “shibi” and with an “original formulation miso” that gives you a memorable addictive sensation. Topped with stir fried bean sprouts, sweet young corn and star anise flavored sweet braised pork belly.",
        menuItemOrder: 1,
      ),
      MenuItem(
        menuItemID: "MI02",
        menuItemImage:
            "https://kikanbo.co.jp/wp-content/themes/standard_black_cmspro/img/5d34b8480fd829fed95e99694023a0c6-1000x667.jpg",
        menuItemName: "Ajitama Karashibi Miso Ramen",
        menuItemPrice: 120.00,
        menuItemDescription:
            "A ramen with a specially designed noodles that retains it's taste and texture until the very last bite. And a broth made with the combination of pig bones, chicken bones and several kinds of vegetables that is stewed for more than 10 hours. Blended with carefully selected red peppers “kara”, fragrant numbness oil “shibi” and with an “original formulation miso” that gives you a memorable addictive sensation. Topped with stir fried bean sprouts, sweet young corn, marinated soft-boiled egg and star anise flavored sweet braised pork belly.",
        menuItemOrder: 2,
      ),
      MenuItem(
        menuItemID: "MI03",
        menuItemImage:
            "https://kikanbo.co.jp/wp-content/themes/standard_black_cmspro/img/6f938cc2c6a7b114a1509d4975e9b40d-1000x667.jpg",
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
        menuItemImage:
            "https://kikanbo.co.jp/wp-content/themes/standard_black_cmspro/img/181016-0517.jpg",
        menuItemName: "Ajitama",
        menuItemPrice: 20.00,
        menuItemDescription:
            "Japanese soft-boiled egg marinated in a sweetened soy sauce mixture.",
        menuItemOrder: 1,
      ),
      MenuItem(
        menuItemID: "MI05",
        menuItemImage:
            "https://kikanbo.co.jp/wp-content/themes/standard_black_cmspro/img/181016-0513.jpg",
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
  log("Set Menu Data: Success");
}
