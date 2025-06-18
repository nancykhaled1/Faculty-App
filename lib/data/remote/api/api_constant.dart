class ApiConstants{
  static const String baseurl = 'smartcollegedmanhour-production.up.railway.app';


  static const String studentRegisterApi = '/users/register/';
  static const String alumniRegisterApi = '/users/graduation/';
  static const String loginApi = '/users/token/';
  static const String depatmentApi = '/academics/departments/';
  static const String studentApi = '/services/section/';
  static const String portalApi = '/studentportal/portal/';
  static String dataApi(int userId) => '/users/graduation/$userId/';
  static const String notificationApi = '/studentportal/mynotifications/';















}