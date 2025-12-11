abstract class ApiUrls {
  static String cbtBaseUrl(String endPoint) =>
      "https://fitarcbe.boostproductivity.online/api/v1/$endPoint";

  // "http://127.0.0.1:8000/$endPoint";
  // "http://testing.codebright.in/$cbtApi";

  static String cbtDynamicUrl(String cbtApi) =>
      "https://advisor-connect-apis.codebright.in/$cbtApi";

  // "http://127.0.0.1:8000/$cbtApi";
  // "http://testing.codebright.in/$cbtApi";

  static String baseUrl(String endPoint) => cbtBaseUrl("api/$endPoint");

  static String base_url_web(String endPoint) => cbtBaseUrl(endPoint);

  static String base_url_web1(String endPoint) => cbtBaseUrl(endPoint);

  static String base_url_web_form(String endPoint,
      {String employeeID = "", String formID = ""}) =>
      formID.isEmpty && employeeID.isEmpty
          ? cbtBaseUrl("form/$endPoint")
          : formID.isEmpty
          ? cbtBaseUrl("$endPoint/$employeeID")
          : cbtBaseUrl("$endPoint$employeeID/$formID");

  static String get companyList => base_url_web("master-api/company-list");

  static String get header_list => base_url_web("common-api/header-list");

  static String get getAllWebData =>
      base_url_web("portfolio-api/all-website-data-list");

  static String get banner_list => base_url_web("common-api/banner-list");

  static String get our_services => base_url_web("common-api/services-list");

  static String get our_products => base_url_web("common-api/website-data");

  static String get our_clients => base_url_web("common-api/website-data");
  static String get fileUpload => base_url_web("common-api/file-data-upload-new");

  static String get projectList => cbtDynamicUrl("/master-api/project-dt-list");

  static String get moduleList => cbtDynamicUrl("/master-api/module-dt-list");

  static String get dynamicForm => cbtDynamicUrl("/master-api/form-add");

  static String get menu_list => base_url_web("account-api/menu-data");

  static String get department_list =>
      base_url_web("common-api/department-list");

  static String get department_add => base_url_web("common-api/department-add");

  static String get employeeList => base_url_web("employee-api/employee-list");

  static String get designation_list =>
      base_url_web("common-api/designation-list");

  static String get designation_add =>
      base_url_web("common-api/designation-add");

  static String get cbt_drop_down => base_url_web("common-api/dropdown-list");

  static String get cbt_flight_ssearch =>
      cbtBaseUrl("flight-api/search-flight-data");

  static String get cbt_flight_authantication =>
      "http://api.tektravels.com/SharedServices/SharedData.svc/rest/Authenticate";

  static String get state_list => base_url_web("common-api/state-list");

  static String get empadd => base_url_web("employee-api/employee-add");

  static String get productList => base_url_web("inventory-api/product-list");

  static String get pinCode => base_url_web("common-api/pincode-data");

  static String get postLeadData => base_url_web("sales-api/lead-trans-add");

  static String get menuListData => base_url_web("common-api/menu-list");

  static String get sendOtp => cbtBaseUrl("account-api/send-otp");

  static String get verifyOtp => cbtBaseUrl("account-api/login-with-otp");

  static String get register => cbtBaseUrl("account-api/user-register");

  static String get user_list => cbtBaseUrl("account-api/user-list-pagination");

  static String get order_list => cbtBaseUrl("sales-api/book-order-list");

  static String get book_entry_list =>
      cbtBaseUrl("book-master-api/all-book-data");

  static String get order_address_list =>
      cbtBaseUrl("sales-api/order-address-list");

  static String get party_wise_order_list =>
      cbtBaseUrl("sales-api/order-detail-by-user");

  static String get order_address_add =>
      cbtBaseUrl("sales-api/order-address-add");

  static String get partyRegistration =>
      cbtBaseUrl("account-api/party-registration");

  static String get add_user => cbtBaseUrl("account-api/user-add");

  static String get profile_list => cbtBaseUrl("user");

  static String get profile_list_update =>
      cbtBaseUrl("account-api/user-profile-update");

  static String get save_order_data =>
      cbtBaseUrl("sales-api/book-order-create");

  static String get change_approval_status =>
      cbtBaseUrl("account-api/user-account-permission");

  static String get user_account_permission =>
      cbtBaseUrl("account-api/party-assign-to-agent");

  static String get dashboard_data =>
      cbtBaseUrl("dashboard-api/dashboard-data");

  static String get classlist_data => cbtBaseUrl("mobile-api/class-list");

  static String get categorylist_data =>
      cbtBaseUrl("mobile-api/category-data-list");

  static String get subjectlist_data => cbtBaseUrl("mobile-api/book-data-list");

  static String get summarylist_data =>
      cbtBaseUrl('mobile-api/catalogue-data-list');

  static String get visuallist_data => cbtBaseUrl('account-api/menu-data');

  static String get customer_data =>
      cbtBaseUrl('account-api/dropdown-user-list');

  static String get locked_data => cbtBaseUrl('mobile-api/lock-catalogue');

  static String get share_data => cbtBaseUrl('mobile-api/share-catalogue');

  static String get send_data => cbtBaseUrl('mobile-api/send-catalogue');

  static String get preview_data => cbtBaseUrl('mobile-api/preview-catalogue');

  static String get cataloguereportfilterdata =>
      cbtBaseUrl('mobile-api/catalogue-report-filter-data');

  static String get cataloguereportdata =>
      cbtBaseUrl('mobile-api/catalogue-report-data');
}