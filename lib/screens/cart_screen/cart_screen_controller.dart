import 'package:restaurant/models/order_item_model.dart';
import 'package:restaurant/models/order_model.dart';
import 'package:restaurant/services/cart_service.dart';
import 'package:restaurant/services/firebase_authentication_service.dart';
import 'package:restaurant/shared/shared_dialog.dart';
import 'package:restaurant/shared/shared_loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartScreenController {
  final Function() setstate;
  final BuildContext context;

  CartScreenController({required this.setstate, required this.context});

  final firestore = FirebaseFirestore.instance;

  Future<void> getCartItems() async {
    await CartService().queryCartItems();
    setstate();
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

  Future<void> removeCartItem({required int index}) async {
    await showSharedDialog(
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
  }

  Future<void> placeOrder() async {
    bool isPlaceOrder = await showSharedDialog(
          context: context,
          barrierDismissible: true,
          title: const Text("Place Order"),
          content: const Text("Do you want to place your order?"),
          actionFunction1: () => Navigator.pop(context, false),
          actionLabel1: const Text("Cancel"),
          actionFunction2: () => Navigator.pop(context, true),
          actionLabel2: const Text("Place"),
        ) ??
        false;

    if (isPlaceOrder) {
      showSharedLoading(context: context);

      Order order = Order(
        orderID: await generateOrderID(),
        orderUserID: FirebaseAuthenticationService().auth.currentUser!.uid,
        orderStatus: "Ongoing",
        orderDateTime: DateTime.now().toString(),
        orderSubtotal: subtotal,
        orderTotal: total,
        orderItems: [],
      );

      await firestore
          .collection("orders")
          .doc(order.orderID)
          .set(order.toFirestore());

      for (var cartItem in cart) {
        OrderItem orderItem = OrderItem(
          orderItemID: await generateOrderItemID(orderID: order.orderID),
          orderItemImage: cartItem.cartItemImage,
          orderItemName: cartItem.cartItemName,
          orderItemPrice: cartItem.cartItemPrice,
          orderItemQuantity: cartItem.cartItemQuantity,
          orderItemGrossTotal: cartItem.cartItemGrossTotal,
        );

        await firestore
            .collection("orders")
            .doc(order.orderID)
            .collection("orderItems")
            .doc(orderItem.orderItemID)
            .set(orderItem.toFirestore());
      }

      Navigator.pop(context);
      Navigator.pop(context);

      CartService().deleteCartItems();
    }
  }

  Future<String> generateOrderID() async {
    QuerySnapshot<Map<String, dynamic>> value =
        await firestore.collection("orders").get();

    return "O-${DateFormat('yyyyMMd').format(DateTime.now())}-0${value.docs.length + 1}";
  }

  Future<String> generateOrderItemID({required String orderID}) async {
    QuerySnapshot<Map<String, dynamic>> value = await firestore
        .collection("orders")
        .doc(orderID)
        .collection("orderItems")
        .get();

    return "$orderID-OI0${value.docs.length + 1}";
  }
}
