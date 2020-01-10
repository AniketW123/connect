import 'package:flutter/material.dart';

class Park {
  String title;
  List<String> ageGroupsList;
  List<String> activitiesList;
  List<double> address;
  bool litInDark;
  bool placeToSit;
  bool petFriendly;
  bool available;
  bool size;

  Park({@required String name, @required List<String> ages, @required List<String> activities, @required List<double> location,
    @required bool lit, @required bool sit, @required bool pet, @required bool isItThere,@required bool howBig,}){
    title = name;
    ageGroupsList = ages;
    activitiesList = activities;
    address = location;
    litInDark = lit;
    placeToSit = sit;
    petFriendly = pet;
    available = isItThere;
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
  Park(name: 'Almaden Lake Park', ages: ['All      ', ' '], activities: ['Big Trail','Lake'], lit: true, sit: true, pet: true, isItThere: true, location: [37.240959, -121.871850],howBig: true,),
  Park(name: 'Brookside Park', ages: ['Preschool', 'Elementary'], activities: ['Small Trail','Playground'], location: [37.218291, -121,908546],
  lit: false, sit: true, pet: true,isItThere: true, howBig: false,),
  Park(name: 'Parma Park', ages: ['Elementary', 'Middle'], activities: ['Playground','Field'], lit: true, sit: true, pet: true,isItThere: true,location: [37.221759, -121.870922],howBig: true,),
  Park(name: 'Vasona Lake Park', ages: ['All       ', ' '], activities: ['Big Trail','Lake'], lit: true, sit: true, pet: true,isItThere: true,location: [37.235038, -121.973040],howBig: true,),
];
List<String> parkNames = [
  parkList[0].available ? parkList[0].title:null,
  parkList[1].available ? parkList[1].title:null,
  parkList[2].available ? parkList[2].title:null,
  parkList[3].available ? parkList[3].title:null,
];
