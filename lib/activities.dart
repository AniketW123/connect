import 'advanced_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:search_widget/search_widget.dart';

class Activities extends StatefulWidget {
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {

  String selectedItem;
  List<String> activityList = ['Benches', 'Board Games', 'Excercise Equipment','Slide', 'Swing', 'Trail', 'Yoga'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: Colors.lightBlue[800],
        title: const Text('Activities'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            SearchWidget<String>(
              dataList: activityList,
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
                  if(whichActBox == '1'){
                    controller1.text = item;
                  }
                  else if (whichActBox == '2'){
                    controller2.text = item;
                  }
                  else{
                    print('huewhuf');
                  }
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
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
                '',
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
          hintText: 'Search for activities here ...',
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