import 'package:flutter/material.dart';

class HookUpNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const HookUpNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<HookUpNavBar> createState() => _HookUpNavBarState();
}

class _HookUpNavBarState extends State<HookUpNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: (index) {
        widget.onTap(index); // Call the passed onTap callback
        String routeName = '';
        switch (index) {
          case 0:
            routeName = '/home'; // Replace with your Matches page route name
            break;
          case 1:
            routeName = '/requests'; // Replace with your Requests page route name
            break;
          case 2:
            routeName = '/explore'; // Replace with your Explore page route name
            break;
          case 3:
            routeName = '/profile'; // Replace with your Profile page route name
            break;
        }
        Navigator.pushNamed(context, routeName); // Navigate to the selected page
      },
      selectedItemColor: Colors.pinkAccent,
      unselectedItemColor: Colors.grey.shade600,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 8.0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.woman), // Icon for ladies
          activeIcon: Icon(Icons.woman), // Icon for when it's active
          label: 'Ladies',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_add_alt_1),
          activeIcon: Icon(Icons.person_add_alt_1),
          label: 'Requests',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          activeIcon: Icon(Icons.search_outlined),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
