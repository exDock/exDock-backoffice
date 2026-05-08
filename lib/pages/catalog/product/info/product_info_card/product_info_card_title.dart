// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/catalog/product/info/product_info_card/product_info_card.dart';

class ProductInfoCardTitle extends StatelessWidget {
  const ProductInfoCardTitle({
    super.key,
    this.width = double.infinity,
    required this.title,
    required this.unsavedChangesNotifier,
    required this.child,
  });

  final double width;
  final String title;
  final ValueNotifier<bool> unsavedChangesNotifier;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProductInfoCard(
      width: width,
      unsavedChangesNotifier: unsavedChangesNotifier,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
