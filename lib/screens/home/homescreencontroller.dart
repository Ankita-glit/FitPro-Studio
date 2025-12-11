import 'package:firstdayappsuccessor/screens/home/homepagemodel.dart';
import 'package:get/get.dart';
import 'homepagerepo.dart';
import 'homescreenmodel.dart';

class Homescreencontroller extends GetxController {

  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;
  var selectedDatum = Rxn<Datum>();
  var datas = Rxn<Datum>();
  RxBool isLoading = false.obs;
  List<Homepagemodel> homepagemodel = [];

  @override
  void onInit() {
    super.onInit();
    fetchHomedata();
  }

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
  }

  Future<void> fetchHomedata() async {
    isLoading.value = true;
    try {
      HomeClass().HomepageRepo(
          beforeSend: () {},
          onSuccess: (data) {
            if (data.isSuccess) {
              homepagemodel = data.resObject!;
              print(homepagemodel.length);
              isLoading.value=false;
            }
          }, onError: (error) { isLoading.value=false;print(error); });

    } catch (e) {
      print(e);
      isLoading.value=false;
    }
  }

}

