abstract class AdminCategoryRepo {
  Future deleteAdminCategory ({required int id});
  Future postUpdateCategory({required dynamic body,required int categoryId});
}