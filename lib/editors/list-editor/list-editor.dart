import 'dart:html';
import 'dart:mirrors';
import '../base-editor.dart';
import 'package:polymer/polymer.dart';

@CustomTag('list-editor')
class ListEditor extends BaseEditor<List> {
  @published Type type;
  
  ListEditor.created() : super.created() {}
  factory ListEditor() => new Element.tag('list-editor');
  
  void addItem(dynamic item) {
    value.add(item);
    observableValue = toObservable(value);
  }
  
  @observable
  ObservableList observableValue;
  
  valueChanged() {
    observableValue = toObservable(value);
    super.valueChanged();
  }
  
//  void ready() {
//    if(value == null) {
//      value = new ObservableList();
//    }
//    else {
//      value = toObservable(value);
//    }
//  }
  
  void removeItem(dynamic item) {
    value.remove(item);
    observableValue = toObservable(value);
  }
  
  void create(event, detail, target) {
    if(isSimple) {
      if(type == String) addItem('');
      else if(type == bool) addItem(false);
      else if(type == int) addItem(0);
      else if(type == num) addItem(0.0);
      else if(type == double) addItem(0.0);
    }
    else {
      var item = reflectClass(type).newInstance(const Symbol(''), []).reflectee;
      addItem(item);
      openItem(item);
    }
  }
  
  void openItem(val) {
    if(itemOpened != null) {
      itemOpened(val);
    }
  }
  
  void updateItem(data) {
    value[data['index']] = data['item'];
  }
  
  bool get isSimple {
    return [String, bool, int, num, double].contains(type);
  }
}