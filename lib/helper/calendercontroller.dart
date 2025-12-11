import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../screens/progressbar/progresscontroller.dart';

class CalendarController extends GetxController {
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> currentMonth = DateTime.now().obs;
  RxMap<String, List<String>> workoutsByDate = <String, List<String>>{}.obs;

  List<DateTime?> getMonthDays(DateTime monthStart) {
    int daysInMonth = DateTime(monthStart.year, monthStart.month + 1, 0).day;
    int firstWeekday = DateTime(monthStart.year, monthStart.month, 1).weekday;

    List<DateTime?> days = List.generate(firstWeekday - 1, (index) => null);

    days.addAll(List.generate(daysInMonth, (index) => DateTime(monthStart.year, monthStart.month, index + 1)));

    return days;
  }

  DateTime getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  List<DateTime> getWeekDays(DateTime date) {
    DateTime startOfWeek = getStartOfWeek(date);
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  void goToNextMonth() {
    currentMonth.value = DateTime(currentMonth.value.year, currentMonth.value.month + 1, 1);
  }


  void goToPreviousMonth() {
    currentMonth.value = DateTime(currentMonth.value.year, currentMonth.value.month - 1, 1);
  }

  // void selectDay(DateTime day) {
  //   selectedDay.value = day;
  //   selectedDay.refresh();
  //   print("Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDay.value)}");
  // }
  void selectDay(DateTime day) {
    selectedDay.value = day;

  }

  void storeWorkoutForDate(String workout) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay.value);
    workoutsByDate.update(formattedDate, (existing) => [...existing, workout], ifAbsent: () => [workout]);
    workoutsByDate.refresh();
  }

  List<String> getWorkoutsForDate(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return workoutsByDate[formattedDate] ?? [];
  }

  void printWorkouts() {
    print("All Stored Workouts: $workoutsByDate");
  }
}



