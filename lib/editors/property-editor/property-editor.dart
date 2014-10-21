import 'dart:html';
import 'dart:mirrors';
import '../base-editor.dart';
import 'package:meta_edit/utils.dart';
import 'package:polymer/polymer.dart';

typedef void PropertyClicked(dynamic entity);
typedef void PropertyInstantiated(dynamic details);

@CustomTag('property-editor')
class PropertyEditorElement extends PolymerElement {
  @published Symbol name;
  @published Type propertyType;
  @published InstanceMirror owner;
  @published ItemOpened itemOpened;
  
  @observable String propName;
  
  PropertyEditorElement.created() : super.created() {}
  factory PropertyEditorElement() => new Element.tag('property-editor');
  
  @observable BaseEditor editor;
  
  dynamic onModelCreated;
  dynamic onModelSelected;
  
  void ready() {
    async((_) {
      Element container = $['editor'];
      
      var val = owner.getField(name).reflectee;
      if(!BaseEditor.hasType(propertyType)) {
        var field = owner.getField(name).reflectee;
        var btn = new Element.tag('button')..classes.addAll(['btn', 'btn-link'])..text=field==null?'Add' : printVarName(field);
        btn.onClick.listen((_) => createAndOrOpenItem());
        container.children.add(btn);
      }
      else {
        var editor = new BaseEditor.generate(propertyType, val);
        
        var reflectedEditor = reflect(editor);
        reflectedEditor.setField(const Symbol('value'), val);
        if(reflectedEditor.type.declarations.containsKey(#type)) {
          reflectedEditor.setField(#type, ((owner.type.declarations[name] as VariableMirror).type.typeArguments[0] as ClassMirror).reflectedType);
        }
        container.children.add(editor);
        
        editor.valueModified = (val) {
          owner.setField(name, val);
        };
        
        editor.itemOpened = openItem;
      }
    });
    
    onPropertyChange(this, #name,  () {
      propName = MirrorSystem.getName(name);
    });
  }
  
  createAndOrOpenItem() {
    var item = owner.getField(name).reflectee;
    if(item == null) {
      item = reflectClass(propertyType).newInstance(const Symbol(''), []).reflectee;
      owner.setField(name, item);
    }
    openItem(item);
  }
  
  openItem(val) {
    if(itemOpened != null) {
      itemOpened(val);
    }
  }
  
//  openModel() {
//    if(onModelSelected != null) {
//      onModelSelected([descriptor.variableValue]);
//    }
//  }
//  
//  valueChange(var val) {
//    descriptor.variableValue = val;
//  }
//  
//  createAndOpenModel(MouseEvent evt) {
//    var reflected = descriptor.variableType.newInstance(const Symbol(""), []);
//    if(onModelCreated != null) {
//      onModelCreated([descriptor, reflected.reflectee]);
//    }
//  }
  
  void enteredView() {
    this.shadowRoot.applyAuthorStyles = true;
  }
}