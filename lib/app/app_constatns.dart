class AppConstants {
  AppConstants._();

  static const String baseUrl = 'https://nawasrah.site/ecommerce-api/api/v1';
  static const String homeEndpoint = '/front/products';
  static const String addProductsEndpoint = '/products';
  static const String registerEndPoint = '/register';
  static const String loginEndPoint = '/login';
  static const String userProfileEndPoint = '/user-profile';
  static const String updateProfileEndPoint  = '/update-profile';


  static const String categoryEndPoint ='/front/categories';



  static const String productByCategoryEndPoint  = '/front/products/category';

  static const String getAllUsersEndPoint  = '/super-admin/users';

  static const String postChangeUsersStatusEndPoint  = '/super-admin/users/status';

   static const String addRemoveFavoritesEndPoint  = '/favorites';
  static const String complaintEndPoint  = '/complaint';
  static const String addCategoriesEndPoint  = '/categories';



  static const int connectionTimeout = 60;

  /// ShearedPreferences

  static const String USER_TOKEN = 'USER_TOKEN';
  static const String USER_ROLE = 'USER_ROLE';
  static const IS_GUEST = 'IS_GUEST';


}
