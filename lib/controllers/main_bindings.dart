import 'package:get/get.dart';
import 'package:screen_split/controllers/favorites_controller.dart';
import 'package:screen_split/controllers/main_controller.dart';
import 'package:screen_split/controllers/password_controller.dart';
import 'package:screen_split/controllers/toolbar_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController(), tag: 'main');
    Get.put<ToolbarController>(ToolbarController(), tag: 'toolbar');
    Get.put<PasswordController>(PasswordController(), tag: 'password');
    Get.put<FavoritesController>(FavoritesController(), tag: 'favorites');
  }
}