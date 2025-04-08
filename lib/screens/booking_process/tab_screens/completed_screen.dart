import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:searchfield/searchfield.dart';
import 'package:umrahcar_user/utils/colors.dart';
import 'package:umrahcar_user/widgets/completed_list.dart';

import '../../../models/get_booking_list_model.dart';
import '../../../service/rest_api_service.dart';
import '../../homepage_screen.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({super.key});

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();

  List<String> suggestions = [
    // 'apple',
    // 'apple red',
    // 'ball',
    // 'call green',
    // 'cat',
    // 'cat blue',
  ];

  bool isFocused = false;
  GetBookingListModel getBookingCompletedResponse = GetBookingListModel();
  getBookingListUpcoming() async {
    print("phoneNmbr $phoneNmbr");
    var mapData = {"contact": phoneNmbr.toString()};
    getBookingCompletedResponse =
        await DioClient().getBookingCompleted(mapData, context);
    print("response id: ${getBookingCompletedResponse.data}");
    setState(() {});
  }

  GetBookingListModel getBookingCompletedResponseForSearch =
      GetBookingListModel();
  getBookingListOngoingSearch(String? searchText) async {
    print("phoneNmbr $phoneNmbr");
    getBookingCompletedResponseForSearch.data = [];
    var mapData = {"contact": phoneNmbr.toString(), "bookings_id": searchText};
    getBookingCompletedResponseForSearch =
        await DioClient().getBookingCompleted(mapData, context);
    print("response id: ${getBookingCompletedResponseForSearch.data}");
    setState(() {
      getBookingCompletedResponse.data = [];
    });
  }

  @override
  void initState() {
    getBookingListUpcoming();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                  marginColor: Theme.of(context).scaffoldBackgroundColor,
                  suggestionsDecoration: SuggestionDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
                    ),
                  ),
                  offset: const Offset(0, 46),
                  suggestionItemDecoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  searchInputDecoration: InputDecoration(
                    prefixIcon: SvgPicture.asset(
                      'assets/images/search-icon.svg',
                      width: 25,
                      height: 25,
                      fit: BoxFit.scaleDown,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    suffixIcon: isFocused
                        ? GestureDetector(
                      onTap: () {
                        isFocused = false;
                        searchController.clear();
                        setState(() {});
                      },
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: ConstantColor.darkgreyColor,
                      ),
                    )
                        : null,
                    hintText: "Search",
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ConstantColor.greyColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
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
                  scrollbarDecoration: ScrollbarDecoration(thumbVisibility: false),
                  suggestionState: Suggestion.hidden,
                  suggestions: suggestions.map((e) => SearchFieldListItem<String>(e)).toList(),
                  suggestionStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ConstantColor.greyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  searchStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ConstantColor.greyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            getBookingCompletedResponseForSearch.data == null &&
                        searchController.text.isEmpty ||
                    searchController.text == ""
                ? Container(
                    color: Colors.transparent,
                    height: size.height * 0.6,
                    child: RefreshIndicator(
                      color: Colors.blue,
                      onRefresh: () async {
                        getBookingListUpcoming();
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child:
                            completedList(context, getBookingCompletedResponse),
                      ),
                    ),
                  )
                : Container(
                    color: Colors.transparent,
                    height: size.height * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: completedList(
                          context, getBookingCompletedResponseForSearch),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
