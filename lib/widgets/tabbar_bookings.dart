import 'package:flutter/material.dart';
import 'package:umrahcar_user/screens/booking_process/tab_screens/ongoing_screen.dart';
import 'package:umrahcar_user/screens/booking_process/tab_screens/upcoming_screen.dart';
import 'package:umrahcar_user/screens/booking_process/tab_screens/completed_screen.dart';
import 'package:umrahcar_user/utils/colors.dart';

class TabbarBookings extends StatefulWidget {
  const TabbarBookings({super.key});

  @override
  State<TabbarBookings> createState() => _TabbarBookingsState();
}

abstract class TickerProvider {}

class _TabbarBookingsState extends State<TabbarBookings>
    with TickerProviderStateMixin {
  List<String> tabs = ["On Going", "Upcoming", "Completed"];

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.93,
              height: MediaQuery.of(context).size.height * 0.070,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  indicatorColor: buttonColor,
                  isScrollable: false,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  dividerColor: Colors.transparent,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 25),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w900,
                  ),
                  unselectedLabelColor: const Color(0xFF929292),
                  unselectedLabelStyle: const TextStyle(
                    color: Color(0xFF929292),
                    fontSize: 12,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w700,
                  ),
                  tabs: const [
                    Tab(text: "On Going"),
                    Tab(text: "Upcoming"),
                    Tab(text: "Completed"),
                  ],
                ),
              )),
        ),
        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height,
          child: TabBarView(
            controller: tabController,
            children: const [
              OnGoingPage(),
              UpcomingPage(),
              CompletedPage(),
            ],
          ),
        ),
      ],
    );
  }
}
