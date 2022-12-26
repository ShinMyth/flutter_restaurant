import 'package:restaurant/screens/orders_screen/widgets/custom_order.dart';
import 'package:restaurant/screens/orders_screen/orders_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrdersScreenView extends StatefulWidget {
  const OrdersScreenView({Key? key}) : super(key: key);

  @override
  State<OrdersScreenView> createState() => _OrdersScreenViewState();
}

class _OrdersScreenViewState extends State<OrdersScreenView> {
  late OrdersScreenController controller;

  @override
  void initState() {
    controller = OrdersScreenController(
      setstate: () => setState(() {}),
      context: context,
    );

    controller.getOrdersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
      ),
      body: controller.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : controller.orders.isEmpty
              ? const Center(
                  child: Text("Orders Empty"),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.orders.length,
                    itemBuilder: (context, index) {
                      return CustomOrder(order: controller.orders[index]);
                    },
                  ),
                ),
    );
  }
}
