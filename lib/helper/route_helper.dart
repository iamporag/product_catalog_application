import 'package:get/get.dart';
import 'package:product_catalog_application/view/screens/product_screen/products_details_screen.dart';

import '../view/screens/product_screen/favorite_screen.dart';
import '../view/screens/product_screen/products_screen.dart';

class RouteHelper {
  static const String productScreen = '/product-screen';
  static const String productDetailScreen = '/product-details';
  static const String favorite = '/favorite';
  static String getProductsRoute() => productScreen;
  static String getProductDetailsRoute(int id) => '$productDetailScreen?id=$id';
  static String getFavoriteRoute() => favorite;

  static List<GetPage> routes = [
    GetPage(name: productScreen, page: () => const ProductsScreen()),
    GetPage(
      name: productDetailScreen,
      page: () =>
          ProductsDetailsScreen(productId: int.parse(Get.parameters['id']!)),
    ),
    GetPage(name: favorite, page: () => FavoriteScreen()),
  ];
}
