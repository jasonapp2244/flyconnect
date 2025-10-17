// lib/models/user_profile.dart
class TravelStory {
  final String name;
  final String imageUrl;
  TravelStory({required this.name, required this.imageUrl});
}

class UserProfile {
  final String fullName;
  final String surname;
  final String givenNames;
  final String personalNo;
  final String sex;
  final int age;
  final String signature;
  final String profileImageUrl;
  final int profileCompletionPercentage;
  final List<TravelStory> travelStories;

  UserProfile({
    required this.fullName,
    required this.surname,
    required this.givenNames,
    required this.personalNo,
    required this.sex,
    required this.age,
    required this.signature,
    required this.profileImageUrl,
    required this.profileCompletionPercentage,
    required this.travelStories,
  });

  factory UserProfile.example() {
    return UserProfile(
      fullName: 'John Doe',
      surname: 'DOE',
      givenNames: 'JOHN',
      personalNo: '********',
      sex: 'M',
      age: 32,
      signature: 'John Doe',
      profileImageUrl: 'assets/images/profile_pic.png',
      profileCompletionPercentage: 40,
      travelStories: [
        TravelStory(name: 'Dubai', imageUrl: 'assets/icons/story_1.png'),
        TravelStory(name: 'Naoshima', imageUrl: 'assets/icons/story_2.png'),
        TravelStory(name: 'Greenland', imageUrl: 'assets/icons/story_3.png'),
        TravelStory(name: 'Wales', imageUrl: 'assets/icons/story_4.png'),
        TravelStory(name: 'Panama', imageUrl: 'assets/icons/story_5.png'),
      ],
    );
  }
}
