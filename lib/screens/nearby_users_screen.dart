// import 'package:flutter/material.dart';
// import 'package:flyconnect/const/colorconstraint.dart';
// import 'package:flyconnect/screens/widgets/custom_button.dart';
// import 'package:flyconnect/utils/responsive.dart';

// class NearbyUsersScreen extends StatefulWidget {
//   const NearbyUsersScreen({super.key});

//   @override
//   State<NearbyUsersScreen> createState() => _NearbyUsersScreenState();
// }

// class _NearbyUsersScreenState extends State<NearbyUsersScreen> {
//   bool showMeetingRequestModal = true; // Show modal by default for testing
//   final TextEditingController _noteController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     print("NearbyUsersScreen initialized - Modal should be visible");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1E427A), // Dark blue background
//       body: Stack(
//         children: [
//           // Main content
//           SafeArea(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 children: [
//                   _buildHeader(),

//                   _buildLocationSection(),

//                   _buildNearbyUsersSection(),
//                   SizedBox(height: Responsive.h(2)),

//                   _buildMeetingRequestModal(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Row(
//       children: [
//         Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
//         const SizedBox(width: 8),
//         Text(
//           'Explore',
//           style: TextStyle(
//             color: ColorConstraint.primaryColor,
//             fontSize: Responsive.sp(24),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildLocationSection() {
//     return Row(
//       children: [
//         Text(
//           '📍 Stockholm, Sweden',
//           style: TextStyle(
//             color: ColorConstraint.primaryColor,
//             fontSize: Responsive.sp(16),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildNearbyUsersSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Nearby Users',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: Responsive.sp(16),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: Responsive.h(2)),
//         Text(
//           'Be spontaneous and meet with fellow users around you. Tap on Avatar to connect!',
//           style: TextStyle(color: Colors.white70, fontSize: 14),
//         ),

//         // User avatars grid
//       ],
//     );
//   }

//   Widget _buildUserAvatarsGrid() {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 16,
//         childAspectRatio: 1,
//       ),
//       itemCount: 8, // Show 8 user avatars
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               showMeetingRequestModal = true;
//             });
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(color: Colors.white, width: 2),
//             ),
//             child: CircleAvatar(
//               radius: 35,
//               backgroundColor: Colors.grey[300],
//               child: Icon(Icons.person, color: Colors.grey[600], size: 35),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildMeetingRequestModal() {
//     return Container(
//       color: Color(0xFF1E427A),
//       child: Center(
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 10),
//           decoration: BoxDecoration(
//             color: const Color(0xFF2A4A7A), // Slightly lighter blue
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // User avatars - matching the image exactly
//                 SizedBox(height: Responsive.h(2)),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(8.0),
//                       height: 200.0,
//                       width: 500.0,
//                       child: Stack(
//                         children: <Widget>[
//                           Container(
//                             height: 50.0,
//                             width: 50.0,
//                             decoration: BoxDecoration(
//                               border: Border.all(),
//                               image: DecorationImage(
//                                 image: NetworkImage(
//                                   'https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png',
//                                 ),
//                                 fit: BoxFit.fill,
//                               ),
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                           Positioned(
//                             left: 40.0,
//                             child: Container(
//                               height: 50.0,
//                               width: 50.0,
//                               decoration: BoxDecoration(
//                                 border: Border.all(),
//                                 image: DecorationImage(
//                                   image: NetworkImage(
//                                     'https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png',
//                                   ),
//                                   fit: BoxFit.fill,
//                                 ),
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 // Request message - matching the image styling
//                 Text(
//                   'Send Request!',
//                   style: TextStyle(
//                     color: const Color(0xFFEEB600), // Golden yellow
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: Responsive.h(1)),
//                 Text(
//                   'You\'re sending a request to meet with Shawn.',
//                   style: TextStyle(color: Colors.white, fontSize: 14),
//                 ),
//                 SizedBox(height: Responsive.h(2)),

//                 // Personal note input - matching the image styling
//                 Container(
//                   height: 80,
//                   decoration: BoxDecoration(
//                     color: Color(0xffF1F0F4).withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: TextField(
//                     controller: _noteController,
//                     maxLines: 3,
//                     decoration: const InputDecoration(
//                       hintText: 'Add a personal note (optional)',
//                       hintStyle: TextStyle(color: Colors.grey),
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.all(16),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: Responsive.h(2)),

//                 // Send Request button - matching the image exactly
//                 CustomButton(
//                   onPressed: () {
//                     // Handle send request
//                     setState(() {
//                       showMeetingRequestModal = false;
//                     });
//                   },
//                   title: 'Send Request',
//                   bgColor: ColorConstraint.redColor,
//                 ),
//                 SizedBox(height: Responsive.h(2)),

//                 // Cancel button - matching the image styling
//                 TextButton(
//                   onPressed: () {
//                     setState(() {
//                       showMeetingRequestModal = false;
//                     });
//                   },
//                   child: Text(
//                     'Cancel',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: Responsive.sp(14),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
