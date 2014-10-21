import 'dart:html';
import '../base-editor.dart';
import 'package:polymer/polymer.dart';

@CustomTag('string-editor')
class StringEditor extends BaseEditor<String> {
  StringEditor.created() : super.created() {}
  factory StringEditor() => new Element.tag('string-editor');
}