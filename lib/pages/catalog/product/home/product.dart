// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:exdock_backoffice/utils/HTTP/get_request.dart';
import 'package:exdock_backoffice/utils/HTTP/http_data.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/catalog/product/home/product_data.dart';
import 'package:exdock_backoffice/pages/catalog/product/home/product_home_synchronous.dart';

class Product extends StatelessWidget {
  const Product({super.key});

  // Generate random product data
  Future<ProductData> getProductData() async {
    final List<ProductInfo> products = [];
    final Random random = Random();
    for (var i = 0; i < 71; i++) {
      products.add(ProductInfo(
          id: i,
          thumbnail: getRandomString(10),
          name: getRandomString(30),
          price: random.nextDouble() * 100));
    }

    final HttpData response =
        await standardGetRequest('/api/v1/products/overview');
    print("response.responseBody: ${response.responseBody}");

    return ProductData(products: products);
  }

  // Generate random string
  String getRandomString(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final Random rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProductData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          // TODO: handle error
        }
        return ProductHomeSynchronous(
          productData: snapshot.data!,
        );
      },
    );
  }
}
