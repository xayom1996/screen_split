import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:screen_split/controllers/main_controller.dart';
import 'package:screen_split/controllers/toolbar_controller.dart';
import 'package:screen_split/pages/favorites.dart';
import 'package:screen_split/theme/text_theme.dart';

class MainFavorites extends StatelessWidget{
  final int id;
  MainFavorites({Key? key, required this.id}) : super(key: key);

  final MainController mainController = Get.find(tag: 'main');
  final ToolbarController toolbarController = Get.find(tag: 'toolbar');

  Widget _generateItem(double width, double height, String url) {
    return InkWell(
      onTap: (){
        toolbarController.changeStatus(false);
        if (url == 'all') {
          Get.to(Favorites());
        } else
          mainController.changeUrl(id, 'https://$url.com');
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
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
        toolbarController.isOpen(false);
      },
      child: Container(
        padding: EdgeInsets.only(left: 16.w, top: 36.h, right: 16.h),
        color: const Color(0xff252525),
        width: 1.sw,
        height: 1.sh,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onTap: (){
                toolbarController.isOpen(false);
              },
              style: font14.copyWith(
                fontSize: 18.sp,
                color: Color(0xffEBEBF5).withOpacity(0.6),
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffA3A3A7).withOpacity(0.24),
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(15.sp) //                 <--- border radius here
                  ),
                ),
                focusedBorder: new OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(15.sp) //                 <--- border radius here
                  ),
                ),
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 20.sp,
                    color: Color(0xffEBEBF5).withOpacity(0.6),
                  ), onPressed: () {  },
                ),
                contentPadding: EdgeInsets.only(right: 10.w),
                hintText: 'Search',
                hintStyle: font14.copyWith(
                  fontSize: 18.sp,
                  color: Color(0xffEBEBF5).withOpacity(0.6),
                )
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                    runSpacing: 14.w,
                    spacing: 14.h,
                    // alignment: WrapAlignment.spaceAround,
                    children: _generateChildren(8)
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}