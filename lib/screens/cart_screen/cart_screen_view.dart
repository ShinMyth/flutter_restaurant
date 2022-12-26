import 'package:restaurant/screens/cart_screen/widgets/custom_cart_item.dart';
import 'package:restaurant/screens/cart_screen/cart_screen_controller.dart';
import 'package:restaurant/screens/menu_screen/menu_screen_controller.dart';
import 'package:restaurant/screens/signin_screen/signin_screen_view.dart';
import 'package:restaurant/services/cart_service.dart';
import 'package:restaurant/services/firebase_authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CartScreenView extends StatefulWidget {
  const CartScreenView({Key? key, required this.menuScreenController})
      : super(key: key);

  final MenuScreenController menuScreenController;

  @override
  State<CartScreenView> createState() => _CartScreenViewState();
}

class _CartScreenViewState extends State<CartScreenView> {
  late CartScreenController controller;

  @override
  void initState() {
    controller = CartScreenController(
      setstate: () => setState(() {}),
      context: context,
    );

    controller.getCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: cart.isEmpty
          ? const Center(
              child: Text("Cart Empty"),
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        return CustomCartItem(
                          cartItem: cart[index],
                          decrementQuantity: () =>
                              controller.decrementQuantity(index: index),
                          incrementQuantity: () =>
                              controller.incrementQuantity(index: index),
                          removeCartItem: () =>
                              controller.removeCartItem(index: index),
                        );
                      },
                    ),
                    const Divider(),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          "₱${subtotal.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "₱${total.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: cart.isEmpty
          ? null
          : Container(
              margin: const EdgeInsets.only(top: 5),
              height: 10.h,
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (FirebaseAuthenticationService().auth.currentUser ==
                      null) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SigninScreenView(
                                        menuScreenController:
                                            widget.menuScreenController,
                                        cartScreenController: controller,
                                      ),
                                    ),
                                  );
                                },
                              text: "Sign in ",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16.sp,
                              ),
                            ),
                            TextSpan(
                              text: "to place your order",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    ElevatedButton(
                      onPressed: () => controller.placeOrder(),
                      child: Text(
                        "Place Order",
                        style: TextStyle(
                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
