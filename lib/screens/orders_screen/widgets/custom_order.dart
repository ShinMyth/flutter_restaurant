import 'package:restaurant/models/order_model.dart';
import 'package:restaurant/screens/order_details_screen/order_details_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

class CustomOrder extends StatefulWidget {
  const CustomOrder({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  State<CustomOrder> createState() => _CustomOrderState();
}

class _CustomOrderState extends State<CustomOrder> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsScreenView(
              order: widget.order,
            ),
          ),
        );
      },
      child: Card(
        child: Container(
          height: 20.w,
          padding: EdgeInsets.all(3.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.order.orderID,
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    DateFormat('MMMM dd, yyyy')
                        .format(DateTime.parse(widget.order.orderDateTime)),
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
              Text(
                widget.order.orderStatus,
                style: TextStyle(
                  color: widget.order.orderStatus == "Completed"
                      ? Colors.green
                      : Colors.red,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
