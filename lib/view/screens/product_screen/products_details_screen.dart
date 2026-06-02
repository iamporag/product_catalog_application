import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_catalog_application/theme/light_theme.dart';
import 'package:product_catalog_application/util/dimensions.dart';
import 'package:product_catalog_application/view/base/custom_app_bar.dart';
import 'package:product_catalog_application/view/base/custom_button.dart';
import 'package:product_catalog_application/view/base/custom_media_box.dart';
import 'package:product_catalog_application/view/base/custom_snackbar.dart';

import '../../../controller/products_controller.dart';

class ProductsDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductsDetailsScreen({super.key, required this.productId});

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Get.find<ProductsController>().getProductsDetails(id: widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(title: "Product Details"),

      body: GetBuilder<ProductsController>(
        builder: (controller) {
          if (controller.isProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final product = controller.productDetails;

          if (product == null) {
            return const Center(child: Text("Product not found"));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                vertical: Dimensions.PADDING_SIZE_SMALL,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 320,
                    width: double.infinity,
                    child: CustomMediaBox(
                      padding: const EdgeInsets.all(
                        Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      networkUrl: product.image,
                      fit: BoxFit.contain,
                      enableZoom: true,
                    ),
                  ),
                  SizedBox(height: Dimensions.FREE_SIZE_DEFAULT),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.category ?? "",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: Dimensions.FREE_SIZE_SMALL),

                      Text(
                        product.title ?? "",
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                        ),
                      ),
                      const SizedBox(height: Dimensions.FREE_SIZE_SMALL),

                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColor.ratingColor,
                            size: 20,
                          ),

                          const SizedBox(width: Dimensions.FREE_SIZE_SMALL),

                          Text(
                            "${product.rating?.rate ?? 0}",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColor.bodyColor,
                            ),
                          ),

                          Text(
                            "(${product.rating?.count ?? 0} reviews)",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColor.bodyColor,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: Dimensions.FREE_SIZE_SMALL),

                      Text(
                        "\$${product.price}",
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: theme.primaryColor,
                        ),
                      ),

                      const SizedBox(height: 24),

                      Text(
                        "Description",
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                        ),
                      ),

                      const SizedBox(height: Dimensions.FREE_SIZE_DEFAULT),

                      Text(
                        product.description ?? "",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: Dimensions.FONT_SIZE_SMALL,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: CustomButton(
          onPressed: () {
            showCustomSnackBar(isError: false, "Product Added");
          },
          buttonText: "Add To Cart",
        ),
      ),
    );
  }
}
