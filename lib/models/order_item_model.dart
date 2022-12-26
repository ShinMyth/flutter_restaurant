import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItem {
  String orderItemID;
  String orderItemImage;
  String orderItemName;
  double orderItemPrice;
  int orderItemQuantity;
  double orderItemGrossTotal;

  OrderItem({
    required this.orderItemID,
    required this.orderItemImage,
    required this.orderItemName,
    required this.orderItemPrice,
    required this.orderItemQuantity,
    required this.orderItemGrossTotal,
  });

  Map<String, dynamic> toFirestore() {
    return {
      "orderItemImage": orderItemImage,
      "orderItemName": orderItemName,
      "orderItemPrice": orderItemPrice,
      "orderItemQuantity": orderItemQuantity,
      "orderItemGrossTotal": orderItemGrossTotal,
    };
  }

  factory OrderItem.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final id = snapshot.id;
    final data = snapshot.data();

    return OrderItem(
      orderItemID: id,
      orderItemImage: data?['orderItemImage'],
      orderItemName: data?['orderItemName'],
      orderItemPrice: data?['orderItemPrice'],
      orderItemQuantity: data?['orderItemQuantity'],
      orderItemGrossTotal: data?['orderItemGrossTotal'],
    );
  }
}
