import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'calendercontroller.dart';

class CustomCalendar extends StatelessWidget {
  final CalendarController controller = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    double screenWidth = MediaQuery.of(context).size.width;

    DateTime mondayOfCurrentWeek = today.subtract(Duration(days: today.weekday - 1));
    List<DateTime> weekDays = controller.getWeekDays(mondayOfCurrentWeek);

    return Container(
      width: screenWidth,
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 20),
      height: 100, // Fixed height for calendar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: weekDays.map((day) {
          bool isToday = DateUtils.isSameDay(day, today);
          bool isSelected = controller.selectedDay.value != null &&
              DateUtils.isSameDay(day, controller.selectedDay.value);

          return Expanded(
            child: GestureDetector(
              onTap: () => controller.selectDay(day),
              child:Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isToday ? const Color(0xffCFED51) : Colors.transparent,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${day.day}',
                        style: TextStyle(
                          color: isToday ? Color(0xff060606) : Color(0xffC4C4C4),
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Instrument Sans',
                        ),
                      ),
                      SizedBox(height: isToday ? 2 : 6),
                      Text(
                        isToday ? 'Today' : DateFormat.E().format(day),
                        style: TextStyle(
                          color: isToday ? Colors.black : Color(0xffC4C4C4),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Instrument Sans',
                        ),
                      ),
                    ],
                  ),
                )
              ,
            ),
          );
        }).toList(),
      ),
    );
  }
}
