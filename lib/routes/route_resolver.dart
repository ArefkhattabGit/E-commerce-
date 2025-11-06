import '../model/enums/user_role.dart';
import 'app_routes.dart';

class RouteResolver {
  RouteResolver._();

  static String? resolveInitial(String? token, String? userRole) {
    if (token == null) return AppRoutes.loginScreen;

    final role = UserRole.fromString(userRole);

    if (role == UserRole.admin) return AppRoutes.adminDashboardScreen;
    if (role == UserRole.seller) return AppRoutes.sellerDashboard;

   }
}
