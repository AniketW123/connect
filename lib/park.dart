import 'package:flutter/material.dart';
import 'search.dart';
class Park {
  String title;
  List<String> ageGroupsList;
  List<String> activitiesList;
  String address;
  bool litInDark;
  bool placeToSit;
  bool petFriendly;

  Park({@required String name, @required List<String> ages, @required List<String> activities, String location,
    @required bool lit, @required bool sit, @required bool pet}){
    title = name;
    ageGroupsList = ages;
    activitiesList = activities;
    address = location;
    litInDark = lit;
    placeToSit = sit;
    petFriendly = pet;
  }
}
int findParkWithTitle(String title){
  int i = 0;
  while(i < parkList.length){
    if(parkList[i].title == title){
      break;
    }
    else{i++;}
  }
  return i;
}
List<Park> parkList = [
  Park(name: 'Brookside Park', ages: ['Preschool', 'Elementary'], activities: ['Small Trail','Playground'], location: '6476 Aspen Creek, San Jose, CA',
  lit: false, sit: true, pet: true,),
  Park(name: 'Vasona Lake Park', ages: ['Elementary', 'Middle'], activities: ['Big Trail','Lake'], lit: true, sit: true, pet: true,),
  Park(name: 'Parma Park', ages: ['Preschool', 'Elementary'], activities: ['Playground','Field'], lit: true, sit: true, pet: true,),
  Park(name: 'Almaden Lake Park', ages: ['Elementary', 'Middle'], activities: ['Big Trail','Lake'], lit: true, sit: true, pet: true,),

];
List<Name> parkNames = <Name>[
  Name('Brookside Park'),
  Name('Vasona Lake Park'),
  Name('Parma Park'),
  Name('Almaden Lake Park'),

];
