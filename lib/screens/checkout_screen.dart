import 'package:ct484_project/providers/cart_provider.dart';
import 'package:ct484_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final addressController = TextEditingController();

  final provinceController = TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    nameController.text = context.read<UserProvider>().user?.userName ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _keyForm,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(labelText: 'Firts and last name'),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'name is required';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: phoneController,
                      decoration:
                          const InputDecoration(labelText: 'Number phone'),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'phone is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'address is required';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: provinceController,
                      decoration:
                          const InputDecoration(labelText: 'Province/City'),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'province/city is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.location_on_rounded),
                          SizedBox(width: 8.0),
                          Text('Payment : '),
                          Text('Cash on delivery (Default)'),
                          Spacer(),
                          Icon(Icons.check, color: Colors.green),
                        ],
                      ),
                    ),
                  ),
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.local_shipping_rounded),
                          SizedBox(width: 8.0),
                          Text('Shipping : '),
                          Text('Free'),
                          Spacer(),
                          Icon(Icons.check, color: Colors.green),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Order: ',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '${provider.totalPrice}\$',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    if (!_keyForm.currentState!.validate()) {
                      return;
                    }

                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Confirm order'),
                        content: const Text(
                          'Please confirm your order by clicking on the button below',
                        ),
                        actions: [
                          OutlinedButton(
                              onPressed: () => Get.back(),
                              child: const Text('Cancel')),
                          OutlinedButton(
                            onPressed: () async {
                              final result = await Get.showOverlay(
                                asyncFunction: () => provider.addOrder(
                                  name: nameController.text,
                                  numberPhone: phoneController.text,
                                  address: addressController.text,
                                  provinceCity: provinceController.text,
                                ),
                                loadingWidget: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );

                              if (result == true) {
                                Get.snackbar('Order Placed',
                                    'Your order has been placed');
                                Navigator.popUntil(
                                  context,
                                  (route) => route.isFirst,
                                );
                              } else {
                                Get.snackbar(
                                    'Order Failed', 'Please add item to cart');
                              }
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Checkout'),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
