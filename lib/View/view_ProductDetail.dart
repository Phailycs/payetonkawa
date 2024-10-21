import 'package:flutter/material.dart';
import 'package:payetonkawa/Entities/productsEntity.dart';
import 'package:payetonkawa/View/view_AugmentedReality.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
          fontFamily: 'Montserrat',
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(product.name),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              Image.asset(
                'assets/logo_payetonkawa.png',
                fit: BoxFit.cover,
                height: 300,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  product.details.description,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AugmentedRealityView(),
                    ),
                  );
                },
                child: const Text(
                  'Réalité augmentée',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Specifications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prix : ${product.details.price}',
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Couleur : ${product.details.color}',
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        product.stock > 0 ? "En stock" : "Hors stock",
                        style: TextStyle(
                          fontSize: 24,
                          color: product.stock > 0 ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed:
                            (product.stock > 0) ? () => print("oui") : null,
                        child: const Text("Commander"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    ));
  }
}
