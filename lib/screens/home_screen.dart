import 'package:ct484_project/models/product_model.dart';
import 'package:ct484_project/providers/cart_provider.dart';
import 'package:ct484_project/providers/product_provider.dart';
import 'package:ct484_project/screens/details_product.dart';
import 'package:ct484_project/widgets/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ProductProvider>().getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        final products = provider.productListPopular;
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text(
              'Book Shop',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: IconButton(
                  onPressed: () {
                    Get.to(() => const CartScreen());
                  },
                  icon: Consumer<CartProvider>(
                      builder: (context, provider, child) {
                    return Badge.count(
                      count: provider.cartList.length,
                      child: const Icon(Icons.shopping_bag_outlined),
                    );
                  }),
                ),
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverAppBar(
                  expandedHeight: 220,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/book.jpg'),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '"There is no friend as loyal as a book"',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                sliver: SliverToBoxAdapter(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextButton(onPressed: () {}, child: const Text('View All'))
                      ],
                    ),
                  ),
                ),
              ),
              SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 300,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ItemBook(
                      product: products[index],
                    );
                  }),
            ],
          ),
        );
      },
    );
  }
}

class ItemBook extends StatelessWidget {
  final ProductModel product;
  const ItemBook({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailProduct(product));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.productImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/book.jpg', fit: BoxFit.cover),
                ),
              ),
            ),
            Text(
              product.productName,
              maxLines: 1,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text("Price: ${product.productPrice}\$",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
