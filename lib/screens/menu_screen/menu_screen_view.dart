import 'package:restaurant/screens/menu_screen/widgets/custom_menu_item.dart';
import 'package:restaurant/screens/cart_screen/cart_screen_view.dart';
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
              child: const Center(child: Text("Profile Photo")),
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
              leading: const Icon(Icons.list_alt_rounded),
              title: const Text("Order History"),
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
              leading: const Icon(Icons.login_rounded),
              title: const Text("Sign In"),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.logout_rounded),
              title: const Text("Sign Out"),
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
                const Text("Menu Group"),
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
