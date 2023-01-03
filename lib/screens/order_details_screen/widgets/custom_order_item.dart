import 'package:restaurant/models/order_item_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomOrderItem extends StatefulWidget {
  const CustomOrderItem({Key? key, required this.orderItem}) : super(key: key);

  final OrderItem orderItem;

  @override
  State<CustomOrderItem> createState() => _CustomOrderItemState();
}

class _CustomOrderItemState extends State<CustomOrderItem> {
  @override
  Widget build(BuildContext context) {
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
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: widget.orderItem.orderItemImage.isEmpty
                      ? Image.asset("assets/images/flutter-logo.png")
                      : CachedNetworkImage(
                          imageUrl: widget.orderItem.orderItemImage,
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
                    widget.orderItem.orderItemName,
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
                Container(
                  width: 20.w,
                  alignment: Alignment.center,
                  child: Text(
                    "${widget.orderItem.orderItemQuantity}",
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                Text(
                  "₱${widget.orderItem.orderItemGrossTotal.toStringAsFixed(2)}",
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
  }
}
