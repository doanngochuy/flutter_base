class AppKey {
  AppKey._();

  /// AppBar
  static String $appBarWebKey(String key) => 'app-bar-web-$key';

  /// DrawerBar
  static String $expansionKey(String key) => 'expansion-$key}';

  static String $drawerBarKey(String key) => 'drawer-bar-$key';

  static String get $showDrawerKey => 'SHOW_DRAWER_KEY';

  /// TabBar
  static String get $tabBarKey => 'TAB_BAR_KEY';

  static String get $tabBarViewKey => 'TAB_BAR_VIEW_KEY';

  static String get $tabBarContextKey => 'TAB_BAR_CONTEXT_KEY';

  /// ScrollView
  static String get $scrollViewKey => 'SCROLL_VIEW_KEY';

  /// Rooms
  static String $roomItemKey(int? id) => 'ROOM_ITEM_KEY_$id';

  /// Voucher
  static String $voucherItemKey(int? id) => 'VOUCHER_ITEM_KEY_$id';

  /// Product Menu
  static String $productMenuItemKey(int? id) => 'PRODUCT_MENU_ITEM_KEY_$id';

  /// Menu Item
  static String get $menuModelTransactionKey => 'MENU_MODEL_TRANSACTION_KEY';

  static String get $menuModelRevenueStatementKey =>
      'MENU_MODEL_REVENUE_STATEMENT_KEY';

  static String get $menuRoomsKey => 'MENU_ROOMS_KEY';

  static String get $menuModelVouchersKey => 'MENU_MODEL_VOUCHERS_KEY';

  /// cash flow

  static String $cashFlowItemKey(int id) => 'CASH_FLOW_ITEM_GEN_KEY_$id';

  static String $cashFlowDetailPageKey(int id) => 'CASH_FLOW_DETAIL_PAGE_KET_$id';

  /// Extra topping
  static String $exToppingItemKey(int id) => 'EX_TOPPING_ITEM_GEN_KEY_$id';

  /// Employees
  static String $employeesItemKey(int id) => 'EMPLOYEE_ITEM_GEN_KEY_$id';


  static String $priceBookProductItemKey(int id) =>
      'PRICE_BOOK_PRODUCT_ITEM_KEY_$id';


  /// Settings
  static String get $printTemplateSaveButtonKey =>
      'PRINT_TEMPLATE_SAVE_BUTTON_KEY';

  static String $priceBookInputOriginalPriceProductItemKey(
          int id, int priceBookId) =>
      'PRICE_BOOK_INPUT_PRICE_PRODUCT_ITEM_KEY_$id-$priceBookId';

  static String $priceBookInputOriginalPriceLargeUnitProductItemKey(
          int id, int priceBookId) =>
      'PRICE_BOOK_INPUT_PRICE_LARGE_UNIT_PRODUCT_ITEM_KEY_$id-$priceBookId';

  /// Invoice
  static String get $invoiceScrollKey => 'INVOICE_SCROLL_KEY';

  static String $invoiceItemKey(int id) => 'INVOICE_ITEM_KEY_$id';

  /// Restaurant
  static String get $removeProductMobileBtnKey =>
      'REMOVE_PRODUCT_MOBILE_BTN_KEY';

  static String get $choosePriceBookRestaurant => "CHOOSE_PRICE_BOOK_RESTAURANT";

  /// Order stock
  static String $orderStockItemKey(int id) => 'ORDER_STOCK_ITEM_GEN_KEY_$id';

  static String get $orderStockDetailCodeInputKey =>
      'ORDER_STOCK_DETAIL_CODE_INPUT_KEY';

  static String get $orderStockDetailEditBtnKey =>
      'ORDER_STOCK_DETAIL_EDIT_BTN_KEY';

  /// Select extra topping
  static String $selectExtraToppingKey(int extraToppingId) =>
      'SELECT_EXTRA_TOPPING_KEY_$extraToppingId';

  static String $selectExtraToppingDetailKey(int extraToppingId) =>
      'SELECT_EXTRA_TOPPING_DETAIL_KEY_$extraToppingId';

  static String get $selectExtraToppingScrollViewKey =>
      'SELECT_EXTRA_TOPPING_SCROLL_VIEW_KEY';

  /// Order Served
  static String $orderServedItemQuantityInputKey(int id) =>
      'ORDER_SERVED_ITEM_QUANTITY_INPUT_KEY_$id';

  /// Reward point Voucher
  static String get $totalDiscount => 'TOTAL_DISCOUNT';

  /// Partner dialog
  static String get $partnerNameInputDialogKey =>
      'PARTNER_NAME_INPUT_DIALOG_KEY';

  static String get $partnerPhoneInputDialogKey =>
      'PARTNER_PHONE_INPUT_DIALOG_KEY';

  static String get $partnerEmailInputDialogKey =>
      'PARTNER_EMAIL_INPUT_DIALOG_KEY';

  static String get $partnerAddressInputDialogKey =>
      'PARTNER_ADDRESS_INPUT_DIALOG_KEY';

  static String get $partnerGroupButtonDialogKey =>
      'PARTNER_GROUP_BUTTON_DIALOG_KEY';

  static String get $partnerProvinceButtonDialogKey =>
      'PARTNER_PROVINCE_BUTTON_DIALOG_KEY';

  /// Calculator
  static String get $calculatorButton1 => "1";
  static String get $calculatorButton2 => "2";
  static String get $calculatorButton500K => "500K";
  static String get $calculatorButton200K => "200K";
  static String get $calculatorButtonClear => "Clear";
  static String get $calculatorButtonDel => "Del";
  static String get $calculatorButton5 => "5";
  static String get $calculatorButtonSummation => "+";
  static String get $calculatorButtonSubtraction => "-";
  static String get $calculatorButtonResult => "=";

  /// inventory
  static String $inventoryItemKey(int id) => 'INVENTORY_ITEM_GEN_KEY_$id';

  static String $inventoryProductItemKey(int id) => 'INVENTORY_PRODUCT_ITEM_GEN_KEY_$id';
}
