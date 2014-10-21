import 'dart:html';
import '../base-editor.dart';
import 'package:polymer/polymer.dart';

@CustomTag('int-editor')
class IntEditor extends BaseEditor<int> {
  @observable String valueStr;
  
  valueStrChanged() {
    try {
      value = int.parse(valueStr, radix: 10);
    } on FormatException catch(e) {
      print('input currently invalid');
    }
  }
  
  valueChanged() {
    valueStr = value.toString();
    super.valueChanged();
  }
  
  IntEditor.created() : super.created() {}
  factory IntEditor() => new Element.tag('int-editor');
}