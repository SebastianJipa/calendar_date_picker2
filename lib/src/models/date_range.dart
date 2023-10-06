import 'package:flutter/material.dart';

enum DateRangeBoundary { top, bottom }

class DateRange {
  final DateTime startDate;
  final DateTime endDate;

  DateRange(this.startDate, this.endDate) {
    if (endDate.isBefore(startDate)) {
      throw ArgumentError('endDate cannot be before startDate.');
    }
  }

  @override
  String toString() => 'From: $startDate To: $endDate';

  bool contains({required DateTime date}) {
    return (date.isAfter(startDate) && date.isBefore(endDate));
  }

  DateRangeBoundary? isBoundary({required DateTime date}) {
    if (DateUtils.isSameDay(date, startDate)) {
      return DateRangeBoundary.top;
    } else if (DateUtils.isSameDay(date, endDate)) {
      return DateRangeBoundary.bottom;
    }
    return null;
  }

  bool containsRange({required DateRange dateRange}) {
    return startDate.compareTo(dateRange.startDate) <= 0 &&
        endDate.compareTo(dateRange.endDate) >= 0;
  }

  List<DateTime> getDaysInBetween() {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(DateTime(
          startDate.year,
          startDate.month,
          // In Dart you can set more than. 30 days, DateTime will do the trick
          startDate.day + i));
    }
    return days;
  }
}
