import 'package:restaurant/services/cart_service.dart';
import 'package:restaurant/shared/shared_dialog.dart';
import 'package:flutter/material.dart';

class CartScreenController {
  final Function() setstate;
  final BuildContext context;

  CartScreenController({required this.setstate, required this.context});

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
}
