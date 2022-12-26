import 'package:restaurant/models/order_item_model.dart';
import 'package:restaurant/models/order_model.dart';
import 'package:restaurant/services/firebase_authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersScreenController {
  final Function() setstate;
  final BuildContext context;

  OrdersScreenController({required this.setstate, required this.context});

  final firestore = FirebaseFirestore.instance;

  List<Order> orders = [];

  bool isLoading = false;

  Future<void> getOrdersData() async {
    isLoading = true;

    setstate();

    orders.clear();

    await firestore
        .collection("orders")
        .where("orderUserID",
            isEqualTo: FirebaseAuthenticationService().auth.currentUser!.uid)
        .orderBy("orderDateTime", descending: true)
        .get()
        .then((value) async {
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in value.docs) {
        Order orderDoc = Order.fromFirestore(doc);

        orders.add(orderDoc);

        await firestore
            .collection("orders")
            .doc(orderDoc.orderID)
            .collection("orderItems")
            .get()
            .then((value) {
          for (QueryDocumentSnapshot<Map<String, dynamic>> doc in value.docs) {
            OrderItem orderItemDoc = OrderItem.fromFirestore(doc);

            for (Order order in orders) {
              if (order.orderID == orderDoc.orderID) {
                order.orderItems.add(orderItemDoc);
              }
            }
          }
        });
      }
    });

    isLoading = false;

    setstate();
  }
}
