import 'package:final_poject_sw_engineering/api/apiResponse/api_response.dart';
import 'package:final_poject_sw_engineering/model/category_model.dart';
import 'package:final_poject_sw_engineering/model/favorites_model.dart';
import 'package:final_poject_sw_engineering/model/home_model.dart';

import '../../../model/TCategory.dart';
import '../../../model/favorite_model.dart';

abstract class HomeRepo{

  Future<BaseApiResponse<HomeModel>> getAllProduct({required Map<String,dynamic> query});
  Future<BaseApiResponse<CategoryModel>> getCategories();
  Future<BaseApiResponse<TCategory>> getProductByCategoryId(int id);
  Future<BaseApiResponse<FavoriteModel>> postAddToFavorite(int id);
  Future<BaseApiResponse> postRemoveToFavorite(int id);
  Future<BaseApiResponse<FavoritesModel>> getUserFavorite();


}

