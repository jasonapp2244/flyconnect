import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/routes/routes.dart';
import 'package:flyconnect/utils/responsive.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return SafeArea(
      child: Stack(
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
                  horizontal: Responsive.w(5),
                  vertical: Responsive.h(2),
                ),
                child: Column(
                  children: [
                    // Header Section
                    _buildHeader(),

                    // Content Area
                    Column(
                      children: [
                        _buildGroupCard(
                          'Rock Climbing',
                          'June 15, 2025, 10:00 AM',
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                          '2 min read',
                          'assets/images/rock_climbing.png',
                        ),
                        SizedBox(height: Responsive.h(3)),

                        _buildGroupCard(
                          'Scenic Hiking Trail',
                          'May 15, 2025, 02:00 AM',
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                          '3 min read',
                          'assets/images/scenic_hiking.png',
                        ),
                        SizedBox(height: Responsive.h(3)),

                        _buildGroupCard(
                          'Historical Landmark',
                          'Sep 12, 2025, 02:00 AM',
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                          '2 min read',
                          'assets/images/historical_landmark.png',
                        ),
                        SizedBox(height: Responsive.h(5)),
                        _buildGroupCard(
                          'Rock Climbing',
                          'June 15, 2025, 10:00 AM',
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                          '2 min read',
                          'assets/images/rock_climbing.png',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: Responsive.h(2)),
      decoration: BoxDecoration(),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              child: Icon(
                Icons.arrow_back_ios,
                color: ColorConstraint.primaryColor, // Light blue/teal color
                size: Responsive.sp(20),
              ),
            ),
          ),
          SizedBox(width: Responsive.w(2)),
          Text(
            'Groups',
            style: TextStyle(
              color: ColorConstraint.primaryColor, // Light blue/teal color
              fontSize: Responsive.sp(22),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupCard(
    String title,
    String date,
    String description,
    String readTime,
    String imagePath,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.eventDetail,
          arguments: {
            'title': title,
            'date': date,
            'description': description,
            'imagePath': imagePath,
          },
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: ColorConstraint.yellowColor, // Yellow border
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(Responsive.w(3)),
              ),
              child: Container(
                height: Responsive.h(15),
                width: double.infinity,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[800],
                      child: Icon(
                        Icons.image,
                        color: Colors.white,
                        size: Responsive.sp(40),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Content Section (Dark Blue Background)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.w(4),
                vertical: Responsive.h(1),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(Responsive.w(3)),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Date Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: ColorConstraint
                                .primaryColor, // Light blue/teal color
                            fontSize: Responsive.sp(12),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: Responsive.sp(12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.h(1)),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First line: description text (can wrap into 2 lines)
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: Responsive.sp(10),
                          height: 1.4,
                        ),
                        maxLines: 2, // 👈 allow up to 2 lines
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Second line: time info aligned to the right
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.end, // 👈 align to right
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.white.withOpacity(0.6),
                            size: Responsive.sp(14),
                          ),
                          SizedBox(width: Responsive.w(1)),
                          Text(
                            readTime,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: Responsive.sp(12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
