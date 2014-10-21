import 'package:meta_edit/events/event.dart';

typedef void Helloed(Object sender, HelloedEvent e);

class HelloedEvent {
  String message;
  HelloedEvent(this.message) {}
}

main() {
  Event<Helloed> clicked = new Event<Helloed>();
  
  var fn = (Object sender, HelloedEvent e) => print('you said ${e.message}');
  clicked += fn;
  clicked += (Object sender, HelloedEvent e) => print('IMPORTANT: ${e.message}');
  
  clicked(new HelloedEvent("Hi!"));
  
  clicked -= fn;
  clicked(new HelloedEvent('You!'));
}