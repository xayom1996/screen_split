import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screen_split/controllers/main_controller.dart';
import 'package:screen_split/theme/text_theme.dart';

class CustomSnackbar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find(tag: 'main');

    return Container(
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: const Color(0xff383838).withOpacity(0.9),
        borderRadius: BorderRadius.all(Radius.circular(8.sp))
      ),
      child: Center(
        child: Text(mainController.snackBarTitle.value, style: font16,),
      ),
    );
  }

}