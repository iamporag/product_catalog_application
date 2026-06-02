import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/products_controller.dart';
import '../../../helper/route_helper.dart';
import '../../../theme/light_theme.dart';
import '../../../util/dimensions.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_media_box.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Favorites"),

      body: GetBuilder<ProductsController>(
        builder: (controller) {
          if (controller.favoriteProducts.isEmpty) {
            return const Center(child: Text("No Favorite Products"));
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

              return GestureDetector(
                onTap: () => Get.toNamed(
                  RouteHelper.getProductDetailsRoute(product.id!),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.cardColor,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IMAGE + BADGE
                      Expanded(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                              ),
                              child: CustomMediaBox(
                                padding: EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_SMALL,
                                ),
                                networkUrl: product.image,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),

                            // CATEGORY BADGE
                            Positioned(
                              bottom: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  product.category ?? "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),

                            // FAVORITE ICON
                            GetBuilder<ProductsController>(
                              builder: (controller) {
                                return Positioned(
                                  top: 8,
                                  right: 8,
                                  child: InkWell(
                                    onTap: () {
                                      controller.toggleFavorite(product.id!);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        controller.isFavorite(product.id!)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color:
                                            controller.isFavorite(product.id!)
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      // DETAILS
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                height: 1.3,
                              ),
                            ),

                            const SizedBox(height: 6),

                            // PRICE + RATING ROW
                            Row(
                              children: [
                                Text(
                                  "\$${product.price}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),

                                const Spacer(),

                                const Icon(
                                  Icons.star,
                                  size: 14,
                                  color: Colors.orange,
                                ),

                                const SizedBox(width: 2),

                                Text(
                                  "${product.rating?.rate ?? 0}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
