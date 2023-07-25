import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';

class MainNav extends StatefulWidget{
  const MainNav({super.key});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: BACKGROUND_COLOR,
        title: Text("모여람"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () => {
                print("alert clicked!")
              }
          ),
        ],
      ),
      // body: ,
      bottomSheet: BottomNavigationBar(
        iconSize: 35.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: ''
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: MAIN_COLOR,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: BACKGROUND_COLOR,
      ),
    );
  }
}