class CartItem {
  String cartItemID;
  String cartItemImage;
  String cartItemName;
  double cartItemPrice;
  int cartItemQuantity;
  double cartItemGrossTotal;

  CartItem({
    required this.cartItemID,
    required this.cartItemImage,
    required this.cartItemName,
    required this.cartItemPrice,
    required this.cartItemQuantity,
    required this.cartItemGrossTotal,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartItemID': cartItemID,
      'cartItemImage': cartItemImage,
      'cartItemName': cartItemName,
      'cartItemPrice': cartItemPrice,
      'cartItemQuantity': cartItemQuantity,
      'cartItemGrossTotal': cartItemGrossTotal,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      cartItemID: map['cartItemID'] as String,
      cartItemImage: map['cartItemImage'] as String,
      cartItemName: map['cartItemName'] as String,
      cartItemPrice: map['cartItemPrice'] as double,
      cartItemQuantity: map['cartItemQuantity'] as int,
      cartItemGrossTotal: map['cartItemGrossTotal'] as double,
    );
  }
}
