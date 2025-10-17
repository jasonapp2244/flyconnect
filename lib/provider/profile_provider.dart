// lib/providers/user_profile_provider.dart
import 'package:flutter/material.dart';
import 'package:flyconnect/models/user_model.dart';

class UserProfileProvider with ChangeNotifier {
  UserProfile _userProfile = UserProfile.example();

  // Public getter to allow widgets to access the profile data.
  UserProfile get userProfile => _userProfile;

  void updateProfile(UserProfile newProfile) {
    _userProfile = newProfile;

    notifyListeners();
  }

  void updateProfileCompletion(int percentage) {
    _userProfile = UserProfile(
      fullName: _userProfile.fullName,
      surname: _userProfile.surname,
      givenNames: _userProfile.givenNames,
      personalNo: _userProfile.personalNo,
      sex: _userProfile.sex,
      age: _userProfile.age,
      signature: _userProfile.signature,
      profileImageUrl: _userProfile.profileImageUrl,
      // The only field that changes:
      profileCompletionPercentage: percentage,
      travelStories: _userProfile.travelStories,
    );
    notifyListeners();
  }
}
