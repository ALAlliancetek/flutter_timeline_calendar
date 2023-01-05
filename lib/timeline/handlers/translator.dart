import 'package:flutter_timeline_calendar/timeline/widget/timeline_calendar.dart';

import '../dictionaries/dictionary.dart';
import '../model/headers_options.dart';
import '../utils/calendar_types.dart';

class Translator {
  static String getPartTranslate(HeaderOptions options, format, index) {
    switch (format) {
      case PartFormat.MONTH:
        return _getMonthName(options.monthStringType, index);
      default:
        return '';
    }
  }

  static String _getMonthName(MonthStringTypes type, index) {
    switch (type) {
      case MonthStringTypes.SHORT:
        return getShortMonthNames()[index];
      case MonthStringTypes.FULL:
        return getFullMonthNames()[index];
    }
  }

  static String getTranslation(String word) =>
      titles[TimelineCalendar.calendarLanguage][word];

  static List<String> getNameOfDay(WeekDayStringTypes type) {
    switch (type) {
      case WeekDayStringTypes.SHORT:
        return getShortNameOfDays();
      case WeekDayStringTypes.FULL:
        return getFullNameOfDays();
    }
  }

  static Map getMonthDaysShort(int monthIndex) =>
      TimelineCalendar.calendarProvider.getMonthDaysShort(monthIndex);

  static List<String> getShortNameOfDays() =>
      shortDayNames[TimelineCalendar.calendarLanguage][TimelineCalendar.calendarType];

  static List<String> getFullNameOfDays() =>
      fullDayNames[TimelineCalendar.calendarLanguage][TimelineCalendar.calendarType];

  static List<String> getFullMonthNames() =>
      fullMonthNames[TimelineCalendar.calendarLanguage][TimelineCalendar.calendarType];

  static List<String> getShortMonthNames() =>
      shortMonthNames[TimelineCalendar.calendarLanguage][TimelineCalendar.calendarType];

  static bool isRTL() => directionIsRTL[TimelineCalendar.calendarLanguage];

  static bool isCenter() => directionIsCenter[TimelineCalendar.calendarLanguage];
}
