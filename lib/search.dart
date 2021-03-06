import 'dart:async';
import 'advanced_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:search_widget/search_widget.dart';
import 'park.dart';
import 'main.dart';
import 'package:geolocator/geolocator.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  String selectedItem;
  Position position;

  bool nearby = false;
  double parkDistance = 1;

  void getCurrentLocation() async {
    position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  }
  void findAvailableParks(){
    int i = 0;
    while(i < parkList.length){
      if(parkList[i].address[0] >= position.latitude - (parkDistance/69.2) && parkList[i].address[0] <= position.latitude + (parkDistance/69.2)){
        if (parkList[i].address[1] >= position.longitude - (parkDistance/69.2) && parkList[i].address[1] <= position.longitude + (parkDistance/69.2)) {
          parkList[i].available = true;
        }
      }
      i++;
    }
  }

  void makeAllAvailable(){
    int i = 0;
    while(i < parkList.length){
      parkList[i].available = true;
      i++;
    }
  }
  void initState(){
    super.initState();
    getCurrentLocation();
    Timer(Duration(seconds: 1),() {findAvailableParks();});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        title: const Text('Search for parks'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Checkbox(
                  value: nearby,
                  onChanged: (value){
                    setState(() {
                      nearby = value;
                      if (nearby == true) {
                        findAvailableParks();
                      }
                      else{
                        makeAllAvailable();
                      }
                    });
                  }
              ),
              Text('Search for nearby parks?'),
              SizedBox(width: 5,),
              nearby ? Expanded(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text('Distance',style: TextStyle(fontSize: 16),),
                    Slider(
                      divisions: 18,
                      min: 0,
                      max: 9,
                      value: parkDistance,
                      onChanged: (value){
                        setState(() {
                          parkDistance = value;
                        });
                      }
                    ),
                  ],
                ),
              ):SizedBox(),
              nearby ? Column(
                children: <Widget>[
                  Text(' ',style: TextStyle(fontSize: 16),),
                  Container(
                    height: 30,
                    width: 40,
                    child: Text('$parkDistance mi.')
                  ),
                ],
              ):SizedBox(),
              SizedBox(width: 15,)
            ],
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: <Widget>[
                SearchWidget<String>(
                  dataList: parkNames,
                  hideSearchBoxWhenItemSelected: false,
                  listContainerHeight: MediaQuery.of(context).size.height / 3,
                  queryBuilder: (query, list) {
                    return list
                        .where((item) => item
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                        .toList();
                  },
                  popupListItemBuilder: (item) {
                    return PopupListItemWidget(item);
                  },
                  selectedItemBuilder: (selectedItem, deleteSelectedItem) {
                    return SelectedItemWidget(selectedItem, deleteSelectedItem);
                  },
                  // widget customization
                  textFieldBuilder: (controller, focusNode) {
                    return MyTextField(controller, focusNode);
                  },
                  onItemSelected: (item) {
                    setState(() {
                      parkNum = findParkWithTitle(item);
                      currentPark = parkList[parkNum];
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Connect()));
                    });
                  },
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => AdvancedSearch()));
                  },
                  child: Text('Advanced search', style: TextStyle(color:Colors.lightBlue[800],decoration: TextDecoration.underline),),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SelectedItemWidget extends StatelessWidget {
  const SelectedItemWidget(this.selectedItem, this.deleteSelectedItem);

  final String selectedItem;
  final VoidCallback deleteSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 12,
                bottom: 12,
              ),
              child: Text(
                selectedItem,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField(this.controller, this.focusNode);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x4437474F),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: 'Search for parks here ...',
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
          ),
        ),
      ),
    );
  }
}

class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.item);

  final String item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        item,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}