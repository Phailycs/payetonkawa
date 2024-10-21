import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payetonkawa/Entities/productsEntity.dart';
import 'package:payetonkawa/View/view_ProductDetail.dart';
import 'package:payetonkawa/Controller/Get_ProductList.dart';

class ProductListView extends StatefulWidget {
  @override
  ProductView createState() => ProductView();
}

class ProductView extends State<ProductListView> {
  late Future<List<ProductEntity>> _ProductsList;

  @override
  void initState() {
    super.initState();

    _ProductsList = GetProductList().fetchApiData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
          fontFamily: 'Montserrat',
        ),
        home: Scaffold(
          appBar: AppBar(title: const Text("Liste des produits")),
          body: FutureBuilder(
            future: _ProductsList,
            builder: (BuildContext context,
                AsyncSnapshot<List<ProductEntity>> snapshot) {
              if (snapshot.hasData) {
                final products = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = products[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text("Prix: ${product.details.price}"),
                      trailing: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: product.stock > 0 ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          product.stock > 0 ? "En stock" : "Hors stock",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(product: product),
                          ),
                        );
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
          }
        },
      ),
    ));
  }
}
