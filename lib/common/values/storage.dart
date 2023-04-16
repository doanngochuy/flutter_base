class AppStorage {
  AppStorage._();

  static const String storageDeviceFirstOpen = 'device_first_open';

  static const String storageIndexNewsCache = 'cache_index_news';
  static const String storageHostName = 'host_name';

  static const String storageLanguage = 'language_code';

  static const String storageLatestSync = 'latest_sync';
  static const String storageSessionId = 'session_id';

  static const String storageUserProfile = 'user_profile';

  static const String accessToken = 'access_token';

  static const String storageUser = 'user';

  static const String storageTypeLogin = 'type_login';

  static const provinces = [
    "An Giang",
    "Bà rịa – Vũng tàu",
    "Bắc Giang",
    "Bắc Kạn",
    "Bạc Liêu",
    "Bắc Ninh",
    "Bến Tre",
    "Bình Định",
    "Bình Dương",
    "Bình Phước",
    "Bình Thuận",
    "Cà Mau",
    "Cần Thơ",
    "Cao Bằng",
    "Đà Nẵng",
    "Đắk Lắk",
    "Đắk Nông",
    "Điện Biên",
    "Đồng Nai",
    "Đồng Tháp",
    "Gia Lai",
    "Hà Giang",
    "Hà Nam",
    "Hà Nội",
    "Hà Tĩnh",
    "Hải Dương",
    "Hải Phòng",
    "Hậu Giang",
    "Hòa Bình",
    "Hưng Yên",
    "Khánh Hòa",
    "Kiên Giang",
    "Kon Tum",
    "Lai Châu",
    "Lâm Đồng",
    "Lạng Sơn",
    "Lào Cai",
    "Long An",
    "Nam Định",
    "Nghệ An",
    "Ninh Bình",
    "Ninh Thuận",
    "Phú Thọ",
    "Phú Yên",
    "Quảng Bình",
    "Quảng Nam",
    "Quảng Ngãi",
    "Quảng Ninh",
    "Quảng Trị",
    "Sóc Trăng",
    "Sơn La",
    "Tây Ninh",
    "Thái Bình",
    "Thái Nguyên",
    "Thanh Hóa",
    "Thừa Thiên Huế",
    "Tiền Giang",
    "Thành phố Hồ Chí Minh",
    "Trà Vinh",
    "Tuyên Quang",
    "Vĩnh Long",
    "Vĩnh Phúc",
    "Yên Bái",
  ];

  // Local Setting Data
  static const $prefLocalConfigStore = "local_config_s";

// VN PAY
  static const $prefLayoutQrCode = "pref_setting_pay_qr_code";
  static const prefActiveQrCode = "pref_active_qr_code";
  static const prefWithdrawMethod = "pref_withdraw_method";
  static const prefNameBank = "pref_name_bank";
  static const prefNameAcc = "pref_name_acc";
  static const prefNumberAcc = "pref_number_acc";
  static const $prefMerchantCategoryCode = "pref_merchant_category_code";

// NOTIFICATION
  static const $prefLayoutNotificationRing = "pref_notifications";
  static const $prefNotificationsPay = "pref_notifications_pay";

}
