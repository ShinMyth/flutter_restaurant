import 'package:restaurant/models/menu_item_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MenuItemScreenView extends StatefulWidget {
  const MenuItemScreenView({Key? key, required this.menuItem})
      : super(key: key);

  final MenuItem menuItem;

  @override
  State<MenuItemScreenView> createState() => _MenuItemScreenViewState();
}

class _MenuItemScreenViewState extends State<MenuItemScreenView> {
  int quantity = 0;

  void subtractQuantity() {
    setState(() {
      if (quantity > 0) {
        quantity--;
      }
    });
  }

  void addQuantity() {
    setState(() {
      quantity++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Item"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: widget.menuItem.menuItemImage.isEmpty
                    ? Border.all(color: Theme.of(context).primaryColor)
                    : null,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 30.h,
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              child: widget.menuItem.menuItemImage.isEmpty
                  ? Image.asset("assets/images/flutter-logo.png")
                  : CachedNetworkImage(
                      imageUrl: widget.menuItem.menuItemImage,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(height: 1.5.h),
            Text(
              widget.menuItem.menuItemName,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              "₱${widget.menuItem.menuItemPrice.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 1.5.h),
            Text(
              widget.menuItem.menuItemDescription,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 15.sp,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 0.75,
                  child: ElevatedButton(
                    onPressed: () => subtractQuantity(),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(Icons.remove),
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  width: 15.w,
                  alignment: Alignment.center,
                  child: Text(
                    "$quantity",
                    style: TextStyle(
                      fontSize: 21.sp,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Transform.scale(
                  scale: 0.75,
                  child: ElevatedButton(
                    onPressed: () => addQuantity(),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Add Item",
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
