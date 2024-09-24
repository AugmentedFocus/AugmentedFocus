import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Courses',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grade),
          label: 'Grades',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _getSelectedIndex(context),
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.black,
      onTap: (index) {
        _onItemTapped(index, context);
      },
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final route = ModalRoute.of(context)?.settings.name;
    switch (route) {
      case '/upcoming-events':
        return 0;
      case '/courses':
        return 1;
      case '/grades':
        return 2;
      case '/profile':
        return 3;
      default:
        return 1;
    }
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/upcoming-events');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/courses');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/grades');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }
}