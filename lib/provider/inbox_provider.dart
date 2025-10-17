import 'package:flutter/foundation.dart';
import 'package:flyconnect/models/chat_model.dart';

class InboxProvider extends ChangeNotifier {
  int _selectedTab = 0;
  int get selectedTab => _selectedTab;

  final List<ChatMessage> _messages = [
    ChatMessage(
      name: 'Darlene Steward',
      lastMessage: 'Sent a Location Request',
      time: '18:31',
      flagCode: 'SE',
      unreadCount: 5,
      avatarUrl: 'assets/icons/darlene.png',
    ),
    ChatMessage(
      name: 'Jiggle Williamson',
      lastMessage: 'Yes, that works!',
      time: '6:12',
      flagCode: 'SE',
      avatarUrl: 'assets/icons/jiggle.png',
    ),
    ChatMessage(
      name: 'Ronald McMuffin',
      lastMessage: 'Thanks dude',
      time: 'Yesterday',
      flagCode: 'AU',
      isRead: true,
      avatarUrl: 'assets/icons/ronald.png',
    ),
    ChatMessage(
      name: 'Darlene Steward',
      lastMessage: 'Sent a Location Request',
      time: '18:31',
      flagCode: 'SE',
      unreadCount: 5,
      avatarUrl: 'assets/icons/darlene.png',
    ),
    ChatMessage(
      name: 'Jiggle Williamson',
      lastMessage: 'Yes, that works!',
      time: '6:12',
      flagCode: 'SE',
      avatarUrl: 'assets/icons/jiggle.png',
    ),
    ChatMessage(
      name: 'Ronald McMuffin',
      lastMessage: 'Thanks dude',
      time: 'Yesterday',
      flagCode: 'AU',
      isRead: true,
      avatarUrl: 'assets/icons/ronald.png',
    ),
  ];

  List<ChatMessage> get messages => _messages;

  void changeTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  void markAllAsRead() {
    for (var msg in _messages) {
      msg.unreadCount == 0;
    }
    notifyListeners();
  }
}
