import 'package:restaurant/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomCartItem extends StatefulWidget {
  const CustomCartItem({
    Key? key,
    required this.cartItem,
    required this.decrementQuantity,
    required this.incrementQuantity,
    required this.removeCartItem,
  }) : super(key: key);

  final CartItem cartItem;
  final Function() decrementQuantity;
  final Function() incrementQuantity;
  final Function() removeCartItem;

  @override
  State<CustomCartItem> createState() => _CustomCartItemState();
}

class _CustomCartItemState extends State<CustomCartItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => widget.removeCartItem(),
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: "Remove",
            ),
          ],
        ),
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
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: widget.cartItem.cartItemImage.isEmpty
                        ? Image.asset("assets/images/flutter-logo.png")
                        : CachedNetworkImage(
                            imageUrl: widget.cartItem.cartItemImage,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Image.asset("assets/images/flutter-logo.png"),
                            errorWidget: (context, url, error) =>
                                Image.asset("assets/images/flutter-logo.png"),
                          ),
                  ),
                  SizedBox(width: 3.w),
                  SizedBox(
                    width: 55.w,
                    child: Text(
                      widget.cartItem.cartItemName,
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
                          onPressed: () => widget.decrementQuantity(),
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
                          "${widget.cartItem.cartItemQuantity}",
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      Transform.scale(
                        scale: 0.6,
                        child: ElevatedButton(
                          onPressed: () => widget.incrementQuantity(),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "₱${widget.cartItem.cartItemGrossTotal.toStringAsFixed(2)}",
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
      ),
    );
  }
}
