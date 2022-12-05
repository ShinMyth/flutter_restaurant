import 'package:flutter/material.dart';
import 'package:restaurant/screens/menu_item_screen/menu_item_screen_view.dart';

class CustomMenuItem extends StatefulWidget {
  const CustomMenuItem({Key? key}) : super(key: key);

  @override
  State<CustomMenuItem> createState() => _CustomMenuItemState();
}

class _CustomMenuItemState extends State<CustomMenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MenuItemScreenView(),
          ),
        );
      },
      child: Container(
        color: Theme.of(context).primaryColor,
        child: const Center(
          child: Text("Menu Item"),
        ),
      ),
    );
  }
}
