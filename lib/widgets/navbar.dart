import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar_user/utils/colors.dart';
import 'package:umrahcar_user/screens/profile_screen.dart';
import 'package:umrahcar_user/screens/homepage_screen.dart';
import 'package:umrahcar_user/screens/booking_process/bookings_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;
  final screens = const [
    HomePage(),
    BookingsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorShape: const CircleBorder(),
              indicatorColor: Colors.transparent,
              labelTextStyle: MaterialStateProperty.all(
                TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat-Regular',
                ),
              ),
            ),
            child: NavigationBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedIndex: index,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              onDestinationSelected: (index) => setState(() {
                this.index = index;
              }),
              destinations: [
                NavigationDestination(
                  icon: SvgPicture.asset('assets/images/home-icon.svg',
                      color: Theme.of(context).colorScheme.onSurface,),
                  selectedIcon:
                      SvgPicture.asset('assets/images/active-home-icon.svg', color: Theme.of(context).primaryColor,),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: SvgPicture.asset('assets/images/bookings-icon.svg'
                      , color: Theme.of(context).colorScheme.onSurface,),
                  selectedIcon: SvgPicture.asset(
                      'assets/images/active-bookings-icon.svg', color: Theme.of(context).primaryColor,),
                  label: 'Bookings',
                ),
                NavigationDestination(
                  icon: SvgPicture.asset('assets/images/profile-icon.svg',
                      color: Theme.of(context).colorScheme.onSurface,),
                  selectedIcon:
                      SvgPicture.asset('assets/images/active-profile-icon.svg', color: Theme.of(context).primaryColor,),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
      body: screens[index],
    );
  }
}
