import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:screen_split/controllers/favorites_controller.dart';
import 'package:screen_split/controllers/main_controller.dart';
import 'package:screen_split/controllers/toolbar_controller.dart';
import 'package:screen_split/pages/choose_screen.dart';
import 'package:screen_split/theme/text_theme.dart';
import 'package:screen_split/widgets/main_favorites.dart';

class Favorites extends StatelessWidget {
  Favorites({Key? key}) : super(key: key);

  final MainController mainController = Get.find(tag: 'main');
  final FavoritesController favoritesController = Get.find(tag: 'favorites');

  Widget _favorites(Map favorite) {
    return InkWell(
      onTap: (){
        Get.back();
        mainController.choosingUrl(favorite['url']);
        mainController.isTapFavorite(true);
      },
      child: Container(
          width: 74.w,
          height: 74.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              favorite['isExistSvg']
                ? SvgPicture.asset(
                  'assets/logos/${favorite['name']}.svg',
                  height: 40.h,
                  width: 40.w,
                )
                : Image(
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/logos/web.png',
                        height: 40.h,
                        width: 40.w,
                      );
                    },
                    image: NetworkImage(
                      favorite['favicon'],
                    ),
                    height: 40.h,
                    width: 40.w,
                ),
              Center(
                child: Text(
                    favorite['name'][0].toUpperCase() + favorite['name'].substring(1),
                    style: font12,
                    textAlign: TextAlign.center
                ),
              ),
            ],
          ),
      ),
    );
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
                'Choose which site  to open',
                textAlign: TextAlign.center,
                style: font16.copyWith(color: Color(0xffADADAD)),
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(() => Wrap(
                  runSpacing: 14.h,
                  spacing: 14.w,
                  children: [
                    for (var favorite in favoritesController.favorites)
                      _favorites(favorite),
                  ]
              ),)
            ],
          ),
        ),
      )
    );
  }

}