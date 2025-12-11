abstract class ApiUrls {
  // static String cbtBaseUrl(String endPoint) =>
  //     "https://advisor-connect-apis.codebright.in/$endPoint";
  static String cbtBaseUrl(String endPoint)=> "https://fitarcbe.boostproductivity.online/api/v1/$endPoint";

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
  
  static String get homepage => cbtBaseUrl("exercise-categories/");
  
  static String get categoryexerciseurl => cbtBaseUrl("exercises/");
}
