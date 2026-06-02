import 'package:get/get.dart';
import 'package:product_catalog_application/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_client.dart';

class ProductsRepo {
  // Local veriable
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  // Constructor
  ProductsRepo({required this.apiClient, required this.sharedPreferences});

  // Get products list
  Future<Response> getProductsList() async {
    return await apiClient.getData(AppConstants.PRODUCTS_URI);
  }

  // Get products details
  Future<Response> getProductsDetails(int id) async {
    return await apiClient.getData('${AppConstants.PRODUCTS_URI}/$id');
  }
}
