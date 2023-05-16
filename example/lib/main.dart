import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/model/calendar_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/datetime.dart';
import 'package:flutter_timeline_calendar/timeline/model/day_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/headers_options.dart';
import 'package:flutter_timeline_calendar/timeline/provider/instance_provider.dart';
import 'package:flutter_timeline_calendar/timeline/utils/calendar_types.dart';
import 'package:flutter_timeline_calendar/timeline/widget/timeline_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Timeline Calendar Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Timeline Calendar Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CalendarDateTime selectedDateTime;
  @override
  void initState() {
    super.initState();
    TimelineCalendar.calendarProvider = createInstance();
    selectedDateTime = TimelineCalendar.calendarProvider.getDateTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _timelineCalendar(),
        ],
      ),
    );
  }

  _timelineCalendar() {
    return TimelineCalendar(
      calendarType: CalendarType.GREGORIAN,
      calendarLanguage: "en",
      calendarOptions: CalendarOptions(
        viewType: ViewType.DAILY,
        toggleViewType: true,
        headerMonthElevation: 10,
        headerMonthShadowColor: Colors.black26,
        headerMonthBackColor: Colors.transparent,
      ),
      dayOptions: DayOptions(
          compactMode: true,
          dayFontSize: 14.0,
          disableFadeEffect: true,
          weekDaySelectedColor: const Color(0xff3AC3E2),
          differentStyleForToday: true,
          todayBackgroundColor: Colors.black,
          todayTextColor: Colors.white),
      headerOptions: HeaderOptions(
          weekDayStringType: WeekDayStringTypes.SHORT,
          monthStringType: MonthStringTypes.FULL,
          backgroundColor: const Color(0xff3AC3E2),
          headerTextSize: 14,
          headerTextColor: Colors.black),
      onChangeDateTime: (dateTime) {
        print("Date Change $dateTime");
        selectedDateTime = dateTime;
      },
      onDateTimeReset: (resetDateTime) {
        print("Date Reset $resetDateTime");
        selectedDateTime = resetDateTime;
      },
      onMonthChanged: (monthDateTime) {
        print("Month Change $monthDateTime");
        selectedDateTime = monthDateTime;
      },
      onYearChanged: (yearDateTime) {
        print("Year Change $yearDateTime");
        selectedDateTime = yearDateTime;
      },
      dateTime: selectedDateTime,
    );
  }
}
