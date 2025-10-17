import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// --- DATA MODEL ---

class ChatMessage {
  final String name;
  final String lastMessage;
  final String time;
  final String avatarUrl; // Placeholder
  final String flagCode; // Placeholder for flag
  final int unreadCount;
  final bool isRead;

  ChatMessage({
    required this.name,
    required this.lastMessage,
    required this.time,
    this.avatarUrl = 'placeholder',
    this.flagCode = 'US',
    this.unreadCount = 0,
    this.isRead = true,
  });
}
