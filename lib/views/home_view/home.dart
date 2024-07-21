import 'package:flutter/material.dart';
import 'package:mediapp/consts/colors.dart';
import 'package:mediapp/views/appointment_view/appointment_view.dart';
import 'package:mediapp/views/category_view/category_view.dart';
import 'package:mediapp/views/home_view/home_view.dart';
import 'package:mediapp/views/settings_view/settings_view.dart';
import 'package:mediapp/views/appoint_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    const HomeView(),
    const AppointmentView(),
    const CategoryView(),
    // const LoginView(),
    const SettingsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.blueColor,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        selectedItemColor: AppColors.whiteColor,
        selectedLabelStyle: const TextStyle(color: Colors.white),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   label: 'Doctor',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
