import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:restaurant/screens/order_details_screen/order_details_screen_view.dart';

class OrderHistoryScreenView extends StatefulWidget {
  const OrderHistoryScreenView({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreenView> createState() => _OrderHistoryScreenViewState();
}

class _OrderHistoryScreenViewState extends State<OrderHistoryScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 7,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderDetailsScreenView(),
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
                        children: const [
                          Text("Order Number"),
                          Text("December 3, 2022"),
                        ],
                      ),
                      const Text("Completed"),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
