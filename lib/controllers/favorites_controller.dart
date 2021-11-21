import 'package:get/get.dart';
import 'package:hive/hive.dart';

class FavoritesController extends GetxController{
  RxList<dynamic> favorites = [].obs;
  Map<int, RxList<dynamic>> searchedFavorites = {
    1: [].obs,
    2: [].obs,
  };
  Map<int, RxString> searchTexts = {
    1: ''.obs,
    2: ''.obs,
  };

  List<String> mainFavorites = [
    'facebook',
    'twitter',
    'youtube',
    'instagram',
    'google',
    'reddit',
    'amazon',
  ];

  @override
  void onInit() {
    getFavorites();
    super.onInit();
  }

  void getFavorites() async{
    var box = await Hive.openBox('favoritesBox');
    List _favorites = box.get('favorites') ?? [];

    if (_favorites.isEmpty) {
      /// Add main favorites
      for (var i = 0; i < mainFavorites.length; i++){
        addFavorite('https://${mainFavorites[i]}.com/');
      }
    }
    else {
      favorites(_favorites);
    }
  }

  void addFavorite(String url) async {
    Map favorite = {};
    favorite['url'] = 'https://${url.split('/')[2]}/';
    favorite['favicon'] = favorite['url'] + 'favicon.ico';
    String name = url.split('/')[2].replaceAll('www.', '').split('.')[0];
    if (name.startsWith('m.')) {
      name = name.replaceAll('m.', '');
    }
    favorite['name'] = name;
    favorite['isExistSvg'] = mainFavorites.contains(name);

    favorites.add(favorite);
    favorites.refresh();
    var box = await Hive.openBox('favoritesBox');
    box.put('favorites', favorites);
  }

  void searchFavorites(int id, String searching) async {
    searchTexts[id]!(searching);

    if (searching == '') {
      searchedFavorites[id]!([]);
    }
    else {
      List<dynamic> _favorites = [];
      for (var favorite in favorites) {
        if (favorite['name'].toString().contains(searching)) {
          _favorites.add(favorite);
        }
      }
      searchedFavorites[id]!(_favorites);
    }
  }
}