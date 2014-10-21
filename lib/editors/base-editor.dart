import 'dart:mirrors';
import 'package:polymer/polymer.dart';
import 'package:meta_edit/utils.dart';
import 'complex-editor/complex-editor.dart';

typedef ValueModified<T>(T val);
typedef ItemOpened(dynamic val);

abstract class BaseEditor<T> extends PolymerElement {
  @published
  T value;
  
  ItemOpened itemOpened;
  ValueModified<T> valueModified;
  
  BaseEditor.created() : super.created() {
    this.classes.add('editor');
  }
  
  valueChanged() {
    if(valueModified != null) {
      valueModified(value);
    }
  }
  
  static Map<Type, Type> __editors;
  /**
   * map of the desired type to edit (ex: bool),
   * to the type of editor (ex: BoolEditor)
   */
  static Map<Type, Type> get _editors {
    if(__editors == null) {
      __editors = _getEditors(BaseEditor);
    }
    
    return __editors;
  }
  
  static bool hasType(Type t) {
    return _editors.keys.firstWhere((k) => inheritsFrom(t, k), orElse: () => null) != null;
  }
  
  static Type get(Type t) {
    var type = _editors.keys.firstWhere((k) => inheritsFrom(t, k), orElse: () => null);
    if(type != null) {
      return _editors[type];
    }
    return ComplexEditorElement;
  }
  
  static bool isComplex(Type t) {
    return _editors.keys.firstWhere((k) => inheritsFrom(t, k), orElse: () => null) == null;
  }
  
  factory BaseEditor.generate(Type t, dynamic defaultValue) {
    Type editorType = BaseEditor.get(t);
    var reflectedEditorType = reflectClass(editorType);
    
    var reflectedEditor = reflectedEditorType.newInstance(const Symbol(''), []);
    if(defaultValue != null) {
      reflectedEditor.setField(#value, defaultValue);
    }
    
    return reflectedEditor.reflectee;
  }
  
  static Type getEditorGenericType(Type subclass) {
    var reflectedType = reflectClass(subclass);
    while(reflectedType.superclass.qualifiedName != reflectType(Object).qualifiedName && reflectedType.qualifiedName != reflectType(BaseEditor).qualifiedName) {
      reflectedType = reflectedType.superclass;
    }
    if(reflectedType.typeArguments[0] is! ClassMirror) print(subclass);
    return (reflectedType.typeArguments[0] as ClassMirror).reflectedType;
  }
  
  /**
   * Returns a map of type to edit (ex: bool)
   * to the editor that can edit that type
   * (ex: BoolEditor) 
   */
  static Map<Type, Type> _getEditors(Type type) {
    var reflectedClass = reflectClass(type);
    Map<Type, Type> subclasses = new Map<Type, Type>();
    
    var libraries = currentMirrorSystem().libraries;
    for(Uri libraryUri in libraries.keys.where((uri) => uri.scheme != 'dart')) {
      LibraryMirror library = libraries[libraryUri];
      for(ClassMirror cls in library.declarations.values.where((i) => i is ClassMirror)) {
        if(cls.hasReflectedType && inheritsFrom(cls.reflectedType, type) && cls.reflectedType != ComplexEditorElement) {
          subclasses[getEditorGenericType(cls.reflectedType)] = cls.reflectedType;
        }
      }
    }
    
    return subclasses;
  }
  
  void enteredView() {
    this.shadowRoot.applyAuthorStyles = true;
  }
}