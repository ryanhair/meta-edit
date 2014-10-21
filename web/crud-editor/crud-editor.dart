import 'package:meta_edit/demo-models.dart';
import 'package:meta_edit/date.dart';
import 'package:polymer/polymer.dart';
import 'dart:convert';

@CustomTag('crud-editor')
class CrudEditorElement extends PolymerElement {
  @observable
  List<CarLot> carlots;
  @observable
  CarLot carlot;
  @observable Project project;
  
  CrudEditorElement.created() : super.created() {
    carlot = new CarLot()
    ..name = 'Ryan\'s Auto'
    ..established = new Date.fromDateTime(new DateTime.now())
    ..phone = '801 222 2222'
    ..web = 'www.carlot.com'
    ..tags = [1, 2, 3]
    ..cars = [new Car()..vin='2lkjs90df'..make='Toyota'..model='Corolla'..year=1999];
    carlots = new List<CarLot>();
    carlots.add(carlot);
    project = new Project()
    ..name = 'Project 1'
    ..description = 'This is a project'
    ..id = '12345'
    ..screenshots = ['Screenshot 1', 'Screenshot 2', 'Screenshot 3'];
  }
  
  void printData() {
    print(JSON.encode(carlots));
  }
}
