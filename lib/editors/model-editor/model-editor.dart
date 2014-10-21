import 'dart:html';
import 'dart:mirrors';
import 'dart:async';
import 'package:polymer/polymer.dart';
import '../base-editor.dart';

class ModelRequiredError extends Error {
  toString() => 'Model required for model editor';
}

class PropertyDetails {
  Symbol name;
  Type property;
  InstanceMirror owner;
  
  PropertyDetails(Type this.property, InstanceMirror this.owner, [Symbol this.name = null]);
}

@CustomTag('model-editor')
class ModelEditorElement extends PolymerElement {
  @published
  dynamic model;
  
  @observable
  dynamic _currentModel;
  
  ModelEditorElement.created() : super.created() {}
  factory ModelEditorElement() => new Element.tag('model-editor');
  
  @observable
  ObservableList modelStack = new ObservableList();
  
  get breadcrumbs {
    if(modelStack.length == 0) return [];
    return modelStack.take(modelStack.length - 1);
  }
  
  void ready() {
    async((_) {
      if(model == null) {
        StreamSubscription evt;
        evt = onPropertyChange(this, #model, () {
          openModel(model);
          evt.cancel();
        });
//        throw new ModelRequiredError();
      }
      _currentModel = model;
      
      var temp = _currentModel;
      _currentModel = null;
      openModel(temp);
    });
  }
  
  openModel(dynamic ob) {
    if(_currentModel == ob) return;
    _currentModel = ob;
    var eContainerChildren = $['editor'].children..clear();

    var reflectedModel = reflect(_currentModel);
    var editor = new BaseEditor.generate(_currentModel.runtimeType, _currentModel);
    var reflectedEditor = reflect(editor);
    editor.itemOpened = openModel;
    if(reflectedEditor.type.declarations.containsKey(#type)) {
      reflectedEditor.setField(#type, (reflectedModel.type.typeArguments[0] as ClassMirror).reflectedType);
    }
    eContainerChildren.add(editor);

    var oldBreadcrumbs = breadcrumbs;
    modelStack.add(ob);
    notifyPropertyChange(#breadcrumbs, oldBreadcrumbs, breadcrumbs);
  }
  
//  createModel(ControlDescriptor descriptor, dynamic newObj) {
//    var reflected = reflect(model);
//    reflected.setField(new Symbol(descriptor.variableName), newObj);
//    model = newObj;
//    modelStack.add(newObj);
//    
////    notifyPropertyChange(#breadcrumbs, oldBreadcrumbs, breadcrumbs);
//  }
  
  popTo(MouseEvent event, var extra, var target) {
    var index = int.parse(target.attributes['index'], radix: 10);
    var model = modelStack[index];
    modelStack.removeRange(index, modelStack.length - index);
    openModel(model);
  }
  
  getType(Object ob) {
    return MirrorSystem.getName(reflect(ob).type.simpleName);
  }
}