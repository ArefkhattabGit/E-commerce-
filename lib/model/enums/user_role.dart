enum UserRole {
  admin,
  seller,
  user;

  static UserRole? fromString(String? value) {
    switch (value) {
      case 'admin':
        return UserRole.admin;
      case 'seller':
        return UserRole.seller;
      case 'user':
        return UserRole.user;
      default:
    }
  }
}
