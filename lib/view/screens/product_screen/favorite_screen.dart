import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_catalog_application/view/screens/product_screen/widgets/custom_product_card.dart';

import '../../../controller/products_controller.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_empty_state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(title: "Favorites"),

      body: GetBuilder<ProductsController>(
        builder: (controller) {
          if (controller.favoriteProducts.isEmpty) {
            return const CustomEmptyState(
              title: "No Data Available",
              subtitle: "Please check again later",
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.favoriteProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.62,
            ),
            itemBuilder: (context, index) {
              final product = controller.favoriteProducts[index];

              return CustomProductCard(product: product, theme: theme);
            },
          );
        },
      ),
    );
  }
}
