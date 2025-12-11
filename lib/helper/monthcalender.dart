import 'package:firstdayappsuccessor/screens/progressbar/progresscontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'calendercontroller.dart';

class MonthCalendar extends StatelessWidget {
  final CalendarController controller = Get.find<CalendarController>();
  final ProgressController progressController = Get.find<ProgressController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height*0.5,
      child: Column(
        children: [
          SizedBox(height: 30),
          _buildMonthHeader(),
          SizedBox(height: 15),
          _buildWeekDaysHeader(),
          Expanded(child: _buildMonthDays()),
        ],
      ),
    );
  }

  Widget _buildMonthHeader() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Obx(() => Text(
            DateFormat.yMMMM().format(controller.currentMonth.value),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Instrument Sans'),
          )),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Color(0xffCFED51), size: 18),
                onPressed: () => controller.goToPreviousMonth(),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Color(0xffCFED51), size: 18),
                onPressed: () => controller.goToNextMonth(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeekDaysHeader() {
    List<String> weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: weekDays.map((day) {
          return Text(
            day,
            style: TextStyle(color: Color(0xffC4C4C4), fontWeight: FontWeight.w500, fontSize: 12, fontFamily: 'Instrument Sans'),
          );
        }).toList(),
      ),
    );
  }
  Widget _buildMonthDays() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Obx(() {
        List<DateTime?> days = controller.getMonthDays(controller.currentMonth.value);

        return GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: days.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.07,
          ),
          itemBuilder: (context, index) {
            DateTime? day = days[index];
            if (day == null) return Container();

            bool isToday = DateUtils.isSameDay(day, DateTime.now());
            bool isAfterToday = day.isAfter(DateTime.now());

            return GestureDetector(
              onTap: () {
                if (!isAfterToday) {
                  controller.printWorkouts();
                  controller.selectDay(day);
                  progressController.pushExercises.clear();
                  progressController.pullExercises.clear();
                  progressController.legsExercises.clear();
                  progressController.hasAnyExercises.value = false;
                  progressController.FetchCompletedExerciseListOnDate();
                }
              },
              child: Obx(() {
                bool isSelected = DateUtils.isSameDay(controller.selectedDay.value, day);

                return Container(
                  margin: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isSelected && isToday
                        ? Color(0xffCFED51)
                        : (isToday && !isSelected
                        ? Colors.transparent
                    :(isSelected)?Color(0xffCFED51).withOpacity(0.12)
                        : (isAfterToday ? Colors.transparent : Colors.transparent)),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        color: isSelected && isToday
                            ? Colors.black
                            : (isToday && !isSelected ? Color(0xffCFED51)
                            :(isSelected && !isToday)?Color(0xffCFED51)
                            : (isAfterToday ? Colors.grey.shade50.withOpacity(0.4) : Color(0xffC4C4C4))),
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        );
      }),
    );
  }
}
