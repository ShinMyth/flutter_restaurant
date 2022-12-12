import 'package:restaurant/data/menu_data.dart';
import 'package:restaurant/screens/cart_screen/cart_screen_view.dart';
import 'package:restaurant/screens/menu_screen/widgets/custom_menu.dart';
import 'package:restaurant/screens/menu_screen/menu_screen_controller.dart';
import 'package:restaurant/screens/order_history_screen/order_history_screen_view.dart';
import 'package:restaurant/screens/signin_screen/signin_screen_view.dart';
import 'package:restaurant/services/firebase_authentication_service.dart';
import 'package:restaurant/shared/shared_dialog.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MenuScreenView extends StatefulWidget {
  const MenuScreenView({Key? key}) : super(key: key);

  @override
  State<MenuScreenView> createState() => _MenuScreenViewState();
}

class _MenuScreenViewState extends State<MenuScreenView> {
  late MenuScreenController controller;

  @override
  void initState() {
    controller = MenuScreenController();

    getMenuData();
    super.initState();
  }

  Future<void> getMenuData() async {
    await controller.getMenuData();
    setState(() {});
  }

  Future<void> signOut() async {
    showSharedDialog(
      context: context,
      barrierDismissible: true,
      title: const Text("Confirm Sign out"),
      content: const Text("Are you sure you want to sign out?"),
      actionFunction1: () => Navigator.pop(context),
      actionLabel1: const Text("Cancel"),
      actionFunction2: () async {
        Navigator.pop(context);

        await FirebaseAuthenticationService().signOut();

        Navigator.pop(context);
        setState(() {});
      },
      actionLabel2: const Text("Sign out"),
    );
  }

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
                    FirebaseAuthenticationService().auth.currentUser == null
                        ? ""
                        : FirebaseAuthenticationService()
                            .auth
                            .currentUser!
                            .displayName!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ),
            if (FirebaseAuthenticationService().auth.currentUser == null) ...[
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
            ] else ...[
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
                onTap: () => signOut(),
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
            ],
            ElevatedButton(
              onPressed: () => setMenuData(),
              child: const Text("Set Menu Data"),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => getMenuData(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: ListView.builder(
            itemCount: controller.menu.length,
            itemBuilder: (context, index) {
              return CustomMenu(menu: controller.menu[index]);
            },
          ),
        ),
      ),
    );
  }
}
