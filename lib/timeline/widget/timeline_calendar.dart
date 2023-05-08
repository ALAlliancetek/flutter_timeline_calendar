import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/model/datetime.dart';
import 'package:flutter_timeline_calendar/timeline/provider/calendar_provider.dart';
import 'package:flutter_timeline_calendar/timeline/provider/instance_provider.dart';
import 'package:flutter_timeline_calendar/timeline/utils/calendar_types.dart';
import 'package:flutter_timeline_calendar/timeline/utils/calendar_utils.dart';
import 'package:flutter_timeline_calendar/timeline/widget/calendar_daily.dart';
import 'package:flutter_timeline_calendar/timeline/widget/calendar_monthly.dart';
import 'package:flutter_timeline_calendar/timeline/widget/header.dart';
import 'package:scoped_model/scoped_model.dart';

import '../model/calendar_options.dart';
import '../model/day_options.dart';
import '../model/headers_options.dart';

typedef CalendarChangeCallback = Function(CalendarDateTime);

class TimelineCalendar extends StatefulWidget {
  static late CalendarProvider calendarProvider;
  static late CalendarDateTime? dateTime;
  static late String calendarLanguage;
  static late CalendarType calendarType;
  CalendarChangeCallback? onChangeDateTime;
  CalendarChangeCallback? onMonthChanged;
  CalendarChangeCallback? onYearChanged;
  CalendarChangeCallback? onDateTimeReset;
  ViewTypeChangeCallback? onChangeViewType;
  CalendarOptions? calendarOptions;
  DayOptions? dayOptions;
  HeaderOptions? headerOptions;
  VoidCallback? onInit;

  TimelineCalendar({
    GlobalKey? key,
    CalendarDateTime? dateTime,
    this.calendarOptions,
    this.dayOptions,
    this.headerOptions,
    this.onChangeDateTime,
    this.onMonthChanged,
    this.onDateTimeReset,
    this.onInit,
    this.onYearChanged,
    this.onChangeViewType,
    required calendarType,
    calendarLanguage,
  }) : super(key: key) {
    calendarOptions ??= CalendarOptions();
    headerOptions ??= HeaderOptions();
    dayOptions ??= DayOptions();
    TimelineCalendar.calendarType = calendarType ?? CalendarType.GREGORIAN;
    TimelineCalendar.calendarProvider = createInstance();

    if (key?.currentContext == null ||
        calendarType != TimelineCalendar.calendarType) {
      TimelineCalendar.dateTime = dateTime ?? calendarProvider.getDateTime();
    }
    TimelineCalendar.calendarType = calendarType ?? CalendarType.GREGORIAN;
    TimelineCalendar.calendarLanguage = calendarLanguage ?? 'en';
  }

  static void init({
    CalendarDateTime? dateTime,
    String? calendarLanguage,
  }) {
    TimelineCalendar.calendarProvider = createInstance();
    TimelineCalendar.dateTime =
        dateTime ?? TimelineCalendar.calendarProvider.getDateTime();
    TimelineCalendar.calendarType = calendarType;
    TimelineCalendar.calendarLanguage = calendarLanguage ?? 'en';
  }

  @override
  State<TimelineCalendar> createState() => _TimelineCalendarState();
}

class _TimelineCalendarState extends State<TimelineCalendar> {
  @override
  void initState() {
    widget.onInit?.call();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildScopeModels(
      child: (context) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Card(
              margin: EdgeInsets.zero,
              color: CalendarOptions.of(context).headerMonthBackColor,
              shadowColor: CalendarOptions.of(context).headerMonthShadowColor,
              shape: CalendarOptions.of(context).headerMonthShape,
              elevation: CalendarOptions.of(context).headerMonthElevation,
              child: Column(
                children: [
                  Header(
                    onDateTimeReset: () {
                      widget.onDateTimeReset?.call(TimelineCalendar.dateTime!);
                      setState(() {});
                    },
                    onMonthChanged: (int selectedMonth) {
                      //Interchange below 2 lines for getting latest selected date in v1.0.6
                      CalendarUtils.goToMonth(selectedMonth);
                      if (isEventCalled(context)) {
                        widget.onMonthChanged?.call(TimelineCalendar.dateTime!);
                      }
                      setState(() {});
                    },
                    onViewTypeChanged: (ViewType viewType) {
                      setState(() {});
                      widget.onChangeViewType?.call(viewType);
                    },
                    onYearChanged: (int selectedYear) {
                      //Interchange below 2 lines for getting latest selected date in v1.0.6
                      CalendarUtils.goToYear(selectedYear);
                      if (isEventCalled(context)) {
                        widget.onYearChanged?.call(TimelineCalendar.dateTime!);
                      }
                      setState(() {});
                    },
                  ),
                  isMonthlyView()
                      ? Container(
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  color:
                                      HeaderOptions.of(context).backgroundColor,
                                  height: 150,
                                ),
                              ),
                              CalendarMonthly(onCalendarChanged: () {
                                widget.onChangeDateTime
                                    ?.call(TimelineCalendar.dateTime!);

                                setState(() {});
                              }),
                            ],
                          ),
                        )
                      : Container(
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  height: 40,
                                  color:
                                      HeaderOptions.of(context).backgroundColor,
                                ),
                              ),
                              CalendarDaily(onCalendarChanged: () {
                                widget.onChangeDateTime
                                    ?.call(TimelineCalendar.dateTime!);
                                setState(() {});
                              }),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  isMonthlyView() {
    return widget.calendarOptions?.viewType == ViewType.MONTHLY;
  }

  buildScopeModels({required WidgetBuilder child}) {
    return ScopedModel<CalendarOptions>(
      model: widget.calendarOptions!,
      child: ScopedModel<DayOptions>(
        model: widget.dayOptions!,
        child: ScopedModel<HeaderOptions>(
          model: widget.headerOptions!,
          child: Builder(builder: child),
        ),
      ),
    );
  }

  @override
  void dispose() {
    /// reset date time after disposing child
    TimelineCalendar.dateTime = TimelineCalendar.calendarProvider.getDateTime();
    // EventCalendar.dateTime = null;
    super.dispose();
  }

  bool isEventCalled(BuildContext context) {
    bool disableBeforeNow = DayOptions.of(context).disableDaysBeforeNow;
    bool disableAfterNow = DayOptions.of(context).disableDaysAfterNow;
    int currentMonth = CalendarUtils.getPartByInt(format: PartFormat.MONTH);
    int currentYear = CalendarUtils.getPartByInt(format: PartFormat.YEAR);
    int currentDay = CalendarUtils.getPartByInt(format: PartFormat.DAY);

    bool isBeforeToday =
        CalendarUtils.isBeforeThanToday(currentYear, currentMonth, currentDay);

    bool isAfterToday =
        CalendarUtils.isAfterToday(currentYear, currentMonth, currentDay);
    if (disableBeforeNow) {
      return !isBeforeToday;
    } else if (disableAfterNow) {
      return !isAfterToday;
    } else {
      return true;
    }
  }
}
