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
            const Text("Order Number: Order Number"),
            SizedBox(height: 1.5.h),
            const Text("Order Status: Completed"),
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
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: 3.w),
                        const Text("Menu Item"),
                        const Spacer(),
                        const Text("₱ 175.00"),
                      ],
                    ),
                  ),
                );
              },
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Subtotal"),
                Text("₱ 350.00"),
              ],
            ),
            SizedBox(height: 1.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("TOTAL"),
                Text("₱ 350.00"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
