import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:screen_split/controllers/main_controller.dart';
import 'package:screen_split/controllers/toolbar_controller.dart';
import 'package:screen_split/pages/choose_screen.dart';
import 'package:screen_split/theme/text_theme.dart';
import 'package:screen_split/widgets/main_favorites.dart';

class Favorites extends StatelessWidget {
  Favorites({Key? key}) : super(key: key);

  final MainController mainController = Get.find(tag: 'main');
  final ToolbarController toolbarController = Get.find(tag: 'toolbar');

  List<String> favorites = [
    'facebook',
    'twitter',
    'youtube',
    'instagram',
    'google',
    'reddit',
    'amazon',
  ];

  Widget _generateItem(double width, double height, String url) {
    return InkWell(
      onTap: (){
        Get.back();
        mainController.choosingUrl('https://$url.com');
        mainController.isTapFavorite(true);
      },
      child: Container(
          width: width,
          height: height,
          decoration: url == 'all'
              ? BoxDecoration(
              color: Color(0xff383838),
              borderRadius: BorderRadius.all(Radius.circular(8.sp))
          )
              : null,
          child: url != 'all'
              ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                'assets/logos/$url.svg',
                // color: Color(0xffBDBDBD),
                height: 40.h,
                width: 40.w,
              ),
              Center(
                child: Text(url[0].toUpperCase() + url.substring(1), style: font12),
              ),
            ],
          )
              : Center(
            child: Text('Show all favorites', textAlign: TextAlign.center, style: font12),
          )
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff252525),
      appBar: AppBar(
        title: Text('Favorites', style: font28),
        backgroundColor: Color(0xff252525),
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(20.sp),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: SvgPicture.asset(
              'assets/icons/chevron_left.svg',
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16.w, top: 36.h, right: 16.h),
          width: 1.sw,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Choose whitch site to open',
                textAlign: TextAlign.center,
                style: font16.copyWith(color: Color(0xffADADAD)),
              ),
              SizedBox(
                height: 20.h,
              ),
              Wrap(
                  runSpacing: 14.h,
                  spacing: 14.w,
                  children: _generateChildren(35)
              ),
            ],
          ),
        ),
      )
    );
  }

}