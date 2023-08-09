import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/common/const/colors.dart';

class MainNav extends StatefulWidget {
  const MainNav({
    super.key,
    this.bodyWidgets,
  });

  final List<Widget>? bodyWidgets;

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}
//
// class HideNavBar {
//   final ScrollController controller = ScrollController();
//   final ValueNotifier<bool> visible = ValueNotifier<bool>(true);
//
//   HideNavBar() {
//     visible.value = true;
//     controller.addListener(
//       () {
//         if (controller.position.userScrollDirection ==
//             ScrollDirection.reverse) {
//           if (visible.value) {
//             visible.value = false;
//           }
//         }
//         if (controller.position.userScrollDirection ==
//             ScrollDirection.forward) {
//           if (!visible.value) {
//             visible.value = true;
//           }
//         }
//       },
//     );
//   }
//
//   void dispose(){
//     controller.dispose();
//     visible.dispose();
//   }
//
// }
