import 'package:ct484_project/models/product_model.dart';
import 'package:ct484_project/providers/cart_provider.dart';
import 'package:ct484_project/widgets/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DetailProduct extends StatelessWidget {
  final ProductModel product;
  const DetailProduct(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Consumer<CartProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => const CartScreen());
              },
              icon: Consumer<CartProvider>(builder: (context, provider, child) {
                return Badge.count(
                    count: provider.cartList.length,
                    child: const Icon(Icons.shopping_bag_outlined));
              }),
            )
          ],
        ),
        backgroundColor: Colors.orange,
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: height * 0.3),
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 25, left: 15, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: const TextStyle(color: Colors.white, fontSize: 26),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Price',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Rs. ${product.productPrice}',
                            style: const TextStyle(
                                fontSize: 25, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 240,
                        width: 240,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            product.productImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.productDetails,
                            style: const TextStyle(fontSize: 17),
                          ),
                          Text(
                            'Category: ${product.category}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  )
                ],
              ),
            ),
            Positioned(
              right: 16.0,
              left: 16.0,
              bottom: 16.0,
              child: Consumer(builder: (context, ref, child) {
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Consumer<CartProvider>(builder: (context, ref, child) {
                    return ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async {
                          await provider.addToCart(
                            product.productId!,
                            product.productPrice,
                            1,
                            (product.productPrice).toString(),
                            product.productName,
                            product.productImage,
                          );
                        },
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text(
                          'Add to Cart',
                        ));
                  }),
                );
              }),
            )
          ],
        ),
      );
    });
  }
}
