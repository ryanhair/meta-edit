import 'dart:html';
import '../base-editor.dart';
import 'package:polymer/polymer.dart';

@CustomTag('file-editor')
class FileEditor extends BaseEditor<File> {
  FileUploadInputElement input;
  @observable String src;
  
  FileEditor.created() : super.created() {}
  factory FileEditor() => new Element.tag('file-editor');
  
  ready() {
    input = $['uploader'];
    async((_) {
      if(value != null) openFile();
    });
  }
  
  void updateFile() {
    value = input.files[0];
    if(value.type.startsWith('image')) {
      openFile();
    }
  }
  
  void openFile() {
    FileReader reader = new FileReader();
    
    reader.readAsDataUrl(value);
    reader.onLoadEnd.listen((evt) {
      src = reader.result;
    });
  }
}