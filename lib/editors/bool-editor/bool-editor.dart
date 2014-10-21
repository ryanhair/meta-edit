import 'dart:html';
import 'package:polymer/polymer.dart';
import '../base-editor.dart';

@CustomTag('bool-editor')
class BoolEditor extends BaseEditor<bool> {
  BoolEditor.created() : super.created() {}
  factory BoolEditor() => new Element.tag('bool-editor');
}