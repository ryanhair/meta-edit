library time;
import 'date.dart';

class Time {
  int hour;
  int minute;
  int second;
  
  Time(this.hour, this.minute, this.second);
  Time.parse(String time) {
    var pieces = _parse(time);
    hour = pieces[0];
    minute = pieces[1];
    if(pieces.length > 2) {
      second = pieces[2];
    }
    else {
      second = 0;
    }
  }
  Time.fromDateTime(DateTime dateTime) {
    hour = dateTime.hour;
    minute = dateTime.minute;
    second = dateTime.second;
  }
  
  String get value {
    var hourStr = hour.toString();
    if(hourStr.length == 1) {
      hourStr = '0' + hourStr;
    }
    
    var minuteStr = minute.toString();
    if(minuteStr.length == 1) {
      minuteStr = '0' + minuteStr;
    }
    
    var secondStr = second.toString();
    if(secondStr.length == 1) {
      secondStr = '0' + secondStr;
    }
    
    return '$hourStr:$minuteStr:$secondStr';
  }
  
  void set value(val) {
    var pieces = _parse(val);
    hour = pieces[0];
    minute = pieces[1];
    if(pieces.length > 2) {
      second = pieces[2];
    }
    else {
      second = 0;
    }
  }
  
  operator +(Date d) {
    return new DateTime.utc(d.year, d.month, d.day, hour, minute, second);
  }
  
  operator ==(Time t) {
    return this.hour == t.hour && this.minute == t.minute && this.second == t.second;
  }
  
  DateTime toDateTime() {
    return new DateTime.utc(0, 0, 0, hour, minute, second);
  }
  
  DateTime updateDateTime(DateTime datetime) {
    return new DateTime.utc(datetime.year, datetime.month, datetime.day, hour, minute, second);
  }
  
  List<int> _parse(String val) {
    var pieces = val.split(':');
    var data = [
      int.parse(pieces[0], radix:10),
      int.parse(pieces[1], radix:10)
    ];
    if(pieces.length > 2) {
      data.add(int.parse(pieces[2], radix:10));
    }
    return data;
  }
}