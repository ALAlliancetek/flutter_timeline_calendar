<p align="center">
<img src="https://raw.githubusercontent.com/ALAlliancetek/flutter_timeline_calendar/master/assets/flutter_timeline_calendar.png" height="400" alt="flutter Timeline Calendar Package" />
</p>

<p align="center">
<a href="https://pub.dev/packages/flutter_timeline_calendar"><img src="https://raw.githubusercontent.com/ALAlliancetek/flutter_timeline_calendar/master/assets/flutter_timline_calendar.svg" alt="Pub"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
</p>


---


# Timeline Calendar

## How to install :

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  flutter_timeline_calendar: ^1.0.0
```

Then You can install packages from the command line:
```yaml
$ pub get
```

or

```yaml
$ flutter pub get
```

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

Now in your Dart code, you can use:

```dart
import 'package:flutter_timeline_calendar/flutter_timeline_calendar.dart';
```
<p align="center">
<img src="https://raw.githubusercontent.com/ALAlliancetek/flutter_timeline_calendar/master/assets/flutter_timeline_calendar_options.png" height="600" alt="flutter Timeline Calendar Package" />
<br></p>

## Basic Usage :

You can load a full calendar .

```dart
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
          dayOptions: DayOptions(compactMode: true,weekDaySelectedColor: const Color(0xff3AC3E2)),
          headerOptions: HeaderOptions(
              weekDayStringType: WeekDayStringTypes.SHORT,
              monthStringType: MonthStringTypes.FULL,
              backgroundColor: const Color(0xff3AC3E2),
              headerTextColor: Colors.black),
          onChangeDateTime: (datetime) {
            print(datetime.getDate());
          },
        );
```

## Options :

You have many option for changes in : style , locale and structure.


| Option       	         | Type                         	        |
|------------------------|---------------------------------------|
| calendarType 	         | CalendarType ( JALALI or GREGORIAN )	 |
| calendarOptions	 	     | CalendarOptions 	                     |
| headerOptions	 	       | HeaderOptions 	                       |
| dayOptions	 	          | DayOptions 	                          |
| calendarLanguage	 	    | String(fa,en,pt) 	                    |

### Events

| Name       	        | Description                         	                                                                               |
|---------------------|---------------------------------------------------------------------------------------------------------------------|
| onInit 	            | Called when Timeline Calendar object is inserted into the tree.                                                        |
| onChangeDateTime	 	 | Return a string of new date selected like (year-month-day)	                                                         |
| onMonthChanged	 	   | When the month changes return a string of CalendarDateTime (year-month-day hour:minute:second)	                     |
| onYearChanged	 	    | When the year changes return a string of CalendarDateTime (year-month-day hour:minute:second)	                      |
| onDateTimeReset	 	  | When clicking on the reset button return a string of current CalendarDateTime (year-month-day hour:minute:second) 	 |
| onChangeViewType	 	 | When clicking on the toggleViewType return ViewType 	                                                               |

## CalendarOptions :

| Option       	            | Type                         	 | Description                                                        |
|---------------------------|--------------------------------|--------------------------------------------------------------------|
| toggleViewType 	          | bool	                          | Whether user can toggle view type between monthly and daily or not |
| viewType 	                | ViewType	                      | Default view type of Calendar Daily or Monthly                     |
| font	 	                   | String 	                       | Name of your font                                                  |
| headerMonthBackColor	 	   | Color 	                        | The background color of Calendar card                              |
| headerMonthShadowColor	 	 | Color 	                        | The shadow color of Calendar card                                  |
| headerMonthElevation	 	   | double 	                       | The elevation of shadow color Calendar card                        |
| headerMonthShape	 	       | ShapeBorder 	                  | The shape of Calendar card like(RoundedRectangleBorder)            |
| bottomSheetBackColor	 	   | Color 	                        | The background color of select month and year bottom sheet)        |

### HeaderOptions :

| Option       	      | Type                         	 | Description                          |
|---------------------|--------------------------------|--------------------------------------|
| weekDayStringType 	 | WeekDayStringTypes             | Day names FULL or SHORT              |
| MonthStringTypes 	  | MonthStringTypes 	             | Month names FULL or SHORT            |
| headerTextColor	 	  | Color 	                        | The color of Header Text             |
| navigationColor	 	  | Color 	                        | The color of Header navigation icons | 
| resetDateColor	 	   | Color 	                        | The color of reset date icon         |
| backgroundColor	 	   | Color 	                        | The color of background of header and calendar         |


### DayOptions :

| Option       	               | Type                         	 | Description                                    |
|------------------------------|--------------------------------|------------------------------------------------|
| weekDaySelectedColor	 	      | Color 	                        | The color of the Selected weekday              |
| weekDayUnselectedColor	 	    | Color 	                        | The color of the UnSelected weekday            |
| showWeekDay	 	               | bool 	                         | Whether weekdays show or not                   |
| compactMode	 	               | bool 	                         | Whether the Calendar card is compact or not    |
| selectedBackgroundColor	 	   | Color 	                        | The background color of the selected day       |
| unselectedBackgroundColor	 	 | Color 	                        | The background color of the unselected day     |
| selectedTextColor	 	         | Color 	                        | The text color of the selected day             |
| disabledTextColor	 	         | Color 	                        | The text color of the disabled day             |
| unselectedTextColor	 	       | Color 	                        | The text color of the unselected day           |
| disableFadeEffect	 	         | bool 	                         | Whether days before now has fade effect or not |
| disableDaysBeforeNow	 	      | bool 	                         | Whether days before now Disabled or not        |

## Locales :

**Timeline Calendar** supports two types of calendar now . **Gregorian** , and **Jalali** .


## Contribute :
You can help us and contribute for :
- New options
- More locales
- Better exceptions
