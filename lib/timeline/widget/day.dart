import 'package:flutter/material.dart';

import '../model/calendar_options.dart';
import '../model/day_options.dart';
import '../model/headers_options.dart';
import '../utils/calendar_types.dart';

class Day extends StatelessWidget {
  String weekDay;
  Function? onCalendarChanged;
  int day;
  DayOptions? dayOptions;
  CalendarOptions? calendarOptions;
  DayStyle? dayStyle;
  late double opacity;
  bool isToday;

  Day(
      {required this.day,
      required this.weekDay,
      this.dayOptions,
      this.dayStyle,
      this.onCalendarChanged,
      this.isToday = false,
      this.calendarOptions})
      : super() {
    dayOptions ??= DayOptions();
    dayStyle ??= const DayStyle();
    calendarOptions ??= CalendarOptions();
  }

  late Widget child;

  late Color textColor;

  @override
  Widget build(BuildContext context) {
    dayOptions = DayOptions.of(context);
    calendarOptions = CalendarOptions.of(context);
    opacity = _shouldHaveTransparentColor() ? 0.5 : 1;
    textColor = dayStyle!.useDisabledEffect
        ? dayOptions!.disabledTextColor
        : dayStyle!.selected
            ? dayOptions!.selectedTextColor
            : dayOptions!.unselectedTextColor;

    child = InkWell(
      onTap: (() {
        if (dayStyle!.enabled) onCalendarChanged?.call();
      }),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (DayOptions.of(context).showWeekDay &&
              CalendarOptions.of(context).viewType == ViewType.DAILY) ...[
            FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  weekDay,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _getTitleColor(),
                    fontSize: dayOptions?.dayFontSize,
                    fontFamily: CalendarOptions.of(context).font,
                  ),
                ),
              ),
            ),
          ],
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
            padding: dayStyle!.compactMode
                ? EdgeInsets.zero
                : (EdgeInsets.all(HeaderOptions.of(context).weekDayStringType ==
                        WeekDayStringTypes.FULL
                    ? 4
                    : 0)),
            decoration: (isToday && dayOptions?.differentStyleForToday == true)
                ? BoxDecoration(
                    border: Border.all(
                      color: dayOptions!.selectedBackgroundColor,
                    ),
                    color: dayOptions?.todayBackgroundColor,
                    shape: BoxShape.circle)
                : BoxDecoration(
                    color: dayStyle!.selected
                        ? dayOptions!.selectedBackgroundColor
                        : dayOptions!.unselectedBackgroundColor,
                    shape: BoxShape.circle),
            constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: dayStyle!.compactMode ? 35 : 40),
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '$day',
                    style: TextStyle(
                      color: (isToday &&
                              dayOptions?.differentStyleForToday == true)
                          ? dayOptions?.todayTextColor
                          : textColor,
                      fontSize: dayOptions?.dayFontSize,
                      fontFamily: CalendarOptions.of(context).font,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // }
    return Opacity(
      opacity: opacity,
      child: Container(
        padding: EdgeInsets.all(dayStyle!.compactMode
            ? 0
            : CalendarOptions.of(context).viewType == ViewType.DAILY
                ? 10
                : 0),
        decoration: dayStyle?.decoration,
        width: dayStyle!.compactMode
            ? 45
            : (HeaderOptions.of(context).weekDayStringType ==
                    WeekDayStringTypes.FULL
                ? 80
                : 60),
        child: child,
      ),
    );
  }

  _getTitleColor() {
    return dayStyle!.selected
        ? dayOptions!.weekDaySelectedColor
        : dayOptions!.weekDayUnselectedColor;
  }

  _shouldHaveTransparentColor() {
    return !dayStyle!.enabled || dayStyle!.useUnselectedEffect;
  }
}

class DayStyle {
  final bool compactMode;
  final bool useUnselectedEffect;
  final bool enabled;
  final bool selected;
  final bool useDisabledEffect;
  final BoxDecoration? decoration;

  const DayStyle({
    this.compactMode = false,
    this.useUnselectedEffect = false,
    this.enabled = false,
    this.selected = false,
    this.decoration = const BoxDecoration(),
    this.useDisabledEffect = false,
  });
}
