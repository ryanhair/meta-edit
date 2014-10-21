library demo_models;

import 'date.dart';
import 'dart:html';

class Person {
//  @Required()
  String firstName;
  
//  @Required()
  String lastName;
  
//  @Required()
//  @Matches(r'^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$')
  String email;
  
  String phone;
  
//  @DefaultValue('male')
//  @Choices(const ['male', 'female'])
  String gender;
  
  toString() {
    var str = '';
    if(firstName != null) str += firstName + ' ';
    if(lastName != null) str += lastName;
    return str;
  }
  
  toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'gender': gender
    };
  }
}

//@Model()
class Tire {
//  @Required()
  double treadState; //Between 0 and 1
  
  double size;
  
  toJson() {
    return {
      'treadState': treadState,
      'size': size
    };
  }
}

class Car {
//  @Required()
//  @Matches(r"\w{17}")
  String vin;
  
  String make;
  
  String model;
  
//  @Min(1800.0)
  int year;
  
//  @Min(0.0)
  int miles;
  
  List<Tire> tires;
  
  List<int> tags;
  
  File image;
  
  Car() {
    tires = new List<Tire>();
    tags = new List<int>();
  }
  
  toString() => '$make $model';
  toJson() {
    return {
      'vin': vin,
      'make': make,
      'model': model,
      'year': year,
      'miles': miles,
      'tires': tires,
      'tags': tags,
      'image': image != null ? image.name : ''
    };
  }
}

class CarLot {
  String name;
  
  Date established;
  
  List<Car> cars;
  
  Person owner;
  
  String web;
  
  String phone;
  
  List<Person> employees;
  
  List<int> tags;
  
  CarLot() {
    cars = new List<Car>();
    employees = new List<Person>();
    tags = new List<int>();
  }
  
  toString() => name;
  toJson() {
    return {
      'name': name,
      'established': established.toString(),
      'cars': cars,
      'owner': owner,
      'web': web,
      'phone': phone,
      'employees': employees,
      'tags': tags
    };
  }
}

class Project {
  String id;
  String name;
  String description;
  String thumbnail;
  List<String> screenshots;
  
  toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'thumbnail': thumbnail,
      'screenshots': screenshots
    };
  }
}