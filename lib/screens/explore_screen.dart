import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/routes/routes.dart';
import 'package:flyconnect/screens/widgets/custom_button.dart';
import 'package:flyconnect/utils/responsive.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  bool status = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/bg.png',
            fit: BoxFit.cover,

            colorBlendMode: BlendMode.darken,
          ),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: Responsive.h(2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  _buildHeader(),
                  SizedBox(height: Responsive.h(3)),

                  // Nearby Users Section
                  _buildNearbyUsersSection(),

                  SizedBox(height: Responsive.h(3)),
                  // Group Activities Section
                  _buildGroupActivitiesSection(),
                  SizedBox(height: Responsive.h(3)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        borderWidth: 1.45,
                        borderColor: ColorConstraint.whiteColor,
                        borderRadius: 14,
                        width: 150,
                        title: 'Create group',
                        bgColor: Colors.transparent,
                        onPressed: () {},
                      ),
                      SizedBox(width: 10),

                      CustomButton(
                        borderRadius: 14,
                        width: 150,
                        textColor: Colors.black,
                        title: 'Add Group',
                        bgColor: ColorConstraint.yellowColor,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.h(3)),

                  // Local Recommendations Section
                  _buildLocalRecommendationsSection(),
                  SizedBox(height: Responsive.h(3)),

                  // Day Trips Section
                  _buildDayTripsSection(),
                  SizedBox(height: Responsive.h(5)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Explore',
              style: TextStyle(
                color: ColorConstraint.primaryColor,
                fontSize: Responsive.sp(24),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Responsive.h(0.5)),
            Row(
              children: [
                Text('📍'),
                SizedBox(width: Responsive.w(1)),
                Text(
                  'Stockholm, Sweden',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Responsive.sp(14),
                  ),
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            // Handle search tap
          },
          child: Container(
            padding: EdgeInsets.all(Responsive.w(3)),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(Responsive.w(3)),
            ),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: Responsive.sp(20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNearbyUsersSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstraint.yellowColor, width: 3),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: Responsive.w(2),
              vertical: Responsive.h(2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(Responsive.w(3)),
                  decoration: BoxDecoration(
                    color: ColorConstraint.whiteColor, // Yellow
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.flash_on,
                    color: ColorConstraint.yellowColor,
                    size: Responsive.sp(16),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nearby Users',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Responsive.sp(16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Connect with fellow Wandr users in your vicinity',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 40,
            decoration: BoxDecoration(color: ColorConstraint.primaryColor),
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: Responsive.w(2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Let other Wandr users find you?',
                    style: TextStyle(
                      color: ColorConstraint.secondaryColor,
                      fontSize: Responsive.sp(12),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  FlutterSwitch(
                    activeColor: Colors.green,
                    width: 70.0,
                    height: 30.0,
                    valueFontSize: 12.0,
                    toggleSize: 40.0,
                    value: status,
                    borderRadius: 20.0,
                    padding: 4.0,
                    showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        status = val;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupActivitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Create or join group activities',
              style: TextStyle(
                color: Colors.white,
                fontSize: Responsive.sp(14),
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Handle see all tap
              },
              child: Text(
                'See All >',
                style: TextStyle(
                  color: ColorConstraint.yellowColor, // Light orange
                  fontSize: Responsive.sp(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.h(2)),
        SizedBox(
          height: Responsive.h(30),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildActivityCard(
                'Rock Climbing',
                'June 15, 2025, 10:00 AM',
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                '2 min read',
                'assets/images/rock_climbing.png',
              ),
              _buildActivityCard(
                'Scenic Hiking Trail',
                'May 15, 2025, 02:00 AM',
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                '3 min read',
                'assets/images/scenic_hiking.png',
              ),
              _buildActivityCard(
                'History Museum Tour',
                'September 20, 2025',
                'Explore the rich history and culture of Stockholm.',
                '2 min read',
                'assets/images/historical_landmark.png',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityCard(
    String title,
    String date,
    String description,
    String readTime,
    String imagePath,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.group);
      },
      child: Container(
        width: Responsive.w(50),
        height: 250,
        margin: EdgeInsets.only(right: Responsive.w(3)),
        decoration: BoxDecoration(
          // Dark blue
          border: Border.all(color: ColorConstraint.yellowColor, width: 4),
          borderRadius: BorderRadius.circular(Responsive.w(4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(Responsive.w(4)),
              ),
              child: Container(
                height: Responsive.h(10),
                width: double.infinity,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[800],
                      child: Icon(Icons.image, color: Colors.white),
                    );
                  },
                ),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(Responsive.w(3)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.sp(14),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: Responsive.h(0.5)),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: Responsive.sp(12),
                      ),
                    ),
                    SizedBox(height: Responsive.h(1)),
                    Expanded(
                      child: Text(
                        description,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Responsive.sp(8),
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: Responsive.h(1)),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.white.withOpacity(0.6),
                          size: Responsive.sp(12),
                        ),
                        SizedBox(width: Responsive.w(1)),
                        Text(
                          readTime,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: Responsive.sp(10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocalRecommendationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '🇸🇪  Local Recommendations',
              style: TextStyle(
                color: Colors.white,
                fontSize: Responsive.sp(14),
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Handle see all tap
              },
              child: Text(
                'See All >',
                style: TextStyle(
                  color: ColorConstraint.yellowColor, // Light orange
                  fontSize: Responsive.sp(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.h(2)),
        SizedBox(
          height: Responsive.h(30),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildRecommendationCard(
                'Revival Cafe',

                'Discover a cozy spot for coffee enthusiasts.',
                '2 min read',
                'assets/images/revival_cafe.png',
              ),
              _buildRecommendationCard(
                'Scenic Hiking Trail',

                'Explore nature\'s wonders on this breathtaking trail.',
                '3 min read',
                'assets/images/scenic_hiking.png',
              ),
              _buildRecommendationCard(
                'History Museum',

                'Step into the past with this historical journey.',
                '2 min read',
                'assets/images/viking.png',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationCard(
    String title,

    String description,
    String readTime,
    String imagePath,
  ) {
    return Container(
      width: Responsive.w(50),
      height: 250,

      margin: EdgeInsets.only(right: Responsive.w(3)),
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstraint.yellowColor, width: 4),
        borderRadius: BorderRadius.circular(Responsive.w(4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with bookmark
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Responsive.w(4)),
                ),
                child: Container(
                  height: Responsive.h(12),
                  width: double.infinity,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[800],
                        child: Icon(Icons.image, color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: Responsive.h(1),
                right: Responsive.w(2),
                child: Icon(
                  Icons.bookmark_border,
                  color: Colors.white,
                  size: Responsive.sp(18),
                ),
              ),
            ],
          ),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Responsive.w(3)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Responsive.sp(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Responsive.h(0.5)),

                  Expanded(
                    child: Text(
                      description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.sp(8),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: Responsive.h(1)),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.white.withOpacity(0.6),
                        size: Responsive.sp(12),
                      ),
                      SizedBox(width: Responsive.w(1)),
                      Text(
                        readTime,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: Responsive.sp(10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayTripsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '🎡  Day Trips from Stockholm',
                  style: TextStyle(
                    color: Colors.white,

                    fontSize: Responsive.sp(14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                // Handle see all tap
              },
              child: Text(
                'See All >',
                style: TextStyle(
                  color: ColorConstraint.yellowColor, // Light orange
                  fontSize: Responsive.sp(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.h(2)),
        SizedBox(
          height: Responsive.h(30),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildDayTripCard(
                'Viking History Tour',
                'Step into the past with a day-trip to Birka.',
                '2 min read',
                'assets/images/viking.png',
              ),
              _buildDayTripCard(
                'Royal Palace Visit',
                'Discover the regal history of Drottningholm Palace just outside the city.',
                '3 min read',
                'assets/images/royal_palace.png',
              ),
              _buildDayTripCard(
                'Wall of Fame',
                'Take in Tyr for a trip down memory lane.',
                '2 min read',
                'assets/images/scenic_hiking.png',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDayTripCard(
    String title,
    String description,
    String readTime,
    String imagePath,
  ) {
    return Container(
      width: Responsive.w(50),
      height: 250,

      margin: EdgeInsets.only(right: Responsive.w(3)),
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstraint.yellowColor, width: 4),
        borderRadius: BorderRadius.circular(Responsive.w(4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with bookmark
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Responsive.w(4)),
                ),
                child: Container(
                  height: Responsive.h(12),
                  width: double.infinity,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[800],
                        child: Icon(Icons.image, color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: Responsive.h(1),
                right: Responsive.w(2),
                child: Icon(
                  Icons.bookmark_border,
                  color: Colors.white,
                  size: Responsive.sp(18),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Responsive.w(3)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Responsive.sp(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Responsive.h(0.5)),

                  Expanded(
                    child: Text(
                      description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.sp(8),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: Responsive.h(1)),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.white.withOpacity(0.6),
                        size: Responsive.sp(12),
                      ),
                      SizedBox(width: Responsive.w(1)),
                      Text(
                        readTime,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: Responsive.sp(10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
