// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/styling.dart';
import 'package:exdock_backoffice/pages/catalog/category/category_blocks/category_products_block/category_product_card/category_product_card_price.dart';
import 'package:exdock_backoffice/pages/catalog/category/category_blocks/category_products_block/category_product_card/category_product_card_stock_overlay.dart';
import 'package:exdock_backoffice/widgets/buttons/exdock_copy_button.dart';

class CategoryProductCardSynchronous extends StatelessWidget {
  const CategoryProductCardSynchronous({
    super.key,
    required this.height,
    required this.width,
    required this.productName,
    required this.sku,
    required this.imageUrl,
    required this.price,
    this.salePrice,
    required this.stock,
  });

  final double? height;
  final double width;
  final String productName;
  final String sku;
  final String imageUrl;
  final double price;
  final double? salePrice;
  final int stock;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: kBoxShadowList,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: Text(
                  productName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Text(sku),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ExdockCopyButton(
                            textToCopy: sku,
                            width: 14,
                            height: 14,
                            iconSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                  CategoryProductCardPrice(
                    price: price,
                    salePrice: salePrice,
                  ),
                ],
              ),
            ],
          ),
          CategoryProductCardStockOverlay(stock: stock, height: 36),
        ],
      ),
    );
  }
}
