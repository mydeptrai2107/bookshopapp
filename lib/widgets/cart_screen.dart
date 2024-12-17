import 'package:ct484_project/providers/cart_provider.dart';
import 'package:ct484_project/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late int count = 0;

  late List<String> itemsToOrder = [];

  bool isBool = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, provider, child) {
      final cartItems = provider.cartList;
      return Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Your Total Order is:',
                      ),
                      Text('Rs.' ' ${provider.totalPrice}\$'),
                    ],
                  ),
                ),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      if (provider.cartList.isNotEmpty) {
                        Get.to(() => const CheckoutScreen());
                      } else {
                        Get.snackbar(
                            'Warning', 'Cart is empty, please add some items');
                      }
                    },
                    child: const Text('Place Order'),
                  ),
                ),
              ],
            ),
          ),
          body: provider.cartList.isEmpty
              ? const Center(
                  child: Text("No data"),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: provider.cartList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 90,
                                      child: Center(
                                        child: Image.network(
                                          cartItems[index].cartImage,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 90,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cartItems[index].cartName,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                '${cartItems[index].totalPrice}\$',
                                                style: const TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Quantity: ${cartItems[index].cartQuantity}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 90,
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: InkWell(
                                          onTap: () async {
                                            await provider.removeCartItem(
                                                cartId:
                                                    cartItems[index].cartId);
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            size: 30,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container()
                          ],
                        ),
                      );
                    },
                  ),
                ));
    });
  }
}
