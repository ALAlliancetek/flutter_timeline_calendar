import 'package:flutter_timeline_calendar/timeline/widget/timeline_calendar.dart';

import '../handlers/translator.dart';
import '../model/datetime.dart';
import '../utils/calendar_types.dart';
import 'calendar_provider.dart';

class GregorianCalendar extends CalendarProvider {
  @override
  CalendarDateTime getDateTime() {
    return CalendarDateTime.parseDateTime(DateTime.now().toString())!;
  }

  @override
  CalendarDateTime getNextMonthDateTime() {
    final date = _getSelectedDate();
    int nextMonth = date.month + 1;
    int nextYear = date.year;
    if (nextMonth > 12) {
      nextMonth = 1;
      nextYear++;
    }
    int maxDays = DateTime(nextYear, nextMonth + 1, 0).day;
    int day = date.day > maxDays ? maxDays : date.day;
    return CalendarDateTime(year: nextYear, month: nextMonth, day: day);
  }

  @override
  CalendarDateTime getPreviousMonthDateTime() {
    final date = _getSelectedDate();
    int prevMonth = date.month - 1;
    int prevYear = date.year;
    if (prevMonth < 1) {
      prevMonth = 12;
      prevYear--;
    }
    int maxDays = DateTime(prevYear, prevMonth + 1, 0).day;
    int day = date.day > maxDays ? maxDays : date.day;
    return CalendarDateTime(year: prevYear, month: prevMonth, day: day);
  }

  @override
  CalendarDateTime getPreviousDayDateTime() {
    final date = _getSelectedDate();
    return CalendarDateTime(
        year: date.year, month: date.month, day: date.day - 1);
  }

  @override
  CalendarDateTime getNextDayDateTime() {
    final date = _getSelectedDate();
    return CalendarDateTime(
        year: date.year, month: date.month, day: date.day + 1);
  }

  @override
  bool isRTL() => Translator.isRTL();

  @override
  bool isCenter() => Translator.isCenter();

  @override
  Map getMonthDays(WeekDayStringTypes type, int index) {
    Map days = {};
    CalendarDateTime now = _getSelectedDate();
    int monthLength = DateTime(now.year, index + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(now.year, index, 1);
    int dayIndex = firstDayOfMonth.weekday;

    switch (type) {
      case WeekDayStringTypes.FULL:
        for (var i = 1; i <= monthLength; i++) {
          days[i] = Translator.getFullNameOfDays()[dayIndex % 7];
          dayIndex++;
        }
        break;
      case WeekDayStringTypes.SHORT:
        for (var i = 1; i <= monthLength; i++) {
          days[i] = Translator.getShortNameOfDays()[dayIndex % 7];
          dayIndex++;
        }
        break;
    }
    return days;
  }

  @override
  Map getMonthDaysShort(int index) {
    Map days = {};
    CalendarDateTime now = _getSelectedDate();
    int monthLength = DateTime(now.year, index + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(now.year, index, 1);
    int dayIndex = firstDayOfMonth.weekday;
    for (var i = 1; i <= monthLength; i++) {
      days[i] = Translator.getShortNameOfDays()[dayIndex % 7];
      dayIndex++;
    }
    return days;
  }

  @override
  List<int> getYears() {
    int year = _getSelectedDate().year;
    List<int> years = [];
    for (var i = -100; i <= 50; i++) years.add(year + i);
    return years;
  }

  @override
  List<int> getDayAmount() {
    int month = _getSelectedDate().month;
    int daysinCurrentMonth =
        getMonthDays(WeekDayStringTypes.FULL, month).length;
    List<int> days = [];
    for (var i = 1; i <= daysinCurrentMonth; i++) days.add(i);
    return days;
  }

  CalendarDateTime _getSelectedDate() {
    return TimelineCalendar.dateTime!;
  }

  @override
  CalendarDateTime goToDay(index) {
    dynamic date = _getSelectedDate();
    return CalendarDateTime(year: date.year, month: date.month, day: index);
  }

  @override
  CalendarDateTime goToMonth(index) {
    dynamic date = _getSelectedDate();
    int maxDays = DateTime(date.year, index + 1, 0).day;
    int day = date.day > maxDays ? maxDays : date.day;
    return CalendarDateTime(year: date.year, month: index, day: day);
  }

  @override
  CalendarDateTime goToYear(index) {
    dynamic date = _getSelectedDate();
    int maxDays = DateTime(index, date.month + 1, 0).day;
    int day = date.day > maxDays ? maxDays : date.day;
    return CalendarDateTime(year: index, month: date.month, day: day);
  }

  @override
  int getDateTimePart(PartFormat format) {
    CalendarDateTime date = _getSelectedDate();
    switch (format) {
      case PartFormat.YEAR:
        return date.year;
      case PartFormat.MONTH:
        return date.month;
      case PartFormat.DAY:
        return date.day;
    }
  }

  @override
  String getFormattedDate({DateTime? customDate}) {
    CalendarDateTime? dateTime;
    if (customDate != null) {
      dateTime = CalendarDateTime.parseDateTime(customDate.toString());
    } else {
      dateTime = _getSelectedDate();
    }
    return "${dateTime!.day} ${Translator.getFullMonthNames()[dateTime.month - 1]} ${dateTime.year}";
  }
}
