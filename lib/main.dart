import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/theme_controller.dart';
import 'helper/get_di.dart' as di;
import 'helper/route_helper.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';
import 'util/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          title: AppConstants.APP_NAME,
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          theme: themeController.darkTheme ? dark : light,
          initialRoute: RouteHelper.getProductsRoute(),
          getPages: RouteHelper.routes,
          defaultTransition: Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        );
      },
    );
  }
}
