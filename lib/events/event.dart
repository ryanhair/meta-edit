library simple_event;

import 'dart:mirrors';

class InvalidEventParams extends Error {
  List<String> receivedTypes;
  InvalidEventParams(this.receivedTypes) {}
  
  toString() {
    return "Event received invalid parameters.  Received: $receivedTypes";
  }
}

class Event<T extends Function> {
  List<T> listeners;
  
  Event() {
    listeners = new List<T>();
  }
  
  call([var1=null,var2=null,var3=null,var4=null,var5=null,var6=null,var7=null,var8=null,var9=null,var10=null]) {
    var args = new List();
    
    if(var1 != null) args.add(var1);
    if(var2 != null) args.add(var2);
    if(var3 != null) args.add(var3);
    if(var4 != null) args.add(var4);
    if(var5 != null) args.add(var5);
    if(var6 != null) args.add(var6);
    if(var7 != null) args.add(var7);
    if(var8 != null) args.add(var8);
    if(var9 != null) args.add(var9);
    if(var10 != null) args.add(var10);
    
    try {
      for(T listener in listeners) {
        Function.apply(listener, args);
      }
    } on NoSuchMethodError catch(e) {
      List<String> types = new List<String>();
      for(var arg in args) {
        types.add(MirrorSystem.getName(reflect(arg).type.simpleName));
      }
      throw new InvalidEventParams(types);
    }
  }
  
  operator+(T item) {
    listeners.add(item);
    return this;
  }
  
  operator-(T item) {
    listeners.remove(item);
    return this;
  }
}