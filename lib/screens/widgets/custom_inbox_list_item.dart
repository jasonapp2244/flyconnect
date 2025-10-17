import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/models/chat_model.dart';

import '../../utils/responsive.dart' show Responsive;

class CustomInboxListItem extends StatelessWidget {
  final ChatMessage message;
  const CustomInboxListItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final bool isUnread = message.unreadCount > 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color(0x33F1F0F4),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          _buildAvatarWithFlag(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.name,
                  style: TextStyle(
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                    fontSize: 16,
                    color: ColorConstraint.primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (message.isRead)
                      const Icon(
                        Icons.done_all,
                        color: Colors.white54,
                        size: 16,
                      ),
                    Expanded(
                      child: Text(
                        message.lastMessage,
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: Responsive.sp(13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message.time,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (message.unreadCount > 0)
                _buildUnreadBadge(message.unreadCount),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarWithFlag() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage(message.avatarUrl),
        ),
        Positioned(
          right: -4,
          bottom: -4,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '🇸🇪', // you can map flags dynamically
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUnreadBadge(int count) {
    return Container(
      width: 22,
      height: 22,
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: ColorConstraint.redColor,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        count.toString(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: Responsive.sp(10),
        ),
      ),
    );
  }
}
