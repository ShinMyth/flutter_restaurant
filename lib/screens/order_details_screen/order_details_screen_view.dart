import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderDetailsScreenView extends StatefulWidget {
  const OrderDetailsScreenView({Key? key}) : super(key: key);

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
      body: Padding(
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
                      "Order Number",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      "December 3, 2022",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Completed",
                  style: TextStyle(
                    color: Colors.green,
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
              itemCount: 2,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20.w,
                          width: 20.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset("assets/images/flutter-logo.png"),
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          "Menu Item",
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "₱ 100.00",
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
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
                  "₱ 200.00",
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
                  "₱ 200.00",
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
    );
  }
}
