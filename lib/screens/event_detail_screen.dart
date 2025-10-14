import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/utils/responsive.dart';

class EventDetailScreen extends StatefulWidget {
  final String title;
  final String date;
  final String description;
  final String imagePath;

  const EventDetailScreen({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.imagePath,
  });

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
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
              child: Column(
                children: [
                  // Header Section
                  _buildHeader(),

                  // Main Content
                  _buildMainContent(),
                ],
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
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(5),
        vertical: Responsive.h(2),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              child: Icon(
                Icons.arrow_back_ios,
                color: ColorConstraint.primaryColor,
                size: Responsive.sp(20),
              ),
            ),
          ),
          SizedBox(width: Responsive.w(2)),
          Expanded(
            child: Text(
              widget.title,
              style: TextStyle(
                color: ColorConstraint.primaryColor,

                fontSize: Responsive.sp(22),
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Responsive.w(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),

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
              height: Responsive.h(25),
              width: double.infinity,
              child: Image.asset(
                widget.imagePath,
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
          SizedBox(height: 20),
          // Content Section
          Container(
            width: double.infinity,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date and Time (directly below image, no icon)
                Text(
                  widget.date,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Responsive.sp(14),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: Responsive.h(2)),

                // First Lorem Ipsum paragraph
                Text(
                  widget.description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: Responsive.sp(12),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: Responsive.h(1)),

                // Second Lorem Ipsum paragraph
                Text(
                  'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: Responsive.sp(12),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: Responsive.h(2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
