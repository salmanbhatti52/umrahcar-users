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
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFFFFFFF).withOpacity(0.15),
            width: 0,
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
              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
              labelTextStyle: MaterialStateProperty.all(
                const TextStyle(
                  color: ConstantColor.navBarTextColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            child: NavigationBar(
              backgroundColor: Colors.white,
              selectedIndex: index,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              onDestinationSelected: (index) => setState(() {
                this.index = index;
              }),
              destinations: [
                NavigationDestination(
                  icon: SvgPicture.asset('assets/images1/home-icon.svg'),
                  selectedIcon: SvgPicture.asset(
                    'assets/images1/active-home-icon.svg',
                    width: 24,
                    height: 24,
                    color: buttonColor,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: SvgPicture.asset('assets/images1/bookings-icon.svg'),
                  selectedIcon: SvgPicture.asset(
                    'assets/images1/active-bookings-icon.svg',
                    width: 24,
                    height: 24,
                    color: buttonColor,
                  ),
                  label: 'Bookings',
                ),
                NavigationDestination(
                  icon: SvgPicture.asset('assets/images1/profile-icon.svg'),
                  selectedIcon: SvgPicture.asset(
                    'assets/images1/active-profile-icon.svg',
                    width: 24,
                    height: 24,
                    color: buttonColor,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: index,
        children: screens,
      ),
    );
  }
}
