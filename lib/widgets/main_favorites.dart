import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:screen_split/controllers/favorites_controller.dart';
import 'package:screen_split/controllers/main_controller.dart';
import 'package:screen_split/controllers/toolbar_controller.dart';
import 'package:screen_split/pages/favorites.dart';
import 'package:screen_split/theme/text_theme.dart';

class MainFavorites extends StatelessWidget{
  final int id;
  MainFavorites({Key? key, required this.id}) : super(key: key);

  final MainController mainController = Get.find(tag: 'main');
  final ToolbarController toolbarController = Get.find(tag: 'toolbar');
  final FavoritesController favoritesController = Get.find(tag: 'favorites');

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _searchController.text = favoritesController.searchTexts[id]!.value;

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
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onTap: (){
                toolbarController.isOpen(false);
              },
              onChanged: (txt){
                favoritesController.searchFavorites(id, txt);
              },
              controller: _searchController,
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
                suffixIcon: favoritesController.searchTexts[id]!.value != ''
                    ? IconButton(
                        onPressed: (){
                          favoritesController.searchFavorites(id, '');
                          _searchController.clear();
                        },
                        icon: Icon(
                          Icons.clear,
                          size: 20.sp,
                          color: Color(0xffEBEBF5).withOpacity(0.6),
                        ),
                      )
                    : null,
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
                    children: [
                      if (favoritesController.searchTexts[id]!.isEmpty) ...[
                        for (var favorite in favoritesController.favorites.take(7))
                          _favorites(context, favorite),
                        _showAll(context),
                      ] else ...[
                        for (var favorite in favoritesController.searchedFavorites[id]!)
                          _favorites(context, favorite),
                      ]
                    ]
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),)
      ),
    );
  }

  Widget _showAll(BuildContext context) {
    return InkWell(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
        toolbarController.changeStatus(false);
        Get.to(Favorites());
      },
      child: Container(
          width: 74.w,
          height: 74.h,
          decoration: BoxDecoration(
              color: Color(0xff383838),
              borderRadius: BorderRadius.all(Radius.circular(8.sp))
          ),
          child: Center(
            child: Text('Show all favorites', textAlign: TextAlign.center, style: font12),
          )
      ),
    );
  }

  Widget _favorites(BuildContext context, Map favorite) {
    return InkWell(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
        mainController.changeUrl(id, favorite['url']);
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
}