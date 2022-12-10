import 'package:cached_network_image/cached_network_image.dart';
import 'package:restaurant/models/menu_item_model.dart';
import 'package:restaurant/screens/menu_item_screen/menu_item_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomMenuItem extends StatefulWidget {
  const CustomMenuItem({Key? key, required this.menuItem}) : super(key: key);

  final MenuItem menuItem;

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
            builder: (context) => MenuItemScreenView(
              menuItem: widget.menuItem,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Expanded(
              child: widget.menuItem.menuItemImage.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: widget.menuItem.menuItemImage,
                      fit: BoxFit.cover,
                    )
                  : Image.asset("assets/images/flutter-logo.png"),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              height: 6.h,
              width: double.infinity,
              padding: EdgeInsets.all(1.5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.menuItem.menuItemName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    "₱ ${widget.menuItem.menuItemPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
