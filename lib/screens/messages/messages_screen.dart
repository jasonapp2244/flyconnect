import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/models/chat_model.dart';
import 'package:flyconnect/provider/inbox_provider.dart';
import 'package:flyconnect/screens/widgets/custom_inbox_list_item.dart';
import 'package:flyconnect/screens/widgets/custom_segmented_controller.dart';
import 'package:flyconnect/utils/responsive.dart';

// --- INBOX SCREEN WIDGET ---
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InboxProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildAppBar(context),
                const SizedBox(height: 16),
                const SegmentedTabControl(),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: provider.messages.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: Responsive.h(2)),
                    itemBuilder: (context, index) =>
                        CustomInboxListItem(message: provider.messages[index]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
              Text(
                'Inbox',
                style: TextStyle(
                  color: ColorConstraint.primaryColor,
                  fontSize: Responsive.sp(20),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Icon(Icons.search, color: Colors.white, size: 28),
        ],
      ),
    );
  }
}
