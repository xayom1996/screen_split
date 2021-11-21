import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PasswordController extends GetxController{
  RxString password = ''.obs;
  RxBool isSnackBarShowed = false.obs;
  RxString snackBarTitle = ''.obs;

  @override
  void onInit() {
    getPasswordFromBox();
    super.onInit();
  }

  void getPasswordFromBox() async{
    var box = await Hive.openBox('myBox');
    var _password = box.get('password');
    if (_password != null) {
      password(_password);
    }
  }

  void changePassword(String newPassword) async{
    password(newPassword);
    var box = await Hive.openBox('myBox');
    box.put('password', newPassword);
  }

  void showSnackbar(String title){
    isSnackBarShowed(true);
    snackBarTitle(title);
    Future.delayed(const Duration(milliseconds: 2500), () {
      isSnackBarShowed(false);
      snackBarTitle('');
    });
  }
}