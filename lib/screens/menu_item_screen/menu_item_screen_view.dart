import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

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
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(15),
              ),
              height: 20.h,
              width: double.infinity,
              child: Image.asset("assets/images/flutter-logo.png"),
            ),
            SizedBox(height: 1.5.h),
            Text(
              "Menu Item",
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              "₱ 100.00",
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 1.5.h),
            Text(
              lorem(paragraphs: 1, words: 60),
              textAlign: TextAlign.justify,
              style: TextStyle(
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Transform.scale(
                  scale: 0.7,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(Icons.remove),
                  ),
                ),
                Text(
                  "0",
                  style: TextStyle(
                    fontSize: 21.sp,
                  ),
                ),
                Transform.scale(
                  scale: 0.7,
                  child: ElevatedButton(
                    onPressed: () {},
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
            SizedBox(height: 1.5.h),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Add Item",
                style: TextStyle(
                  fontSize: 17.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
