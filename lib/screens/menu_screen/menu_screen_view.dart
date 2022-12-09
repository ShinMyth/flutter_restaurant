import 'package:restaurant/data/get_menu_data.dart';
import 'package:restaurant/data/set_menu_data.dart';
import 'package:restaurant/screens/cart_screen/cart_screen_view.dart';
import 'package:restaurant/screens/menu_screen/widgets/custom_menu_item.dart';
import 'package:restaurant/screens/order_history_screen/order_history_screen_view.dart';
import 'package:restaurant/screens/signin_screen/signin_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MenuScreenView extends StatefulWidget {
  const MenuScreenView({Key? key}) : super(key: key);

  @override
  State<MenuScreenView> createState() => _MenuScreenViewState();
}

class _MenuScreenViewState extends State<MenuScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Restaurant"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreenView(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_bag_rounded),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 10.w,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        const AssetImage("assets/images/flutter-logo.png"),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    "John Doe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderHistoryScreenView(),
                  ),
                );
              },
              leading: Icon(
                Icons.list_alt_rounded,
                color: Colors.black.withOpacity(0.8),
              ),
              title: Text(
                "Order History",
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SigninScreenView(),
                  ),
                );
              },
              leading: Icon(
                Icons.login_rounded,
                color: Colors.black.withOpacity(0.8),
              ),
              title: Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.logout_rounded,
                color: Colors.black.withOpacity(0.8),
              ),
              title: Text(
                "Sign Out",
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => setMenuData(),
              child: const Text("Set Menu Data"),
            ),
            ElevatedButton(
              onPressed: () => getMenuData(),
              child: const Text("Get Menu Data"),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.5.h),
                Text(
                  "Menu Group",
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 1.5.h),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.w,
                    crossAxisSpacing: 5.w,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return const CustomMenuItem();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
