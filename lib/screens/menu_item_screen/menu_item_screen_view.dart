import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MenuItemScreenView extends StatefulWidget {
  const MenuItemScreenView({Key? key}) : super(key: key);

  @override
  State<MenuItemScreenView> createState() => _MenuItemScreenViewState();
}

class _MenuItemScreenViewState extends State<MenuItemScreenView> {
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
              color: Theme.of(context).primaryColor,
              height: 20.h,
              child: const Center(
                child: Text("Menu Item Image"),
              ),
            ),
            SizedBox(height: 1.5.h),
            const Text("Menu Item Name"),
            SizedBox(height: 1.5.h),
            const Text("Menu Item Price"),
            SizedBox(height: 1.5.h),
            const Text("Menu Item Details"),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text("-"),
                Text("0"),
                Text("+"),
              ],
            ),
            SizedBox(height: 1.5.h),
            ElevatedButton(
              onPressed: () {},
              child: const Text("ADD ITEM"),
            ),
          ],
        ),
      ),
    );
  }
}
