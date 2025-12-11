import 'package:firstdayappsuccessor/screens/pushpage/pushuppagemodel.dart';
import 'package:firstdayappsuccessor/screens/pushpage/reps/exercisecompleteondatemodel.dart';
import 'package:firstdayappsuccessor/screens/pushpage/repsweight/completeexercisemodel.dart';
import '../../api_file/cbt_api.dart';
import '../../cbt_model/response.dart';

class PushupPageRepo {
  CategoryExerciseModel categoryExerciseModel = CategoryExerciseModel();
  Future<void> CategoryexerciseRepo({
    required String url,
    required Function() beforeSend,
    required Function(ApiResponse<List<CategoryExerciseModel>> posts) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    CbtRequest(url: url).getRequest(
      beforeSend: () => {beforeSend()},
      onSuccess: ( response) {
        try {
          List<CategoryExerciseModel> categoryExerciseModelList = (response as List)
              .map((item) => CategoryExerciseModel.fromJson(item))
              .toList();

          onSuccess(ApiResponse(
            isSuccess: true,
            errorCause: response,
            resObject: categoryExerciseModelList,
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
CompleteExerciseModel completeExerciseModel = CompleteExerciseModel();
  Future<void> CompleteExerciseRepo({
    required String url,
    required Function() beforeSend,
    required Function(ApiResponse<List<CompleteExerciseModel>> posts) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    CbtRequest(url: url).getRequest(
      beforeSend: () => {beforeSend()},
      onSuccess: ( response) {
        try {
          List<CompleteExerciseModel> completeExerciseList = (response as List)
              .map((item) => CompleteExerciseModel.fromJson(item))
              .toList();

          onSuccess(ApiResponse(
            isSuccess: true,
            errorCause: response,
            resObject: completeExerciseList,
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


  Future<void> CompleteExerciseListOnTimeRepo({
    required String url,
    required Function() beforeSend,
    required Function(ApiResponse<List<CompleteExerciseListOnDatemodel>> posts) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    CbtRequest(url: url).getRequest(
      beforeSend: () => {beforeSend()},
      onSuccess: ( response) {
        try {
          List<CompleteExerciseListOnDatemodel> completeExerciseListOnTime = (response as List)
              .map((item) => CompleteExerciseListOnDatemodel.fromJson(item))
              .toList();

          onSuccess(ApiResponse(
            isSuccess: true,
            errorCause: response,
            resObject: completeExerciseListOnTime,
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
