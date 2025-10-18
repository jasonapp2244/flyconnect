import 'dart:io';
import 'package:flutter/material.dart';

class Post {
  final String id;
  final String user;
  final File? imageFile; // can be null if only text
  final String caption;
  final DateTime createdAt;
  int likes;
  final List<Map<String, String>> comments; // [{user:..., text:...}]
  bool isLikedByMe;

  Post({
    required this.id,
    required this.user,
    required this.imageFile,
    required this.caption,
    required this.createdAt,
    this.likes = 0,
    List<Map<String, String>>? comments,
    this.isLikedByMe = false,
  }) : comments = comments ?? [];
}

class SocialFeedProvider extends ChangeNotifier {
  final List<Post> _posts = [
    // Sample posts for Instagram-like feed
    Post(
      id: '1',
      user: 'TravelLover23',
      imageFile: null, // Will be handled by asset images
      caption:
          'Just landed in Tokyo! 🇯🇵 The cherry blossoms are absolutely stunning this year. Can\'t wait to explore the city! #Tokyo #Travel #CherryBlossoms',
      createdAt: DateTime.now().subtract(Duration(hours: 2)),
      likes: 42,
      comments: [
        {
          'user': 'Wanderlust99',
          'text': 'Amazing shot! I\'m planning to visit next month',
        },
        {'user': 'PhotoPro', 'text': 'The colors are incredible!'},
      ],
    ),
    Post(
      id: '2',
      user: 'AdventureSeeker',
      imageFile: null,
      caption:
          'Hiking through the Swiss Alps today! 🏔️ The views are absolutely breathtaking. Nature never fails to amaze me. #Switzerland #Hiking #Mountains #Nature',
      createdAt: DateTime.now().subtract(Duration(hours: 5)),
      likes: 89,
      comments: [
        {'user': 'MountainClimber', 'text': 'Which trail did you take?'},
        {'user': 'NatureLover', 'text': 'Stunning views!'},
      ],
    ),
    Post(
      id: '3',
      user: 'FoodieExplorer',
      imageFile: null,
      caption:
          'Found this amazing street food in Bangkok! 🍜 The flavors are incredible. Sometimes the best meals come from the most unexpected places. #Bangkok #StreetFood #Foodie',
      createdAt: DateTime.now().subtract(Duration(hours: 8)),
      likes: 156,
      comments: [
        {'user': 'FoodCritic', 'text': 'That looks delicious!'},
        {'user': 'TravelFoodie', 'text': 'Where exactly is this place?'},
        {
          'user': 'BangkokLocal',
          'text': 'I know this spot! Best pad thai in the city',
        },
      ],
    ),
    Post(
      id: '4',
      user: 'CityExplorer',
      imageFile: null,
      caption:
          'Sunset in Santorini! 🌅 There\'s something magical about Greek sunsets. The colors are so vibrant and peaceful. #Santorini #Greece #Sunset #Travel',
      createdAt: DateTime.now().subtract(Duration(days: 1)),
      likes: 203,
      comments: [
        {'user': 'SunsetLover', 'text': 'This is my dream destination!'},
        {'user': 'GreekTraveler', 'text': 'Welcome to Greece! 🇬🇷'},
      ],
    ),
    Post(
      id: '5',
      user: 'BeachVibes',
      imageFile: null,
      caption:
          'Morning coffee with a view in Bali! ☕️ Starting the day right with this incredible ocean view. Sometimes you just need to slow down and appreciate the moment. #Bali #Coffee #OceanView #MorningVibes',
      createdAt: DateTime.now().subtract(Duration(days: 2)),
      likes: 78,
      comments: [
        {'user': 'CoffeeLover', 'text': 'Perfect way to start the day!'},
        {'user': 'BaliExplorer', 'text': 'Which cafe is this?'},
      ],
    ),
  ];

  List<Post> get posts => List.unmodifiable(_posts.reversed); // newest first

  void addPost({
    required String user,
    File? imageFile,
    required String caption,
  }) {
    final newPost = Post(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      user: user,
      imageFile: imageFile,
      caption: caption,
      createdAt: DateTime.now(),
    );
    _posts.add(newPost);
    notifyListeners();
  }

  void toggleLike(String postId) {
    final idx = _posts.indexWhere((p) => p.id == postId);
    if (idx == -1) return;
    final p = _posts[idx];
    if (p.isLikedByMe) {
      p.isLikedByMe = false;
      p.likes = (p.likes > 0) ? p.likes - 1 : 0;
    } else {
      p.isLikedByMe = true;
      p.likes = p.likes + 1;
    }
    notifyListeners();
  }

  void addComment(String postId, String user, String text) {
    final idx = _posts.indexWhere((p) => p.id == postId);
    if (idx == -1) return;
    _posts[idx].comments.add({'user': user, 'text': text});
    notifyListeners();
  }

  void deletePost(String postId) {
    _posts.removeWhere((p) => p.id == postId);
    notifyListeners();
  }
}
