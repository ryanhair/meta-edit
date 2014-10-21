import 'dart:html';
import '../base-editor.dart';
import 'package:meta_edit/date.dart';
import 'package:meta_edit/time.dart';
import 'package:polymer/polymer.dart';

@CustomTag('date-time-editor')
class DateTimeEditor extends BaseEditor<DateTime> {
  @observable Date date;
  @observable Time time;
  
  dateChanged() {
    if(time == null) {
      value = date.toDateTime();
    }
    else {
      value = date + time;
    }
  }
  
  timeChanged() {
    if(date == null) {
      value = time.toDateTime();
    }
    else {
      value = date + time;      
    }
  }
  
  valueChanged() {
    if(value != null) {
      var newDate = new Date.fromDateTime(value);
      var newTime = new Time.fromDateTime(value);
      if(date != newDate) {
        date = newDate;
      }
      if(time != newTime) {
        time = newTime;
      }
    }
    super.valueChanged();
  }
  
  DateTimeEditor.created() : super.created() {
    time = new Time(0, 0, 0);
  }
  
  factory DateTimeEditor() {
    return new Element.tag('date-time-editor');
  }
}