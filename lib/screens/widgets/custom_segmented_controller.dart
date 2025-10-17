import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/utils/responsive.dart';
import 'package:provider/provider.dart';
import '../../provider/inbox_provider.dart';

class SegmentedTabControl extends StatelessWidget {
  const SegmentedTabControl({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InboxProvider>(context);

    Widget _buildTab(String title, int index, {Widget? badge}) {
      final isActive = provider.selectedTab == index;

      return Expanded(
        child: GestureDetector(
          onTap: () => provider.changeTab(index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isActive ? ColorConstraint.redColor : Colors.transparent,
              borderRadius: BorderRadius.circular(11),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: const Color(0xFFFF5B5B).withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isActive ? Colors.white : const Color(0xffF6F6F6),
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                    fontSize: Responsive.sp(14),
                  ),
                ),
                if (badge != null) ...[SizedBox(width: Responsive.w(2)), badge],
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0x33F1F0F4),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          _buildTab('Messages', 0),
          _buildTab(
            'Requests',
            1,
            badge: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: ColorConstraint.yellowColor,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                '7',
                style: TextStyle(
                  color: ColorConstraint.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.sp(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
