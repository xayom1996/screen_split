import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screen_split/controllers/main_controller.dart';
import 'package:screen_split/controllers/toolbar_controller.dart';

class MainFavorites extends StatelessWidget{
  final int id;
  MainFavorites({Key? key, required this.id}) : super(key: key);

  final MainController mainController = Get.find(tag: 'main');
  final ToolbarController toolbarController = Get.find(tag: 'toolbar');

  Widget _generateItem(double width, double height, String url) {
    return InkWell(
      onTap: (){
        mainController.changeUrl(id, 'https://$url.com');
        toolbarController.changeStatus(false);
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
          color: Colors.pink,
        ),
        child: Center(
          child: Text(url, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  List<Widget> _generateChildren(int count) {
    List<Widget> items = [];

    for (int i = 0; i < favorites.length; i++) {
      items.add(_generateItem(74.w, 74.h, favorites[i]));
    }

    return items;
  }

  List<String> favorites = [
    'facebook',
    'twitter',
    'youtube',
    'instagram',
    'google',
    'reddit',
    'amazon',
    'all',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, top: 36.h, right: 16.h),
      color: const Color(0xff252525),
      width: 1.sw,
      child: Wrap(
        runSpacing: 14.h,
        spacing: 16.w,
        alignment: WrapAlignment.spaceAround,
        children: _generateChildren(8)
      ),
    );
  }
}