library date;

import 'time.dart';

class Date {
  int year;
  int month;
  int day;
  
  Date(this.year, this.month, this.day) {}
  Date.parse(String date) {
    var pieces = _parse(date);
    year = pieces[0];
    month = pieces[1];
    day = pieces[2];
  }
  Date.fromDateTime(DateTime dateTime) {
    year = dateTime.year;
    month = dateTime.month;
    day = dateTime.day;
  }
  
  String get value {
    var monthStr = month.toString();
    if(monthStr.length == 1) {
      monthStr = '0' + monthStr;
    }
    
    var dayStr = day.toString();
    if(dayStr.length == 1) {
      dayStr = '0' + dayStr;
    }
    
    return '$year-$monthStr-$dayStr';
  }
  
  void set value(val) {
    var pieces = _parse(val);
    year = pieces[0];
    month = pieces[1];
    day = pieces[2];
  }
  
  List<int> _parse(String val) {
    var pieces = val.split('-').toList();
    if(pieces[0] == '') {
      pieces = pieces.skip(1).toList();
      pieces[0] = '-' + pieces[0];
    }
    return [
      int.parse(pieces[0], radix:10),
      int.parse(pieces[1], radix:10),
      int.parse(pieces[2], radix:10)
    ];
  }
  
  operator +(Time t) {
    return new DateTime.utc(year, month, day, t.hour, t.minute, t.second);
  }
  
  operator ==(Date t) {
    return this.year == t.year && this.month == t.month && this.day == t.day;
  }
  
  DateTime toDateTime() {
    return new DateTime.utc(year, month, day, 0, 0, 0);
  }
  
  DateTime updateDateTime(DateTime datetime) {
    return new DateTime.utc(year, month, day, datetime.hour, datetime.minute, datetime.second, datetime.millisecond);
  }
  
  String toString() {
    return value;
  }
}