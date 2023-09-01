import 'package:bwy/utils/custom_colors.dart';
import 'package:bwy/utils/navigator_utils.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: CustomColors.bwyYellow,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.black),
              onPressed: () {
                // Navigator.pushReplacementNamed(context, '/search');
                navigateToNewRoute(context, '/home', null);
              },
              iconSize: 34,
            ),
            IconButton(
              icon: Icon(Icons.dashboard, color: Colors.black),
              onPressed: () {
                // Navigator.pushReplacementNamed(context, '/search');
                navigateToNewRoute(context, '/home', null);
              },
              iconSize: 34,
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.black),
              onPressed: () {
                navigateToNewRoute(context, '/logIn', null);
                // Navigator.pushReplacementNamed(context, '/logIn');
                // Navigator.pushReplacementNamed(context, '/settings');
              },
              iconSize: 34,
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.black),
              onPressed: () {
                navigateToNewRoute(context, '/logIn', null);
                // Navigator.pushReplacementNamed(context, '/logIn');
                // Navigator.pushReplacementNamed(context, '/settings');
              },
              iconSize: 34,
            ),
          ],
        ),
      ),

      //     BottomNavigationBar(
      //   selectedItemColor: CustomColors.white,
      //   unselectedItemColor: Colors.grey,
      //   onTap: (int index) {
      //     if (index == Pages.home.index) {
      //       Navigator.pushReplacementNamed(context, '/');
      //     } else if (index == Pages.search.index) {
      //       Navigator.pushReplacementNamed(context, '/search');
      //     } else if (index == Pages.favorites.index) {
      //       Navigator.pushReplacementNamed(context, '/favorites');
      //     } else {
      //       Navigator.pushReplacementNamed(context, '/settings');
      //     }
      //   },
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      //     BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
      //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
      //   ],
      // ),
    );
  }
}
