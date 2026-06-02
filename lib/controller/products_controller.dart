import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:product_catalog_application/data/api/api_checker.dart';
import 'package:product_catalog_application/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/response/products_model.dart';
import '../data/model/response/response_model.dart';
import '../data/repository/products_repo.dart';

class ProductsController extends GetxController implements GetxService {
  final ProductsRepo productsRepo;
  final SharedPreferences sharedPreferences;
  ProductsController({
    required this.productsRepo,
    required this.sharedPreferences,
  });

  // List of products
  List<ProductsModel> _productsList = [];
  List<ProductsModel> get productsList => _productsList;

  // Text editing controller
  TextEditingController searchController = TextEditingController();

  bool _isProductsLoading = false;
  bool get isProductsLoading => _isProductsLoading;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
    getProductsList();
  }

  // Get products list
  Future<ResponseModel> getProductsList() async {
    _isProductsLoading = true;
    _filteredList = [];
    _productsList = [];

    update(); // optional loading UI update

    final response = await productsRepo.getProductsList();

    ResponseModel responseModel;

    if (response.statusCode == 200) {
      debugPrint("Products response: ${response.body}");
      response.body.forEach((product) {
        _productsList.add(ProductsModel.fromJson(product));
      });
      _filteredList = _productsList;
      _isProductsLoading = false;
      update();

      responseModel = ResponseModel(success: true, "success");
    } else {
      _isProductsLoading = false;

      ApiChecker.checkApi(response);

      responseModel = ResponseModel(success: false, "failed");
    }

    return responseModel;
  }

  // Product details

  // Variables
  ProductsModel? _productDetails;
  ProductsModel? get productDetails => _productDetails;

  bool _isProductDetailsLoading = false;
  bool get isProductDetailsLoading => _isProductDetailsLoading;

  Future<ResponseModel> getProductsDetails({required int id}) async {
    _productDetails = null;
    _isProductDetailsLoading = true;
    update();
    final response = await productsRepo.getProductsDetails(id);

    ResponseModel responseModel;

    if (response.statusCode == 200) {
      debugPrint("Products response: ${response.body}");
      _productDetails = ProductsModel.fromJson(response.body);
      _isProductDetailsLoading = false;
      update();

      responseModel = ResponseModel(success: true, "success");
    } else {
      _isProductDetailsLoading = false;

      ApiChecker.checkApi(response);

      responseModel = ResponseModel(success: false, "failed");
    }

    return responseModel;
  }

  // Search products Query

  List<ProductsModel> _filteredList = [];
  List<ProductsModel> get filteredList => _filteredList;

  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredList = _productsList;
    } else {
      _filteredList = _productsList
          .where(
            (product) =>
                product.title!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }

    update();
  }

  // Favorite Products
  List<int> _favoriteIds = [];
  List<int> get favoriteIds => _favoriteIds;

  bool isFavorite(int productId) {
    return _favoriteIds.contains(productId);
  }

  void loadFavorites() {
    final ids =
        sharedPreferences.getStringList(AppConstants.FAVORITE_PRODUCTS) ?? [];

    _favoriteIds = ids.map((e) => int.parse(e)).toList();

    update();
  }

  void toggleFavorite(int productId) {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }

    saveFavorites();
    update();
  }

  void saveFavorites() {
    sharedPreferences.setStringList(
      AppConstants.FAVORITE_PRODUCTS,
      _favoriteIds.map((e) => e.toString()).toList(),
    );
  }

  List<ProductsModel> get favoriteProducts {
    return _productsList
        .where((product) => _favoriteIds.contains(product.id))
        .toList();
  }

  // refresh UI

  bool isError = false;
  String errorMessage = "";

  Future<void> fetchProducts() async {
    try {
      isError = false;
      _isProductsLoading = true;
      update();

      // API call
      await productsRepo.getProductsList();
    } catch (e) {
      isError = true;
      errorMessage = e.toString();
    } finally {
      _isProductsLoading = false;
      update();
    }
  }
}
