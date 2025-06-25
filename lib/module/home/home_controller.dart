import 'package:carousel_slider/carousel_controller.dart';
import 'package:final_poject_sw_engineering/model/favorite_model.dart';
import 'package:final_poject_sw_engineering/model/favorites_model.dart';

import '../../api/apiResponse/api_response.dart';
import '../../api/repo/homeRepo/home_repo_Impl.dart';
import '../../base/base_getx_controller.dart';
import '../../model/category_model.dart';
import '../../model/home_model.dart';

class HomeController extends BaseGetxController {
  final HomeRepoImpl homeRepoImpl = HomeRepoImpl();

  CarouselSliderController carouselController = CarouselSliderController();
  int currentIndex = 0;
  List<int> favoriteProductIds = [];

  @override
  void onInit() {
    super.onInit();
    getHomeData();
  }

  final List<String> sliderImage = [
    'assets/images/image_1.jpg',
    'assets/images/image_2.jpg',
    'assets/images/image_3.jpg'
  ];

  BaseApiResponse<HomeModel>? tHome;
  BaseApiResponse<CategoryModel>? tCategory;
   BaseApiResponse<FavoriteModel>? favoriteModel;
  BaseApiResponse<FavoritesModel>? favoritesModel;

  Future<void> getAllProducts() async {
    tHome = await homeRepoImpl.getAllProduct();
  }

  Future<void> getCategories() async {
    tCategory = await homeRepoImpl.getCategories();
  }


  Future<void> getFavorites() async {
    try {
      favoritesModel = await homeRepoImpl.getUserFavorite();

      if (favoritesModel?.data?.data?.favorites != null) {
        favoriteProductIds = favoritesModel!.data!.data!.favorites!
            .map((favorite) => favorite.data!.id!)
            .toList();
      } else {
        favoriteProductIds = [];
      }

    } catch (e) {
      print('Error fetching favorites: $e');
      favoriteProductIds = [];
      favoritesModel = null;
    }
  }


  Future<void> toggleFavoriteStatus(int productId) async {
    final isFavorite = favoriteProductIds.contains(productId);

    isFavorite
        ? favoriteProductIds.remove(productId)
        : favoriteProductIds.add(productId);
    update();

    try {
      isFavorite
          ? await removeProductFromFavorite(productId)
          : await addProductToFavorite(productId);
      await getFavorites();
      update();

      print('product ID $productId ${isFavorite ? "removed" : "added"}');
    } catch (e) {
      // Rollback if failed
      isFavorite
          ? favoriteProductIds.add(productId)
          : favoriteProductIds.remove(productId);
      update();
      print('Failed to ${isFavorite ? "remove" : "add"} favorite: $e');
    }
  }

  addProductToFavorite(int id) async {
    favoriteModel = await homeRepoImpl.postAddToFavorite(id);
  }

  removeProductFromFavorite(int id) async {
    final response = await homeRepoImpl.postRemoveToFavorite(id);
    print(response.message);
  }

  Future<void> getHomeData() async {
    setLoading(true);

    await Future.wait([
      getAllProducts(),
      getFavorites(),
      getCategories(),
    ]);
    setLoading(false);
  }
}
