import 'package:restaurant/models/order_model.dart';
import 'package:restaurant/screens/order_details_screen/widgets/custom_order_item.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreenView extends StatefulWidget {
  const OrderDetailsScreenView({Key? key, required this.order})
      : super(key: key);

  final Order order;

  @override
  State<OrderDetailsScreenView> createState() => _OrderDetailsScreenViewState();
}

class _OrderDetailsScreenViewState extends State<OrderDetailsScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              Row(
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
              SizedBox(height: 2.h),
              const Divider(),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget.order.orderItems.length,
                itemBuilder: (context, index) {
                  return CustomOrderItem(
                      orderItem: widget.order.orderItems[index]);
                },
              ),
              const Divider(),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Subtotal",
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    "₱${widget.order.orderSubtotal}",
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "₱${widget.order.orderTotal}",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
