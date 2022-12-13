import 'dart:developer';
import 'package:restaurant/models/cart_item_model.dart';
import 'package:restaurant/services/sqflite_database_service.dart';

List<CartItem> cart = [];
double subtotal = 0.00;
double total = 0.00;

class CartService {
  Future<void> queryCartItems() async {
    cart.clear();
    subtotal = 0.00;
    total = 0.00;

    try {
      List<Map<String, Object?>> result = await db!.query("cart");

      for (Map<String, Object?> map in result) {
        CartItem cartItem = CartItem.fromMap(map);

        cart.add(cartItem);
        subtotal += cartItem.cartItemGrossTotal;
        total += cartItem.cartItemGrossTotal;
      }
    } catch (e) {
      log("queryCartItems: $e");
    }
  }

  Future<void> insertCartItem({required CartItem cartItem}) async {
    try {
      List<CartItem> result = await queryCartItem(cartItem: cartItem);

      if (result.isNotEmpty) {
        cartItem.cartItemQuantity += result[0].cartItemQuantity;
        cartItem.cartItemGrossTotal =
            cartItem.cartItemPrice * cartItem.cartItemQuantity;

        await updateCartItem(cartItem: cartItem);
      } else {
        await db!.transaction((txn) async {
          txn.insert("cart", cartItem.toMap());
        });
      }
    } catch (e) {
      log("insertCartItem: $e");
    }
  }

  Future<List<CartItem>> queryCartItem({required CartItem cartItem}) async {
    try {
      List<Map<String, Object?>> result = await db!.query(
        "cart",
        where: "cartItemID = ?",
        whereArgs: [cartItem.cartItemID],
      );

      List<CartItem> covertedResult = [];

      for (Map<String, Object?> map in result) {
        covertedResult.add(CartItem.fromMap(map));
      }

      return covertedResult;
    } catch (e) {
      log("queryCartItem: $e");

      return [];
    }
  }

  Future<void> updateCartItem({required CartItem cartItem}) async {
    try {
      await db!.transaction((txn) async {
        txn.update(
          "cart",
          cartItem.toMap(),
          where: "cartItemID = ?",
          whereArgs: [cartItem.cartItemID],
        );
      });
    } catch (e) {
      log("updateCartItem: $e");
    }
  }

  Future<void> deleteCartItem({required CartItem cartItem}) async {
    try {
      await db!.transaction((txn) async {
        txn.delete(
          "cart",
          where: "cartItemID = ?",
          whereArgs: [cartItem.cartItemID],
        );
      });
    } catch (e) {
      log("deleteCartItem: $e");
    }
  }
}
