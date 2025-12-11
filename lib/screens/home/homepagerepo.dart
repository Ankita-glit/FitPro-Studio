import '../../api_file/api_urls.dart';
import '../../api_file/cbt_api.dart';
import '../../cbt_model/response.dart';
import 'homepagemodel.dart';

class HomeClass {
  Homepagemodel homepagemodel = Homepagemodel();
  Future<void> HomepageRepo({
    required Function() beforeSend,
    required Function(ApiResponse<List<Homepagemodel>> posts) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    CbtRequest(url: ApiUrls.homepage).getRequest(
      beforeSend: () => {beforeSend()},
      onSuccess: (response) {
        try {
          List<Homepagemodel> homepagemodelList = (response as List)
              .map((item) => Homepagemodel.fromJson(item))
              .toList();

          onSuccess(ApiResponse(
            isSuccess: true,
            errorCause: response,
            resObject: homepagemodelList,
          ));
        } catch (e) {
          String errorMsg = "Error parsing data";
          if (e is FormatException) {
            errorMsg = "Invalid data format";
          } else if (e is TypeError) {
            errorMsg = "Type mismatch error";
          }
        }
      },
      onError: (error) {
        onError(error);
      },
    );
  }

}
