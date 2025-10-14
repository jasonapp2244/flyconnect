import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/utils/responsive.dart';

class ProfileSwipeScreen extends StatefulWidget {
  const ProfileSwipeScreen({super.key});

  @override
  State<ProfileSwipeScreen> createState() => _ProfileSwipeScreenState();
}

class _ProfileSwipeScreenState extends State<ProfileSwipeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSwiping = true;

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
                    _buildHeader(),
                    SizedBox(height: Responsive.h(3)),
                    _buildProfileCardsStack(),
                    SizedBox(height: Responsive.h(4)),
                    _buildInterestsSection(),
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
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: ColorConstraint.primaryColor,
              size: Responsive.sp(20),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildSegmentedButton('Save', !isSwiping),
                    _buildSegmentedButton('Swiping', isSwiping),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: Responsive.w(10),
            height: Responsive.w(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConstraint.primaryColor,
            ),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: Responsive.sp(16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSwiping = text == 'Swiping';
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.sp(12),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// ✅ Updated to show profile cards vertically
  Widget _buildProfileCardsStack() {
    return Column(
      children: [
        _buildProfileCard(
          name: 'Lily 18',
          airline: 'Emirates',
          imagePath: 'assets/images/lily_avatar.png',
          tags: ['Adventurous', 'Food & Drink', 'Musician'],
        ),
        SizedBox(height: Responsive.h(3)),
        _buildProfileCard(
          name: 'Joly 32',
          airline: 'flydubai',
          imagePath: 'assets/images/joly_avatar.png',
          tags: ['Adventurous', 'Food & Drink', 'Musician'],
        ),
        SizedBox(height: Responsive.h(3)),
        _buildProfileCard(
          name: 'David 42',
          airline: 'Air Arabia',
          imagePath: 'assets/images/david_avatar.png',
          tags: ['Adventurous', 'Food & Drink', 'Hiking'],
        ),
      ],
    );
  }

  Widget _buildProfileCard({
    required String name,
    required String airline,
    required String imagePath,
    required List<String> tags,
  }) {
    return Container(
      height: Responsive.h(35), // ✅ Adjusted height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: ColorConstraint.yellowColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[800],
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: Responsive.sp(60),
                    ),
                  );
                },
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: Responsive.h(2),
              left: Responsive.w(4),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: Responsive.sp(16),
                ),
              ),
            ),
            // Positioned(
            //   bottom: Responsive.h(12),
            //   left: Responsive.w(4),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         name,
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: Responsive.sp(20),
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       Text(
            //         airline,
            //         style: TextStyle(
            //           color: Colors.white.withOpacity(0.8),
            //           fontSize: Responsive.sp(14),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Positioned(
              top: Responsive.h(8),
              right: Responsive.w(4),
              child: Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Responsive.sp(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    airline,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: Responsive.sp(14),
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: tags.map((tag) {
                      Color tagColor = _getTagColor(tag);
                      return Container(
                        margin: EdgeInsets.only(bottom: Responsive.h(1)),
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.w(3),
                          vertical: Responsive.h(0.5),
                        ),
                        decoration: BoxDecoration(
                          color: tagColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Responsive.sp(10),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: Responsive.h(2),
              left: Responsive.w(4),
              right: Responsive.w(4),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: Responsive.h(5),
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Travel Buddy selected!'),
                              backgroundColor: ColorConstraint.primaryColor,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstraint.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Travel Buddy',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Responsive.sp(12),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Responsive.w(2)),
                  Expanded(
                    child: SizedBox(
                      height: Responsive.h(5),
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Date Me selected!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Date Me',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Responsive.sp(12),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTagColor(String tag) {
    switch (tag) {
      case 'Adventurous':
        return ColorConstraint.primaryColor;
      case 'Food & Drink':
        return ColorConstraint.yellowColor;
      default:
        return Colors.white.withOpacity(0.9);
    }
  }

  Widget _buildInterestsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.list_alt,
              color: ColorConstraint.primaryColor,
              size: Responsive.sp(18),
            ),
            SizedBox(width: Responsive.w(2)),
            Text(
              'Interests',
              style: TextStyle(
                color: ColorConstraint.primaryColor,
                fontSize: Responsive.sp(16),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.h(2)),
        Wrap(
          spacing: Responsive.w(2),
          runSpacing: Responsive.h(1),
          children:
              [
                'Camping',
                'Curry',
                'Socials',
                'Somewhere',
                'Want someday',
                'Christian/Other',
                'Koran',
                'Movie',
                'Socials',
                'Bachelor\'s Degree',
              ].map((interest) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.w(3),
                    vertical: Responsive.h(0.8),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    interest,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Responsive.sp(11),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
