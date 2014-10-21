library crud_editor.utils;
import 'dart:mirrors';

bool inheritsFrom(Type t, Type spr) {
  if(t == null || spr == null) return false;
  var tName = reflectType(t).qualifiedName;
  if(tName == reflectType(Object).qualifiedName) return false;
  if(tName == reflectType(spr).qualifiedName) return true;
  var rt = reflectClass(t);
  var sprt = reflectClass(spr);
  var all = new List.from(rt.superinterfaces);
  all.add(rt.superclass);
  return all.any((ClassMirror c) => inheritsFrom(c.reflectedType, spr));
}

String printVarName(val) {
  if(val == null) return 'None';
  var str = val.toString();
  if(str == '' || str == null) return 'Untitled';
  return str;
}