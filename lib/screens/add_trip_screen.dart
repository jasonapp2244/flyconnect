import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/screens/widgets/custom_button.dart';
import 'package:flyconnect/utils/responsive.dart';

class AddTripScreen extends StatefulWidget {
  const AddTripScreen({super.key});

  @override
  State<AddTripScreen> createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  bool isCalendarSelected = true;
  DateTime selectedDate = DateTime.now();
  List<int> selectedDates = [22, 23, 30];
  List<int> eventDates = [8, 14, 19, 21];
  int currentMonth = 12;
  int currentYear = 2022;

  // Place field variables
  final TextEditingController _placeController = TextEditingController();
  final FocusNode _placeFocusNode = FocusNode();
  List<String> _placeSuggestions = [];
  bool _showSuggestions = false;

  // Sample countries/cities for suggestions
  final List<String> _places = [
    'Stockholm, Sweden',
    'Paris, France',
    'London, United Kingdom',
    'Berlin, Germany',
    'Amsterdam, Netherlands',
    'Copenhagen, Denmark',
    'Oslo, Norway',
    'Helsinki, Finland',
    'Rome, Italy',
    'Madrid, Spain',
    'Barcelona, Spain',
    'Vienna, Austria',
    'Prague, Czech Republic',
    'Budapest, Hungary',
    'Warsaw, Poland',
    'Zurich, Switzerland',
    'Brussels, Belgium',
    'Dublin, Ireland',
    'Lisbon, Portugal',
    'Athens, Greece',
    'Istanbul, Turkey',
    'Moscow, Russia',
    'Tokyo, Japan',
    'Seoul, South Korea',
    'Singapore',
    'Hong Kong',
    'Sydney, Australia',
    'Melbourne, Australia',
    'New York, USA',
    'Los Angeles, USA',
    'San Francisco, USA',
    'Chicago, USA',
    'Boston, USA',
    'Miami, USA',
    'Toronto, Canada',
    'Vancouver, Canada',
    'Montreal, Canada',
  ];

  @override
  void initState() {
    super.initState();
    _placeController.text = 'Stockholm, Sweden'; // Default value
    _placeController.addListener(_onPlaceChanged);
  }

  @override
  void dispose() {
    _placeController.dispose();
    _placeFocusNode.dispose();
    super.dispose();
  }

  void _onPlaceChanged() {
    final query = _placeController.text.toLowerCase();
    if (query.isNotEmpty) {
      setState(() {
        _placeSuggestions = _places
            .where((place) => place.toLowerCase().contains(query))
            .take(5)
            .toList();
        _showSuggestions = _placeSuggestions.isNotEmpty;
      });
    } else {
      setState(() {
        _showSuggestions = false;
        _placeSuggestions = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: const Color(0xFF1E427A), // Dark blue background
      body: GestureDetector(
        onTap: () {
          // Close suggestions when tapping outside
          setState(() {
            _showSuggestions = false;
            _placeFocusNode.unfocus();
          });
        },
        child: Stack(
          children: [
            // Top section with "My Trips" header
            _buildTopSection(),

            // White modal/dialog covering most of the screen
            Positioned(
              top: Responsive.h(25), // Start below the top section
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildWhiteModal(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.w(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Responsive.h(2)),

            // Back arrow
            Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: Responsive.sp(20),
            ),

            SizedBox(height: Responsive.h(2)),

            // "My Trips" title
            Text(
              'My Trips',
              style: TextStyle(
                color: ColorConstraint.primaryColor,
                fontSize: Responsive.sp(24),
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: Responsive.h(1)),

            // Location
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: Responsive.sp(16),
                ),
                SizedBox(width: Responsive.w(1)),
                Text(
                  'Stockholm, Sweden',
                  style: TextStyle(
                    color: Color(0xffCBCBCB),
                    fontSize: Responsive.sp(16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhiteModal() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Responsive.w(6)),
          topRight: Radius.circular(Responsive.w(6)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(Responsive.w(4)),
        child: Column(
          children: [
            // Modal Header
            _buildModalHeader(),
            SizedBox(height: Responsive.h(3)),

            // Place Input Section
            _buildPlaceSection(),
            SizedBox(height: Responsive.h(3)),

            // Date Selection Tabs
            _buildDateSelectionTabs(),
            SizedBox(height: Responsive.h(2)),

            // Calendar
            Expanded(child: _buildCalendar()),

            SizedBox(height: Responsive.h(2)),

            // Save Button
            CustomButton(
              onPressed: () {
                // Handle save and see profiles
              },
              title: 'Save and See Profiles',
              bgColor: ColorConstraint.redColor,
              width: double.infinity,
              height: 50,
            ),
            SizedBox(height: Responsive.h(2)),
          ],
        ),
      ),
    );
  }

  Widget _buildModalHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Add a Trip',
          style: TextStyle(
            color: Colors.black,
            fontSize: Responsive.sp(20),
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: Colors.black,
            size: Responsive.sp(24),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on,
              color: Colors.grey[600],
              size: Responsive.sp(16),
            ),
            SizedBox(width: Responsive.w(1)),
            Text(
              'Place',
              style: TextStyle(
                color: Colors.black,
                fontSize: Responsive.sp(16),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.h(1)),
        Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.w(3),
                vertical: Responsive.h(1.5),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                controller: _placeController,
                focusNode: _placeFocusNode,
                decoration: InputDecoration(
                  hintText: 'Search for a place...',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Responsive.sp(14),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Responsive.sp(14),
                ),
                onTap: () {
                  setState(() {
                    _showSuggestions = true;
                  });
                },
              ),
            ),

            // Suggestions dropdown
            if (_showSuggestions && _placeSuggestions.isNotEmpty)
              Positioned(
                top: Responsive.h(8),
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: _placeSuggestions.map((place) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _placeController.text = place;
                            _showSuggestions = false;
                            _placeFocusNode.unfocus();
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.w(3),
                            vertical: Responsive.h(1.5),
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[200]!,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.grey[600],
                                size: Responsive.sp(16),
                              ),
                              SizedBox(width: Responsive.w(2)),
                              Expanded(
                                child: Text(
                                  place,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Responsive.sp(14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateSelectionTabs() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isCalendarSelected = true;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Responsive.h(1.5)),
              decoration: BoxDecoration(
                color: isCalendarSelected
                    ? ColorConstraint.redColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                'Calendar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isCalendarSelected ? Colors.white : Colors.black,
                  fontSize: Responsive.sp(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: Responsive.w(2)),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isCalendarSelected = false;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Responsive.h(1.5)),
              decoration: BoxDecoration(
                color: !isCalendarSelected
                    ? ColorConstraint.redColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                'I\'m Flexible',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: !isCalendarSelected ? Colors.white : Colors.black,
                  fontSize: Responsive.sp(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendar() {
    return Container(
      height: Responsive.h(50), // Fixed height for the calendar
      padding: EdgeInsets.all(Responsive.w(3)),
      decoration: BoxDecoration(
        color: const Color(0xFFEEB600), // Golden yellow background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Month Navigation
          _buildMonthNavigation(),
          SizedBox(height: Responsive.h(2)),

          // Days of Week Header
          _buildDaysOfWeekHeader(),
          SizedBox(height: Responsive.h(1)),

          // Calendar Grid
          Expanded(child: _buildCalendarGrid()),
        ],
      ),
    );
  }

  Widget _buildMonthNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (currentMonth == 1) {
                currentMonth = 12;
                currentYear--;
              } else {
                currentMonth--;
              }
            });
          },
          child: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: Responsive.sp(24),
          ),
        ),
        Text(
          'December 2022',
          style: TextStyle(
            color: Colors.black,
            fontSize: Responsive.sp(18),
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              if (currentMonth == 12) {
                currentMonth = 1;
                currentYear++;
              } else {
                currentMonth++;
              }
            });
          },
          child: Icon(
            Icons.chevron_right,
            color: Colors.black,
            size: Responsive.sp(24),
          ),
        ),
      ],
    );
  }

  Widget _buildDaysOfWeekHeader() {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Row(
      children: days
          .map(
            (day) => Expanded(
              child: Text(
                day,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Responsive.sp(12),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCalendarGrid() {
    // December 2022 starts on Thursday (day 4)
    final firstDayOfMonth = 4; // Thursday
    final daysInMonth = 31;
    final calendarDays = <Widget>[];

    // Add empty spaces for days before the first day of the month
    for (int i = 0; i < firstDayOfMonth; i++) {
      calendarDays.add(Container());
    }

    // Add all days of the month
    for (int day = 1; day <= daysInMonth; day++) {
      calendarDays.add(_buildCalendarDay(day));
    }

    return GridView.count(
      crossAxisCount: 7,
      childAspectRatio: 1.2,
      children: calendarDays,
    );
  }

  Widget _buildCalendarDay(int day) {
    final isSelected = selectedDates.contains(day);
    final hasEvent = eventDates.contains(day);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedDates.contains(day)) {
            selectedDates.remove(day);
          } else {
            selectedDates.add(day);
          }
        });
      },
      child: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected ? ColorConstraint.redColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: Responsive.sp(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (hasEvent && !isSelected)
              Positioned(
                bottom: 2,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: ColorConstraint.redColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
