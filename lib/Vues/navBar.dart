import 'package:chatapp/Vues/Contact.dart';
import 'package:chatapp/Vues/home.dart';
import 'package:chatapp/Vues/profil.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: affiche(index),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        selectedItemColor: const Color.fromARGB(255, 241, 3, 83),
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max_outlined),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget affiche(int index) {
    if (index == 0) {
      return const Home();
    } else if (index == 1) {
      return const Contacts();
    } else {
      return const Profil();
    }
  }
}
