import 'dart:html';
import 'dart:mirrors';
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

@CustomTag('complex-editor')
class ComplexEditorElement extends BaseEditor<dynamic> {
  @observable List<PropertyDetails> modelVariables;
  
  ComplexEditorElement.created() : super.created() {}
  factory ComplexEditorElement() => new Element.tag('complex-editor');
  
  void ready() {
    async((_) {
      var reflectedModel = reflect(value);
      modelVariables = new List<PropertyDetails>();
      reflectedModel.type.declarations.forEach((Symbol key, DeclarationMirror decl) {
        if(decl is VariableMirror && decl.type is ClassMirror && !BaseEditor.isComplex((decl.type as ClassMirror).reflectedType)) {
          modelVariables.add(new PropertyDetails((decl.type as ClassMirror).reflectedType, reflectedModel, key));
        }
      });
    });
  }
  
  openItem(dynamic ob) {
    if(itemOpened != null) {
      itemOpened(ob);
    }
  }
}