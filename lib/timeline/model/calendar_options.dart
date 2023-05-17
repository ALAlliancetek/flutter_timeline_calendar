import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../utils/calendar_types.dart';

class CalendarOptions extends Model {
  bool toggleViewType;
  ViewType viewType;
  String font;
  Color? headerMonthBackColor;
  Color? headerMonthShadowColor;
  double? headerMonthElevation;
  ShapeBorder? headerMonthShape;
  Color? bottomSheetBackColor;
  DateTime? weekStartDate;
  DateTime? weekEndDate;

  CalendarOptions(
      {this.toggleViewType = false,
      this.viewType = ViewType.MONTHLY,
      this.headerMonthBackColor,
      this.headerMonthShadowColor,
      this.headerMonthElevation,
      this.headerMonthShape,
      this.font = '',
      this.bottomSheetBackColor = Colors.white,
      this.weekStartDate,
      this.weekEndDate});

  static CalendarOptions of(BuildContext context) =>
      ScopedModel.of<CalendarOptions>(context);
}
