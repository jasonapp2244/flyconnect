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
    // sample initial post(s)
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
