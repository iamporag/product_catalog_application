import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_catalog_application/view/base/custom_button.dart';
import '../../../controller/products_controller.dart';
import '../../../helper/route_helper.dart';
import '../../../theme/light_theme.dart';
import '../../../util/dimensions.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_text_field.dart';
import 'widgets/custom_product_card.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Product Catalog",
        isBackButtonExist: false,
        actions: [
          GetBuilder<ProductsController>(
            builder: (controller) {
              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.toNamed(RouteHelper.getFavoriteRoute());
                    },
                    icon: const Icon(Icons.favorite, color: Colors.white),
                  ),

                  if (controller.favoriteProducts.isNotEmpty)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.error,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          controller.favoriteProducts.length.toString(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColor.cardColor,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: GetBuilder<ProductsController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchProducts();
            },
            child: Column(
              children: [
                // FIXED TOP SEARCH
                Padding(
                  padding: const EdgeInsets.all(
                    Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  child: CustomTextField(
                    controller: controller.searchController,
                    onChanged: controller.searchProducts,
                    hintText: "Search products...",
                    prefixIcon: Icons.search,
                    isEnabled: true,
                    inputAction: TextInputAction.search,
                  ),
                ),

                // GRID RESULT
                Expanded(
                  child: controller.isProductsLoading
                      ? const Center(child: CircularProgressIndicator())
                      : controller.isError
                      ? _buildErrorState(controller)
                      : controller.filteredList.isEmpty
                      ? _buildEmptyState(theme)
                      : GridView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: controller.filteredList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 14,
                                crossAxisSpacing: 14,
                                childAspectRatio: 0.62,
                              ),
                          itemBuilder: (context, index) {
                            final product = controller.filteredList[index];

                            return CustomProductCard(
                              product: product,
                              theme: theme,
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _buildErrorState(ProductsController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 70,
            color: AppColor.discountColor,
          ),
          const SizedBox(height: Dimensions.FREE_SIZE_DEFAULT),
          const Text("Something went wrong"),
          const SizedBox(height: Dimensions.FREE_SIZE_SMALL),
          Text(
            controller.errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: Dimensions.FREE_SIZE_LARGE),

          CustomButton(
            onPressed: () {
              controller.fetchProducts();
            },
            buttonText: "Retry",
          ),
        ],
      ),
    ),
  );
}

Widget _buildEmptyState(ThemeData theme) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.search_off_rounded, size: 80, color: Colors.grey.shade400),
        const SizedBox(height: 16),
        Text(
          "No products found",
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Try searching with different keywords",
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall,
        ),
      ],
    ),
  );
}
