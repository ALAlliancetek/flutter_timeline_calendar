import 'package:flutter_timeline_calendar/timeline/widget/timeline_calendar.dart';
import '../handlers/translator.dart';
import '../model/datetime.dart';
import '../model/headers_options.dart';
import 'calendar_types.dart';

class CalendarUtils {
  static goToYear(index) {
    TimelineCalendar.dateTime =
        TimelineCalendar.calendarProvider.goToYear(index);
  }

  static goToMonth(index) {
    TimelineCalendar.dateTime =
        TimelineCalendar.calendarProvider.goToMonth(index);
  }

  static goToDay(index) {
    TimelineCalendar.dateTime =
        TimelineCalendar.calendarProvider.goToDay(index);
  }

  static nextDay() {
    TimelineCalendar.dateTime =
        TimelineCalendar.calendarProvider.getNextDayDateTime();
  }

  static previousDay() {
    TimelineCalendar.dateTime =
        TimelineCalendar.calendarProvider.getPreviousDayDateTime();
  }

  static nextMonth() {
    TimelineCalendar.dateTime =
        TimelineCalendar.calendarProvider.getNextMonthDateTime();
  }

  static previousMonth() {
    TimelineCalendar.dateTime =
        TimelineCalendar.calendarProvider.getPreviousMonthDateTime();
  }

  static List getYears() => TimelineCalendar.calendarProvider.getYears();

  static List getDaysAmount() =>
      TimelineCalendar.calendarProvider.getDayAmount();

  static Map getDays(WeekDayStringTypes type, int monthIndex) {
    return TimelineCalendar.calendarProvider.getMonthDays(type, monthIndex);
  }

  static Map getMonthDays(WeekDayStringTypes type, int monthIndex) =>
      TimelineCalendar.calendarProvider.getMonthDays(type, monthIndex);

  static getPartByString(
      {required PartFormat format, required HeaderOptions options}) {
    return Translator.getPartTranslate(options, format,
        TimelineCalendar.calendarProvider.getDateTimePart(format) - 1);
  }

  static getPartByInt({required PartFormat format}) {
    return TimelineCalendar.calendarProvider.getDateTimePart(format);
  }

  static _isRange(CalendarDateTime element) =>
      element.toMonth != null || element.toDay != null;

  static isEndOfRange(CalendarDateTime? element, int year, int month, int day) {
    if (element?.year != year) return false;
    if (element?.toMonth == null) {
      if (element?.toDay == null) return element?.day == day;
      return element?.toDay == day;
    } else if (element?.toMonth == month) {
      if (element?.toDay == null) return element?.day == day;
      return element?.toDay == day;
    }
    return false;
  }

  static isStartOfRange(
          CalendarDateTime? element, int year, int month, int day) =>
      element?.year == year && element?.month == month && element?.day == day;

  static isInRange(
      CalendarDateTime? selectedDatetime, int year, int month, int day) {
    if (selectedDatetime?.year != year) return false;
    if (selectedDatetime?.month != null && selectedDatetime!.month > month)
      return false;
    if (selectedDatetime?.toMonth != null && selectedDatetime!.toMonth! < month)
      return false;
    if (selectedDatetime?.day != null &&
        selectedDatetime!.month == month &&
        selectedDatetime.day > day) return false;

    if (selectedDatetime?.toMonth != null) {
      if (selectedDatetime!.toDay != null &&
          selectedDatetime.toMonth == month &&
          selectedDatetime.toDay! < day) return false;
    } else {
      if (selectedDatetime!.toDay != null &&
          (selectedDatetime.month != month || selectedDatetime.toDay! < day))
        return false;
    }
    return true;
  }

  static isBeforeThanToday(int currentYear, int currentMonth, int currentDay) {
    CalendarDateTime now = TimelineCalendar.calendarProvider.getDateTime();
    DateTime currentDateTime = DateTime(currentYear, currentMonth, currentDay);
    return currentDateTime.difference(now.toDateTime()).isNegative;
  }

}
