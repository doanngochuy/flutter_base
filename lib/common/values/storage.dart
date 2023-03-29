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
  static const $prefActiveQrCode = "pref_active_qr_code";
  static const $prefConnectPos = "pref_connect_pos";
  static const $prefPrintBeforeSuccessPayment = "pref_print_before_successful_payment";
  static const $prefMerchantCode = "pref_merchant_code";
  static const $prefMerchantName = "pref_merchant_name";
  static const $prefMerchantCategoryCode = "pref_merchant_category_code";

//VIETTEL PAY
  static const $prefPayment = "pref_payment";
  static const $prefMerchantCodeVT = "pref_merchant_code_vt";
  static const $prefMerchantNameVT = "pref_merchant_name_vt";

// NOTIFICATION
  static const $prefLayoutNotificationRing = "pref_notifications";
  static const $prefNotificationsPay = "pref_notifications_pay";

// SYNC GATEWAY
  static const $prefLayoutSyncGateway = "pref_sync_gateway";
  static const $prefTypeSyncGateway = "pref_type_sync_gateway";

// PRINT
  static const $prefPrintTypeCashier = "pref_print_type_cashier";
  static const $prefPrintTypeKitchenA = "pref_print_type_kitchen_a";
  static const $prefPrintTypeKitchenB = "pref_print_type_kitchen_b";
  static const $prefPrintTypeKitchenC = "pref_print_type_kitchen_c";
  static const $prefPrintTypeKitchenD = "pref_print_type_kitchen_d";
  static const $prefPrintTypeBartenderA = "pref_print_type_bartender_a";
  static const $prefPrintTypeBartenderB = "pref_print_type_bartender_b";
  static const $prefPrintTypeBartenderC = "pref_print_type_bartender_c";
  static const $prefPrintTypeBartenderD = "pref_print_type_bartender_d";
  static const $prefPrintTypeTemp = "pref_print_type_temp";
  static const $prefPrintTypeBluetooth = "pref_print_type_bluetooth";
  static const $prefPrintTypeUsb = "pref_print_type_usb";

// INFORMATION
  static const $prefPrintInformation = "pref_print_information";
  static const $prefPrintInformationName = "pref_print_information_name";
  static const $prefPrintInformationImage = "pref_print_information_image";
  static const $prefPrintInformationFooter = "pref_print_information_footer";
  static const $prefPrintInformationAddress = "pref_print_information_address";
  static const $prefPrintInformationPhone = "pref_print_information_phone";
  static const $prefPrintInformationBanner = "pref_print_information_banner";
  static const $prefPrintInformationSlideShow = "pref_print_information_slide_show";

//
  static const $prefAutoPrintCook = "pref_auto_print_cook";
  static const $prefAutoPrintTempFromServed = "pref_auto_print_temp_from_served";
  static const $prefPrintAfterPay = "pref_print_after_pay";
  static const $prefPrintTempAfterPay = "pref_print_temp_after_pay";
  static const $prefOpenCashBoxAfterPay = "pref_open_cash_box_after_pay";
  static const $prefAllowPrintPreview = "pref_print_allow_print_preview";
  static const $prefPrintHiddenMode = "pref_print_hidden_mode";
  static const $prefPrintKitchenAfterSave = "pref_print_kitchen_after_save";
  static const $prefStockControlWhenSelling = "pref_stock_control_when_selling";
  static const $prefAllowChangePrice = "pref_allow_change_price";
  static const $prefAllowChangeNameProduct = "pref_allow_change_name_product";
  static const $prefReceiveDataFromOtherCashiers = "pref_receive_data_from_other_cashiers";
  static const $prefVat = "pref_vat";
  static const $prefVatMethod = "pref_vat_method";
  static const $prefCardNumberCount = "pref_card_number_count";
  static const $prefCurrencyUnit = "pref_currency_unit";
  static const $prefCategoriesDirection = "pref_categories_direction";
  static const $prefMenuItemSize = "pref_menu_item_size";
  static const $prefPrintCookSeparateMenu = "pref_print_cook_separate_menu";

//
  static const $prefPrintTwoForInvoice = "pref_print_two_for_invoice";
  static const $prefPrintTwoForCook = "pref_print_two_for_cook";
  static const $prefPrintTempFirstPay = "pref_print_temp_first_pay";

//
  static const $prefUseTwoScreen = "pref_use_two_screen";
  static const $prefShowNavigationBar = "pref_show_navigation_bar";
  static const $prefKeepScreenOn = "pref_keep_screen_on";
  static const $prefUsingDefaultKeyboard = "pref_using_default_keyboard";
  static const $prefUseFullScreenScanner = "pref_use_full_screen_scanner";

// POINT
  static const $prefPointCalculation = "pref_point_calculation";
  static const $prefPointRedeem = "pref_point_redeem";

// VOUCHER
  static const $prefVoucher = "pref_voucher";
  static const $excludeOrderDiscount = "ExcludeOrderDiscount";
  static const $excludeProductDiscount = "ExcludeProductDiscount";
  static const $valueToPoint = "ValueToPoint";
  static const $pointToValue = "PointToValue";
}
