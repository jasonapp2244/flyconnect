import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/screens/widgets/custom_search_field.dart';
import 'package:flyconnect/screens/widgets/custom_travel_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blue[900],

      // 🔹 Drawer
      drawer: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
        backgroundColor: ColorConstraint.redColor.withOpacity(0.75),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: ColorConstraint.redColor,
                border: Border.all(
                  width: 0,

                  color: ColorConstraint.redColor.withOpacity(0.75),
                ), // Effectively no visible border
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: ColorConstraint.whiteColor,
                    child: Icon(
                      Icons.close,
                      color: ColorConstraint.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: SvgPicture.asset('assets/icons/trips.svg'),
              title: Text(
                'My Trips',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: SvgPicture.asset('assets/icons/group.svg'),
              title: Text(
                'Groups',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: SvgPicture.asset('assets/icons/notification.svg'),

              title: Text(
                'Notifications',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: SvgPicture.asset('assets/icons/setting.svg'),
              title: Text(
                'Settings',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: SvgPicture.asset('assets/icons/phone.svg'),
              title: Text(
                'Help & Support',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: SvgPicture.asset('assets/icons/logout.svg'),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchField(
                hintTitle: "where we're going next?",
                imgPath: 'assets/icons/plane_searchbar.svg',
              ),
              CustomTravelPostWidget(
                name: "Joanna Doe",
                location: "Currently in Stockholm",
                profileImage: "assets/icons/joana_avatar.png",
                postImage: "assets/images/tale.png",
                title: "My favorite travel memory..",
                description:
                    "Wandering through the narrow streets of Kyoto during the cherry blossom season, a surreal blend of tradition and nature.",
                onMenuTap: () {
                  _scaffoldKey.currentState?.openDrawer(); // 👈 Opens drawer
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
