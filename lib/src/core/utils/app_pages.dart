import 'package:get/get.dart';
import 'package:quitanda_app/src/pages/auth/screens/sign_in_screen.dart';
import 'package:quitanda_app/src/pages/auth/screens/sign_up_screen.dart';
import 'package:quitanda_app/src/pages/auth/screens/splash_screen.dart';
import 'package:quitanda_app/src/pages/base/base_screen.dart';
import 'package:quitanda_app/src/pages/base/binding/navigation_binding.dart';
import 'package:quitanda_app/src/pages/cart/binding/cart_binding.dart';
import 'package:quitanda_app/src/pages/home/binding/home_binding.dart';
import 'package:quitanda_app/src/pages/product/screens/product_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(name: PagesRoutes.splashScreen, page: () => const SplashScreen()),
    GetPage(name: PagesRoutes.signIn, page: () => SignInScreen()),
    GetPage(name: PagesRoutes.signUp, page: () => SignUpScreen()),
    GetPage(
      name: PagesRoutes.base,
      page: () => const BaseScreen(),
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        CartBinding(),
      ],
    ),
    GetPage(
      name: PagesRoutes.product,
      page: () => const ProductScreen(),
    ),
  ];
}

abstract class PagesRoutes {
  static const String splashScreen = '/splashscreen';
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String base = '/';
  static const String product = '/product';
}
