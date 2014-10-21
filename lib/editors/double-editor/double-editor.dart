import 'dart:html';
import '../base-editor.dart';
import 'package:polymer/polymer.dart';

@CustomTag('double-editor')
class DoubleEditor extends BaseEditor<double> {
  @observable String valueStr;
  
  valueStrChanged() {
    value = double.parse(valueStr);
  }
  
  valueChanged() {
    valueStr = value.toString();
    
    super.valueChanged();
  }
  
  DoubleEditor.created() : super.created() {}
  factory DoubleEditor() => new Element.tag('double-editor');
}