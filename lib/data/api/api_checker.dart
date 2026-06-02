import 'package:get/get.dart';

import '../../view/base/custom_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response) {
    String message = 'Something went wrong';

    if (response.body is Map && response.body['message'] != null) {
      message = response.body['message'].toString();
    } else if (response.statusText != null && response.statusText!.isNotEmpty) {
      message = response.statusText!;
    }

    switch (response.statusCode) {
      case 400:
        showCustomSnackBar(message);
        break;

      case 401:
        showCustomSnackBar("Session expired. Please login again.");

        // logout + redirect
        break;

      case 403:
        showCustomSnackBar(
          "You don't have permission to access this resource.",
        );
        break;

      case 404:
        showCustomSnackBar("Requested resource not found.");
        break;

      case 500:
        showCustomSnackBar("Internal server error.");
        break;

      default:
        showCustomSnackBar(message);
    }
  }
}
