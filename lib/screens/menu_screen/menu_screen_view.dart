import 'package:restaurant/screens/cart_screen/cart_screen_view.dart';
import 'package:restaurant/screens/menu_screen/widgets/custom_menu.dart';
import 'package:restaurant/screens/menu_screen/menu_screen_controller.dart';
import 'package:restaurant/screens/order_history_screen/order_history_screen_view.dart';
import 'package:restaurant/screens/signin_screen/signin_screen_view.dart';
import 'package:restaurant/services/firebase_authentication_service.dart';
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
    controller = MenuScreenController(
      setstate: () => setState(() {}),
      context: context,
    );

    controller.getMenuData();
    super.initState();
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
                  builder: (context) => CartScreenView(
                    menuScreenController: controller,
                  ),
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
                      builder: (context) => SigninScreenView(
                        menuScreenController: controller,
                      ),
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
                onTap: () => controller.signOut(),
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
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.getMenuData(),
        child: controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.menu.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Menu Empty"),
                        SizedBox(height: 2.h),
                        GestureDetector(
                          onTap: () => controller.getMenuData(),
                          child: const Icon(Icons.refresh),
                        ),
                      ],
                    ),
                  )
                : Padding(
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
