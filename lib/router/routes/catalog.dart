// Flutter imports:
// Project imports:
import 'package:exdock_backoffice/pages/catalog/category/category.dart';
import 'package:exdock_backoffice/pages/catalog/product/home/product.dart';
import 'package:exdock_backoffice/pages/catalog/product/info/product_info.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:go_router/go_router.dart';

List<GoRoute> getCatalogRoutes() {
  return [
    GoRoute(
      path: '/catalog',
      builder: (context, state) => const Placeholder(),
    ),
    GoRoute(
      path: '/catalog/product',
      builder: (context, state) => const Product(),
    ),
    GoRoute(
      path: '/catalog/category',
      builder: (context, state) => const Category(),
    ),
    GoRoute(
      path: '/catalog/category/:selectedCategory',
      builder: (context, state) {
        int? categoryId;
        try {
          categoryId = int.parse(state.pathParameters['selectedCategory']!);
        } catch (_) {}
        return Category(
          selectedCategory: categoryId,
        );
      },
    ),
    GoRoute(
      path: '/catalog/product/:selectedProduct',
      builder: (context, state) {
        String? productId;
        try {
          productId = state.pathParameters['selectedProduct'];
        } catch (_) {}
        return ProductInfo(
          productId: productId,
        );
      },
    ),
  ];
}
