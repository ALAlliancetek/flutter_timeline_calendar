import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/widget/timeline_calendar.dart';

import '../model/datetime.dart';
import 'calendar_utils.dart';

class StyleProvider {
  static BoxDecoration? getSpecialDayDecoration(CalendarDateTime? specialDay, curYear, int currMonth, day) {
    BoxDecoration? decoration;
    final isStartRange = CalendarUtils.isStartOfRange(specialDay, curYear, currMonth, day);
    final isEndRange = CalendarUtils.isEndOfRange(specialDay, curYear, currMonth, day);
    final isInRange = CalendarUtils.isInRange(specialDay, curYear, currMonth, day);

    if (isEndRange && isStartRange) {
      decoration = BoxDecoration(color: specialDay?.color, borderRadius: BorderRadius.circular(8));
    } else if (isStartRange) {
      decoration = BoxDecoration(
        color: specialDay?.color,
        borderRadius: _getStartRadiusByLocale(),
      );
    } else if (isEndRange) {
      decoration = BoxDecoration(
        color: specialDay?.color,
        borderRadius: _getEndRadiusByLocale(),
      );
    } else if (isInRange) {
      decoration = BoxDecoration(color: specialDay?.color);
    }
    return decoration;
  }

  static bool _isRTL() => TimelineCalendar.calendarProvider.isRTL();

  static _getStartRadiusByLocale() {
    return _isRTL()
        ? BorderRadius.horizontal(right: Radius.circular(8))
        : BorderRadius.horizontal(left: Radius.circular(8));
  }

  static _getEndRadiusByLocale() {
    return _isRTL()
        ? BorderRadius.horizontal(left: Radius.circular(8))
        : BorderRadius.horizontal(right: Radius.circular(8));
  }
}
