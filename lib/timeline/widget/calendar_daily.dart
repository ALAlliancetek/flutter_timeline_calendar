import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/widget/timeline_calendar.dart';

import '../model/datetime.dart';
import '../model/day_options.dart';
import '../model/headers_options.dart';
import '../utils/calendar_types.dart';
import '../utils/calendar_utils.dart';
import 'day.dart';

class CalendarDaily extends StatelessWidget {
  Function? onCalendarChanged;
  var dayIndex;
  late ScrollController animatedTo;

  CalendarDaily({this.onCalendarChanged}) : super() {
    dayIndex = CalendarUtils.getPartByInt(format: PartFormat.DAY);
  }

  @override
  Widget build(BuildContext context) {
    animatedTo = ScrollController(
        initialScrollOffset: (DayOptions.of(context).compactMode
                ? 40.0
                : (HeaderOptions.of(context).weekDayStringType ==
                        WeekDayStringTypes.FULL
                    ? 80.0
                    : 60.0)) *
            (dayIndex - 1));

    executeAsync(context);
    // Yearly , Monthly , Weekly and Daily calendar
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
      height: DayOptions.of(context).showWeekDay
          ? DayOptions.of(context).compactMode
              ? 90
              : 100
          : 90,
      child: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            reverse: TimelineCalendar.calendarProvider.isRTL(),
            controller: animatedTo,
            scrollDirection: Axis.horizontal,
            children: daysMaker(context),
          ),
          DayOptions.of(context).disableFadeEffect
              ? const SizedBox()
              : Align(
                  alignment: Alignment.centerLeft,
                  child: IgnorePointer(
                    child: Container(
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xffffffff), Color(0x0affffff)],
                          tileMode: TileMode.clamp,
                        ),
                      ),
                    ),
                  ),
                ),
          DayOptions.of(context).disableFadeEffect
              ? const SizedBox()
              : Align(
                  alignment: Alignment.centerRight,
                  child: IgnorePointer(
                    child: Container(
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        gradient: const LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [Color(0xffffffff), Color(0x0affffff)],
                          tileMode: TileMode.clamp,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  List<Widget> daysMaker(BuildContext context) {
    int currentMonth = CalendarUtils.getPartByInt(format: PartFormat.MONTH);
    int currentYear = CalendarUtils.getPartByInt(format: PartFormat.YEAR);

    final headersStyle = HeaderOptions.of(context);

    List<Widget> days = [
      SizedBox(
          width: DayOptions.of(context).compactMode
              ? 40
              : headersStyle.weekDayStringType == WeekDayStringTypes.FULL
                  ? 80
                  : 60)
    ];

    int day = dayIndex;
    CalendarUtils.getDays(headersStyle.weekDayStringType, currentMonth)
        .forEach((index, weekDay) {
      var selected = index == day;

      bool isBeforeToday =
          CalendarUtils.isBeforeThanToday(currentYear, currentMonth, index);

      days.add(Day(
        day: index,
        dayStyle: DayStyle(
          compactMode: DayOptions.of(context).compactMode,
          enabled: (true),
          selected: selected,
          useUnselectedEffect: false,
          useDisabledEffect: DayOptions.of(context).disableDaysBeforeNow
              ? isBeforeToday
              : false,
        ),
        weekDay: weekDay,
        onCalendarChanged: () {
          CalendarUtils.goToDay(index);
          onCalendarChanged?.call();
        },
      ));
    });

    days.add(
      SizedBox(
        width: DayOptions.of(context).compactMode
            ? 40
            : headersStyle.weekDayStringType == WeekDayStringTypes.FULL
                ? 80
                : 60,
      ),
    );

    return days;
  }

  BoxDecoration? _getDecoration(
      CalendarDateTime? specialDay, curYear, int currMonth, day) {
    BoxDecoration? decoration;
    final isStartRange =
        CalendarUtils.isStartOfRange(specialDay, curYear, currMonth, day);
    final isEndRange =
        CalendarUtils.isEndOfRange(specialDay, curYear, currMonth, day);
    final isInRange =
        CalendarUtils.isInRange(specialDay, curYear, currMonth, day);

    if (isEndRange && isStartRange) {
      decoration = BoxDecoration(
          color: specialDay?.color, borderRadius: BorderRadius.circular(8));
    } else if (isStartRange) {
      decoration = BoxDecoration(
          color: specialDay?.color,
          borderRadius:
              const BorderRadius.horizontal(right: Radius.circular(8)));
    } else if (isEndRange) {
      decoration = BoxDecoration(
          color: specialDay?.color,
          borderRadius:
              const BorderRadius.horizontal(left: Radius.circular(8)));
    } else if (isInRange) {
      decoration = BoxDecoration(color: specialDay?.color);
    }
    return decoration;
  }

  void executeAsync(context) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (animatedTo.hasClients) {
        final animateOffset = (DayOptions.of(context).compactMode
                ? 40.0
                : (HeaderOptions.of(context).weekDayStringType ==
                        WeekDayStringTypes.FULL
                    ? 80.0
                    : 60.0)) *
            (dayIndex - 1);
        animatedTo.animateTo(animateOffset,
            duration: const Duration(milliseconds: 700),
            curve: Curves.decelerate);
      }
    });
  }
}
