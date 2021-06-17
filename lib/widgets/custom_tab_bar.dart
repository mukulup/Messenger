import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomTabBar({
    Key key,
    @required this.icons,
    @required this.selectedIndex,
    @required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.teal.shade200, width: 3.0),
        ),
      ),
      tabs: icons
          .asMap()
          .map((i, e) => MapEntry(
              i,
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Tab(
                  icon: Icon(
                    e,
                    size: 30.0,
                    color: i == selectedIndex
                        ? Colors.teal.shade200
                        : Colors.black45,
                  ),
                ),
              )))
          .values
          .toList(),
      onTap: onTap,
    );
  }
}
