// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/catalog/category/category_blocks/category_products_block/category_product_card/category_product_card_synchronous.dart';

class CategoryProductCard extends StatefulWidget {
  const CategoryProductCard({
    super.key,
    required this.id,
    this.height,
    required this.width,
  });

  final int id;
  final double? height;
  final double width;

  @override
  State<CategoryProductCard> createState() => _CategoryProductCardState();
}

class _CategoryProductCardState extends State<CategoryProductCard> {
  @override
  Widget build(BuildContext context) {
    // TODO: make data retrieval asynchronous
    return CategoryProductCardSynchronous(
      height: widget.height,
      width: widget.width,
      productName: "productName [${widget.id}]",
      sku: "[sku]",
      imageUrl: "https://picsum.photos/200/300?random=${widget.id}",
      price: 150,
      salePrice: 12.95,
      stock: 12,
    );
  }
}
