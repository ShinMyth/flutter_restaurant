import 'package:restaurant/services/cart_service.dart';
import 'package:restaurant/shared/shared_dialog.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartScreenView extends StatefulWidget {
  const CartScreenView({Key? key}) : super(key: key);

  @override
  State<CartScreenView> createState() => _CartScreenViewState();
}

class _CartScreenViewState extends State<CartScreenView> {
  @override
  void initState() {
    getCartItems();
    super.initState();
  }

  Future<void> getCartItems() async {
    await CartService().queryCartItems();
    setState(() {});
  }

  Future<void> decrementQuantity({required int index}) async {
    if (cart[index].cartItemQuantity == 1) {
      showSharedDialog(
        context: context,
        barrierDismissible: true,
        title: const Text("Remove Cart Item"),
        content: const Text("Do you want to remove cart item?"),
        actionFunction1: () => Navigator.pop(context),
        actionLabel1: const Text("Cancel"),
        actionFunction2: () async {
          await CartService().deleteCartItem(cartItem: cart[index]);

          await getCartItems();

          Navigator.pop(context);
        },
        actionLabel2: const Text("Remove"),
      );

      return;
    }

    cart[index].cartItemQuantity--;
    cart[index].cartItemGrossTotal =
        cart[index].cartItemPrice * cart[index].cartItemQuantity;

    await CartService().updateCartItem(cartItem: cart[index]);

    await getCartItems();
  }

  Future<void> incrementQuantity({required int index}) async {
    cart[index].cartItemQuantity++;
    cart[index].cartItemGrossTotal =
        cart[index].cartItemPrice * cart[index].cartItemQuantity;

    await CartService().updateCartItem(cartItem: cart[index]);

    await getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: Padding(
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
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 20.w,
                                width: 20.w,
                                decoration: BoxDecoration(
                                  border: cart[index].cartItemImage.isEmpty
                                      ? Border.all(
                                          color: Theme.of(context).primaryColor)
                                      : null,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: cart[index].cartItemImage.isEmpty
                                    ? Image.asset(
                                        "assets/images/flutter-logo.png")
                                    : CachedNetworkImage(
                                        imageUrl: cart[index].cartItemImage,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              SizedBox(width: 3.w),
                              SizedBox(
                                width: 55.w,
                                child: Text(
                                  cart[index].cartItemName,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 0.6,
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          decrementQuantity(index: index),
                                      style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                      ),
                                      child: const Icon(Icons.remove),
                                    ),
                                  ),
                                  Container(
                                    width: 15.w,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${cart[index].cartItemQuantity}",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                  Transform.scale(
                                    scale: 0.6,
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          incrementQuantity(index: index),
                                      style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                      ),
                                      child: const Icon(Icons.add),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "₱${cart[index].cartItemGrossTotal.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
        color: Colors.grey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Place Order",
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
