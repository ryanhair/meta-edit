import 'dart:html';
import 'dart:mirrors';
import 'package:polymer/polymer.dart';
import 'package:meta_edit/utils.dart' as utils;
import '../base-editor.dart';
import 'dart:async';

typedef ItemClicked (dynamic item);
typedef ItemRemoved (dynamic item);

@CustomTag('list-editor-item')
class ListEditorItem extends PolymerElement {
  @published dynamic item;
  @published Type type;
  @published int index;
  @published ItemClicked openItem;
  @published ItemRemoved itemRemoved;
  @published dynamic updateItem;
//  var onitemClicked;
  
  ListEditorItem.created() : super.created() {}
  factory ListEditorItem() => new Element.tag('list-editor-item');
  
  void ready() {
    onPropertyChange(this, #type, () => notifyPropertyChange(#isSimple, null, type));
    async((_) {
      if(isSimple == null) {
        StreamSubscription watch;
        watch = onPropertyChange(this, #type, () {
          watch.cancel();
          update();
        });
      }
      update();
      
//      editor.onOpenItem = (val) {
//        if(onOpenItem != null) {
//          onOpenItem(val);
//        }
//      };
    });
  }
  
  void update() {
    if(isSimple != null && isSimple == true) {
      Element container = $['container'];
      
      var editor = new BaseEditor.generate(item.runtimeType, item);
      container.children.add(editor);
      
      editor.valueModified = (val) {
        if(updateItem != null) {
          updateItem({
            "index": index,
            "item": val
          });
        }
      };
    }
  }
  
  void open(event, detail, target) {
    if(openItem != null) {
      openItem(item);
    }
  }
  
  void delete(event, detail, target) {
    if(itemRemoved != null) {
      itemRemoved(item);
    }
  }
  
  void enteredView() {
    this.shadowRoot.applyAuthorStyles = true;
  }
  
  bool get isSimple {
    if(type == null) return null;
    return [String, bool, int, num, double].contains(reflectClass(type).reflectedType);
  }
  
  String printVarName(d) => utils.printVarName(d);
}