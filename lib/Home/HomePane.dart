import 'package:care_me/Tabs/ChatTab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Tabs/CaregiversTab.dart';
import '../Tabs/ProfileTab.dart';

class HomePane extends StatefulWidget {
  const HomePane({Key? key}) : super(key: key);

  @override
  _HomePane createState() => _HomePane();
}

class _HomePane extends State<HomePane> {
  int _currentViewIndex = 0;

  final List<Widget> _views = [
    ProfileView(),
    HealerView(),
    ChatView(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentViewIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Care Me app")),
      body: _views[_currentViewIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: CupertinoColors.white,
        onTap: onTabTapped,
        currentIndex: _currentViewIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Meu perfil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.healing),
            label: "Cuidadores",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chat",
          )
        ],
      ),
    );
  }
}
