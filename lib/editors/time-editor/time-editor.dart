import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:meta_edit/time.dart';
import '../base-editor.dart';

@CustomTag('time-editor')
class TimeEditor extends BaseEditor<Time> {
  @observable
  String valueStr;
  
  valueStrChanged() {
    value = new Time.parse(valueStr);
  }
  
  valueChanged() {
    if(value != null && valueStr != value.value) {
      valueStr = value.value;
    }
    
    super.valueChanged();
  }
  
  TimeEditor.created() : super.created() {}
  factory TimeEditor() => new Element.tag('time-editor')..shadowRoot.applyAuthorStyles = true;
}