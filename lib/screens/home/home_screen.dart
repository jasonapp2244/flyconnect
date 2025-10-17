import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/screens/widgets/custom_search_field.dart';
import 'package:flyconnect/screens/widgets/custom_travel_widget.dart';
import 'package:flyconnect/utils/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
        ),

        SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent, // 👈 important

            drawer: Drawer(
              backgroundColor: ColorConstraint.redColor.withOpacity(0.75),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: ColorConstraint.redColor),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: ColorConstraint.whiteColor,
                        child: Icon(
                          Icons.close,
                          color: ColorConstraint.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  _drawerItem('assets/icons/trips.svg', 'My Trips'),
                  _drawerItem('assets/icons/group.svg', 'Groups'),
                  _drawerItem('assets/icons/notification.svg', 'Notifications'),
                  _drawerItem('assets/icons/setting.svg', 'Settings'),
                  _drawerItem('assets/icons/phone.svg', 'Help & Support'),
                  _drawerItem('assets/icons/logout.svg', 'Logout'),
                ],
              ),
            ),

            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/flyconnect.png',
                        width: 100,
                        height: 100,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/notification.svg'),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: SvgPicture.asset(
                              'assets/icons/hamburger.svg',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.h(4)),
                  CustomSearchField(
                    hintTitle: "where we're going next?",
                    imgPath: 'assets/icons/plane_searchbar.svg',
                  ),
                  SizedBox(height: Responsive.h(3)),
                  CustomTravelPostWidget(
                    name: "Joanna Doe",
                    location: "Currently in Stockholm",
                    profileImage: "assets/icons/joana_avatar.png",
                    postImage: "assets/images/tale.png",
                    title: "My favorite travel memory..",
                    description:
                        "Wandering through the narrow streets of Kyoto during the cherry blossom season, a surreal blend of tradition and nature.",
                    onMenuTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _drawerItem(String iconPath, String title) {
    return ListTile(
      leading: SvgPicture.asset(iconPath),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
