abstract class AppRoutes {
  AppRoutes._();

  // กำหนดชื่อ routes ทั้งหมด
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const FORGET_PASSWORD = '/forget-password';
  static const HOME = '/home'; // สำหรับในอนาคต
  static const PROFILE = '/profile'; // สำหรับในอนาคต

  // Helper methods สำหรับการนำทาง
  static String getLoginRoute() => LOGIN;
  static String getRegisterRoute() => REGISTER;
  static String getForgetPasswordRoute() => FORGET_PASSWORD;
  static String getHomeRoute() => HOME;
  static String getProfileRoute() => PROFILE;
}
