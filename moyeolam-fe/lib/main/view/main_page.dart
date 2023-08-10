import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youngjun/common/layout/main_nav.dart';
import 'package:youngjun/common/layout/title_bar.dart';
import 'package:youngjun/main/view/settings.dart';
import '../../alarm/view/alarm_list_page.dart';
import '../../common/const/colors.dart';
import '../../friends/view/friend_list_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static List<Widget> _widgetOption = <Widget>[
    // Text("메인"),
    MainAlarmList(),
    // Text("친구설정 페이지"),
    FriendListScreen(),
    // Settings(),
    Text("세팅페이지"),
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        appBar: TitleBar(
            appBar: AppBar(),
            title: "모여람",
        ),
        body: _widgetOption.elementAt(_selectedIndex),
        bottomSheet: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 35.0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.alarm,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.group,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: ''),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: BEFORE_SELECT_ICON_COLOR,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: BACKGROUND_COLOR,
        ),
      ),
    );
  }
}
