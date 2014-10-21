import 'package:meta_edit/utils.dart';
import 'package:unittest/unittest.dart';

class A {
  
}

class B {
  
}

class C extends A {
  
}

class D implements B {
  
}

class E extends D implements A {
  
}

main() {
  test('InheritsFrom', () {
    assert(!inheritsFrom(B, A));
    assert(inheritsFrom(C, A));
    assert(!inheritsFrom(D, A));
    assert(inheritsFrom(D, B));
    assert(inheritsFrom(E, B));
    assert(!inheritsFrom(E, C));
  });
}