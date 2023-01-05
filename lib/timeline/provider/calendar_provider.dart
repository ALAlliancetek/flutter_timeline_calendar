
import 'package:flutter_timeline_calendar/timeline/utils/calendar_types.dart';
import '../model/datetime.dart';

abstract class CalendarProvider {
  bool isRTL();

  bool isCenter();

  Map getMonthDays(WeekDayStringTypes type, int index);

  Map getMonthDaysShort(int index);

  CalendarDateTime getNextMonthDateTime();

  CalendarDateTime getPreviousMonthDateTime();

  CalendarDateTime getNextDayDateTime();

  CalendarDateTime getPreviousDayDateTime();

  CalendarDateTime getDateTime();

  String getFormattedDate({DateTime? customDate});

  CalendarDateTime goToMonth(index);

  CalendarDateTime goToDay(index);

  CalendarDateTime goToYear(int index);

  int getDateTimePart(PartFormat format);

  List<int> getYears();
  List<int> getDayAmount();
}
