import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:searchfield/searchfield.dart';
import 'package:umrahcar_user/utils/colors.dart';
import 'package:umrahcar_user/widgets/upcoming_list.dart';

import '../../../models/get_booking_list_model.dart';
import '../../../service/rest_api_service.dart';
import '../../homepage_screen.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({super.key});

  @override
  State<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
// Controllers and Form Key
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();

// List of suggestions (you can uncomment or add more items as needed)
  List<String> suggestions = [
    // 'apple',
    // 'apple red',
    // 'ball',
    // 'call green',
    // 'cat',
    // 'cat blue',
  ];

// Variables for managing state
// Variables for managing state
  bool isFocused = false;
  GetBookingListModel?
      getBookingUpcomingResponse; // Allow null for initial state
  GetBookingListModel?
      getBookingUpcomingResponseForSearch; // Allow null for initial state

// Fetch upcoming bookings (general)
  getBookingListUpcoming() async {
    print("phoneNmbr $phoneNmbr");

    setState(() {
      isFocused = true; // Set loading state
    });

    var mapData = {"contact": phoneNmbr.toString()};

    try {
      getBookingUpcomingResponse =
          await DioClient().getBookingupcoming(mapData, context);

      // Check if the response is valid
      if (getBookingUpcomingResponse != null) {
        print("Response data: ${getBookingUpcomingResponse!.data}");
      } else {
        print("No valid response received.");
      }
    } catch (e) {
      print("Error fetching upcoming bookings: $e");
    } finally {
      setState(() {
        isFocused = false; // Unset loading state
      });
    }
  }

// Fetch bookings based on search text (filtered search)
  getBookingListOngoingSearch(String? searchText) async {
    print("phoneNmbr $phoneNmbr");

    // Clear previous search results
    getBookingUpcomingResponseForSearch = null;

    var mapData = {"contact": phoneNmbr.toString(), "bookings_id": searchText};

    setState(() {
      isFocused = true; // Set loading state
    });

    try {
      getBookingUpcomingResponseForSearch =
          await DioClient().getBookingupcoming(mapData, context);

      // Check if the response is valid
      if (getBookingUpcomingResponseForSearch != null) {
        print(
            "Search response data: ${getBookingUpcomingResponseForSearch!.data}");

        // Update main response with search results
        getBookingUpcomingResponse = getBookingUpcomingResponseForSearch;
      } else {
        print("No valid search response received.");
      }
    } catch (e) {
      print("Error during search: $e");
    } finally {
      setState(() {
        isFocused = false; // Unset loading state
      });
    }
  }

// Initialize the state, fetch the upcoming bookings on load
  @override
  void initState() {
    super.initState();
    getBookingListUpcoming(); // Fetch bookings initially
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: mainColor,
        body: Column(
          children: [
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ButtonTheme(
                alignedDropdown: true,
                child: SearchField(
                  controller: searchController,
                  inputType: TextInputType.text,
                  marginColor: mainColor,
                  suggestionsDecoration: SuggestionDecoration(
                    color: mainColor,
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 5,
                      bottom: 5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFF000000).withOpacity(0.15),
                    ),
                  ),
                  offset: const Offset(0, 46),
                  suggestionItemDecoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFFFFFFF),
                    ),
                  ),
                  searchInputDecoration: InputDecoration(
                    prefixIcon: SvgPicture.asset(
                      'assets/images/search-icon.svg',
                      width: 25,
                      height: 25,
                      fit: BoxFit.scaleDown,
                    ),
                    suffixIcon: isFocused
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                isFocused = false;
                                searchController.clear();
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              size: 20,
                              color: Color(0xFF565656),
                            ),
                          )
                        : null,
                    hintText: "Search",
                    hintStyle: const TextStyle(
                      color: Color(0xFF929292),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: const Color(0xFF000000).withOpacity(0.15),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: const Color(0xFF000000).withOpacity(0.15),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  itemHeight: 40,
                  maxSuggestionsInViewPort: 4,
                  onSearchTextChanged: (value) {
                    setState(() {
                      isFocused = true;
                      if (value.isNotEmpty) {
                        getBookingListOngoingSearch(value);
                      } else {
                        getBookingListUpcoming();
                      }
                    });
                    return null;
                  },
                  scrollbarDecoration: ScrollbarDecoration(
                    thumbVisibility: false,
                  ),
                  suggestionState: Suggestion.hidden,
                  suggestions: suggestions
                      .map((e) => SearchFieldListItem<String>(e))
                      .toList(),
                  suggestionStyle: const TextStyle(
                    color: Color(0xFF929292),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                  searchStyle: const TextStyle(
                    color: Color(0xFF929292),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            // Handling the null check and condition properly
            (getBookingUpcomingResponseForSearch?.data == null &&
                        searchController.text.isEmpty) ||
                    (searchController.text.isEmpty)
                ? Container(
                    color: Colors.transparent,
                    height: size.height * 0.6,
                    child: RefreshIndicator(
                      color: Colors.amber,
                      onRefresh: () async {
                        getBookingListUpcoming();
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: upComingList(
                            context,
                            getBookingUpcomingResponse ??
                                GetBookingListModel()),
                      ),
                    ),
                  )
                : Container(
                    color: Colors.transparent,
                    height: size.height * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: upComingList(
                          context, getBookingUpcomingResponseForSearch!),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
