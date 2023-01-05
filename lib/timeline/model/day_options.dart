import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class DayOptions extends Model {
  Color weekDaySelectedColor;
  Color weekDayUnselectedColor;
  bool showWeekDay;
  bool compactMode;
  Color selectedBackgroundColor;
  Color unselectedBackgroundColor;
  Color selectedTextColor;
  Color disabledTextColor;
  Color unselectedTextColor;
  bool disableFadeEffect;
  bool disableDaysBeforeNow;
  double dayFontSize;

  DayOptions({
    this.weekDaySelectedColor = Colors.red,
    this.weekDayUnselectedColor = Colors.black38,
    this.selectedBackgroundColor = const Color(0xff3AC3E2),
    this.unselectedBackgroundColor = Colors.transparent,
    this.selectedTextColor = Colors.white,
    this.showWeekDay = true,
    this.compactMode = false,
    this.disableDaysBeforeNow = false,
    this.disableFadeEffect = false,
    this.disabledTextColor = Colors.grey,
    this.unselectedTextColor = Colors.black,
    this.dayFontSize = 12,
  });

  static DayOptions of(BuildContext context) => ScopedModel.of<DayOptions>(context);
}
