import 'package:restaurant/models/menu_model.dart';
import 'package:restaurant/screens/menu_screen/widgets/custom_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomMenu extends StatefulWidget {
  const CustomMenu({Key? key, required this.menu}) : super(key: key);

  final Menu menu;

  @override
  State<CustomMenu> createState() => _CustomMenuState();
}

class _CustomMenuState extends State<CustomMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        Text(
          widget.menu.menuName,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5.w,
            crossAxisSpacing: 5.w,
          ),
          itemCount: widget.menu.menuItems.length,
          itemBuilder: (context, index) {
            return CustomMenuItem(
              menuItem: widget.menu.menuItems[index],
            );
          },
        ),
      ],
    );
  }
}
