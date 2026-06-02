import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../controller/products_controller.dart';
import '../controller/theme_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/products_repo.dart';
import '../util/app_constants.dart';

Future<void> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(
    () => ApiClient(
      appBaseUrl: AppConstants.BASE_URL,
      sharedPreferences: Get.find(),
    ),
  );

  // Repository
  Get.lazyPut(
    () => ProductsRepo(apiClient: Get.find(), sharedPreferences: Get.find()),
  );

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(
    () => ProductsController(
      productsRepo: Get.find(),
      sharedPreferences: Get.find(),
    ),
  );
}
