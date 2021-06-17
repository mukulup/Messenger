import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:messenger/screens/add_screen.dart';
import 'package:messenger/screens/home_screen.dart';
import 'package:messenger/screens/room_screen.dart';
import 'package:messenger/widgets/custom_tab_bar.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    RoomScreen(),
    AddScreen(),
  ];

  final List<IconData> _icons = [
    MdiIcons.home,
    MdiIcons.contacts,
    MdiIcons.plus
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        body: IndexedStack(
          children: _screens,
          index: selectedIndex,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: CustomTabBar(
            icons: _icons,
            selectedIndex: selectedIndex,
            onTap: (index) => setState(() => selectedIndex = index),
          ),
        ),
      ),
    );
  }
}
