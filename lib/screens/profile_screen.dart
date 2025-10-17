import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/models/user_model.dart';
import 'package:flyconnect/provider/profile_provider.dart';
import 'package:flyconnect/routes/routes.dart';
import 'package:flyconnect/screens/widgets/custom_button.dart';
import 'package:flyconnect/utils/responsive.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _buildUserProfileCard(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, userProfileProvider, child) {
        final user = userProfileProvider.userProfile;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.fullName,
                    style: TextStyle(
                      fontSize: Responsive.sp(20),
                      color: ColorConstraint.whiteColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.h(3)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Image
                  Container(
                    width: 140,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(user.profileImageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // User Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(
                          'Surname',
                          user.surname,
                          'Personal No.',
                          user.personalNo,
                        ),
                        SizedBox(height: Responsive.h(3)),
                        _buildDetailRow(
                          'Given names',
                          user.givenNames,
                          'Sex',
                          user.sex,
                        ),
                        SizedBox(height: Responsive.h(3)),
                        _buildDetailRow(
                          'Age',
                          '${user.age} year',
                          'Signature',
                          user.signature,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.h(3)),
              const Text(
                'P<<<DOE<<<JOHN<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n'
                'AA1234567890<0123456789<<<<<<<<<<DD-MM-YY<<<<<<<<<<<<<<<<',
                style: TextStyle(
                  color: Color(0xffEEB600),
                  fontSize: 10,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(
    String label1,
    String value1,
    String label2,
    String value2,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label1,
                style: TextStyle(
                  color: ColorConstraint.whiteColor,
                  fontSize: Responsive.sp(10),
                ),
              ),
              Text(
                value1,
                style: TextStyle(
                  color: ColorConstraint.whiteColor,
                  fontSize: Responsive.sp(13),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label2,
                style: TextStyle(
                  color: ColorConstraint.whiteColor,
                  fontSize: Responsive.sp(13),
                ),
              ),
              label2 == 'Signature'
                  ? Text(
                      value2,
                      style: TextStyle(
                        color: Color(0xffEEB600),
                        fontSize: Responsive.sp(20),
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  : Text(
                      value2,
                      style: TextStyle(
                        color: ColorConstraint.whiteColor,
                        fontSize: Responsive.sp(13),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTravelStoryItem(TravelStory story) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: ColorConstraint.primaryColor, width: 3),
            ),
            child: Container(
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                image: DecorationImage(
                  image: AssetImage(story.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: Responsive.h(1)),
          Text(
            story.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTravelStoriesSection(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, userProfileProvider, child) {
        final stories = userProfileProvider.userProfile.travelStories;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'These are all my travel stories..',
                    style: TextStyle(
                      color: ColorConstraint.primaryColor,
                      fontSize: Responsive.sp(18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.h(2)),
              SizedBox(
                height: 100,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: stories.length,
                  itemBuilder: (context, index) =>
                      _buildTravelStoryItem(stories[index]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCompleteProfileCard(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, userProfileProvider, child) {
        final percentage =
            userProfileProvider.userProfile.profileCompletionPercentage;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffEEB600),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffEEB600).withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  '$percentage%',
                  style: TextStyle(
                    color: ColorConstraint.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Complete Your Profile!',
                      style: TextStyle(
                        color: ColorConstraint.whiteColor,
                        fontSize: Responsive.sp(13),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Share your story effortlessly and connect authentically with fellow explorers',
                      style: TextStyle(
                        color: ColorConstraint.whiteColor.withOpacity(0.5),
                        fontSize: Responsive.sp(11),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Instead of Expanded, give fixed proportion width
          SizedBox(
            width: (MediaQuery.of(context).size.width - 32 - 20) / 2,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.settings_outlined, color: Colors.white),
              label: Text(
                'Setting',
                style: TextStyle(color: ColorConstraint.whiteColor),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstraint.redColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: (MediaQuery.of(context).size.width - 32 - 20) / 2,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: Colors.white),
              label: Text(
                'Log Out',
                style: TextStyle(color: ColorConstraint.whiteColor),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstraint.redColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),

              SizedBox(width: 5),
              const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 160,
            height: 36,
            child: CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.editProfile);
              },
              title: 'Edit Profile',
              bgColor: ColorConstraint.redColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover, // ✅ Cover the full screen properly
          ),
        ),
        // If you had a gradient or decoration, set it here
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildProfileHeader(context),
                SizedBox(height: Responsive.h(1)),
                _buildUserProfileCard(context),
                SizedBox(height: Responsive.h(3)),
                _buildTravelStoriesSection(context),
                SizedBox(height: Responsive.h(3)),
                _buildCompleteProfileCard(context),
                SizedBox(height: Responsive.h(3)),
                _buildActionButtons(context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
