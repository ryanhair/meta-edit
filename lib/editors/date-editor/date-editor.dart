import 'dart:html';
import '../base-editor.dart';
import 'package:meta_edit/date.dart';
import 'package:polymer/polymer.dart';

@CustomTag('date-editor')
class DateEditor extends BaseEditor<Date> {  
  @observable
  String valueStr;
  
  valueStrChanged() {
    value = new Date.parse(valueStr);
  }
  
  valueChanged() {
    if(value != null && valueStr != value.value) {
      valueStr = value.value;
    }
    
    super.valueChanged();
  }
  
  DateEditor.created() : super.created() {}
  factory DateEditor() => new Element.tag('date-editor');
}