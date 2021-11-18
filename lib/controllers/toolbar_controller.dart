import 'package:get/get.dart';

class ToolbarController extends GetxController{
  RxBool isOpen = false.obs;

  void clickedToolbarButton(){
    isOpen(!isOpen.value);
  }

  void changeStatus(bool status){
    isOpen(status);
  }
}