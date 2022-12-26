import 'package:restaurant/models/order_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String orderID;
  String orderUserID;
  String orderStatus;
  String orderDateTime;
  double orderSubtotal;
  double orderTotal;
  List<OrderItem> orderItems = [];

  Order({
    required this.orderID,
    required this.orderUserID,
    required this.orderStatus,
    required this.orderDateTime,
    required this.orderSubtotal,
    required this.orderTotal,
    required this.orderItems,
  });

  Map<String, dynamic> toFirestore() {
    return {
      "orderUserID": orderUserID,
      "orderStatus": orderStatus,
      "orderDateTime": orderDateTime,
      "orderSubtotal": orderSubtotal,
      "orderTotal": orderTotal,
    };
  }

  factory Order.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final id = snapshot.id;
    final data = snapshot.data();

    return Order(
      orderID: id,
      orderUserID: data?['orderUserID'],
      orderStatus: data?['orderStatus'],
      orderDateTime: data?['orderDateTime'],
      orderSubtotal: data?['orderSubtotal'],
      orderTotal: data?['orderTotal'],
      orderItems: [],
    );
  }
}
