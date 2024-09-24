import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.black, // Fondo negro
      selectedItemColor: Colors.white, // Color del ítem seleccionado
      unselectedItemColor: Colors.grey, // Color de los ítems no seleccionados
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Events'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Courses'),
        BottomNavigationBarItem(icon: Icon(Icons.grade), label: 'Grades'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}