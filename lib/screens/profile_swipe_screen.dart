import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/provider/profile_swiping_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyconnect/provider/social_feed_provider.dart';
import 'package:provider/provider.dart';

// profile_swipe_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileSwipeScreen extends StatefulWidget {
  const ProfileSwipeScreen({super.key});

  @override
  State<ProfileSwipeScreen> createState() => _ProfileSwipeScreenState();
}

class _ProfileSwipeScreenState extends State<ProfileSwipeScreen>
    with TickerProviderStateMixin {
  bool _isDatingMode = true; // toggle between Dating and Social

  @override
  Widget build(BuildContext context) {
    // ProfileSwipeProvider still created here (as before)
    return ChangeNotifierProvider(
      create: (_) => ProfileSwipeProvider(this),
      builder: (context, child) {
        final provider = context.watch<ProfileSwipeProvider>();

        return Scaffold(
          appBar: _buildAppBar(),
          backgroundColor: Colors.blue.shade800,
          // if Social mode, wrap with SocialFeedProvider for local posts
          body: _isDatingMode
              ? Stack(
                  children: [
                    _buildPageView(provider),
                    _buildProgressBar(provider),
                  ],
                )
              : ChangeNotifierProvider(
                  create: (_) => SocialFeedProvider(),
                  child: _SocialFeedWidget(
                    onCreateTap: _showCreatePostSheet,
                    themeBlue: true,
                  ),
                ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 24,
            ),
          ),
          _buildModeToggle(),
          _buildProfileIcon(),
        ],
      ),
    );
  }

  Widget _buildModeToggle() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => setState(() => _isDatingMode = false),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: !_isDatingMode
                    ? Colors.white.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Text(
                'Social',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xffB2B2B2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _isDatingMode = true),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _isDatingMode
                    ? ColorConstraint.redColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Text(
                'Dating',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xffB2B2B2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileIcon() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        image: const DecorationImage(
          image: AssetImage('assets/images/profile_pic.png'),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: Colors.blueAccent, width: 2),
      ),
    );
  }

  Widget _buildPageView(ProfileSwipeProvider provider) {
    const double horizontalPadding = 16.0;
    return PageView.builder(
      controller: provider.pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: provider.onPageChanged,
      itemCount: provider.profiles.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: _buildProfileCard(provider.profiles[index]),
        );
      },
    );
  }

  Widget _buildProgressBar(ProfileSwipeProvider provider) {
    return Positioned(
      top: 30,
      left: 16,
      right: 16,
      child: AnimatedBuilder(
        animation: provider.progressController,
        builder: (context, child) {
          return LinearProgressIndicator(
            value: provider.progressController.value,
            color: ColorConstraint.primaryColor,
            backgroundColor: Colors.white.withOpacity(0.3),
            minHeight: 4,
          );
        },
      ),
    );
  }

  Widget _buildProfileCard(Map<String, dynamic> profile) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(profile['image'], fit: BoxFit.cover),
        ),
        Positioned(
          top: 60,
          left: 10,
          child: SvgPicture.asset('assets/icons/connections.svg', width: 50),
        ),
        _buildProfileInfo(profile),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildProfileInfo(Map<String, dynamic> profile) {
    return Positioned(
      bottom: 200,
      left: 0,
      right: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "${profile['name']} ${profile['age']}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            profile['airline'],
            style: const TextStyle(color: Colors.white70, fontSize: 18),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: profile['tags'].map<Widget>((tag) {
              Color bgColor;
              final lower = tag.toLowerCase();
              if (lower.contains('adventurous')) {
                bgColor = ColorConstraint.primaryColor;
              } else if (lower.contains('food')) {
                bgColor = ColorConstraint.yellowColor;
              } else if (lower.contains('music') || lower.contains('hiking')) {
                bgColor = Colors.grey;
              } else {
                bgColor = Colors.grey.withOpacity(0.7);
              }
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: ColorConstraint.textColor,
                    fontSize: 14,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _actionButton("Travel Buddy", ColorConstraint.secondaryColor),
          const SizedBox(width: 10),
          _actionButton("Date Me", ColorConstraint.redColor),
        ],
      ),
    );
  }

  Widget _actionButton(String text, Color color) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  // ---------- Social creation sheet ----------
  Future<void> _showCreatePostSheet() async {
    final socialProvider = Provider.of<SocialFeedProvider>(
      context,
      listen: false,
    );
    final ImagePicker picker = ImagePicker();
    File? selectedImage;
    final captionController = TextEditingController();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Create Post",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        final XFile? picked = await picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 80,
                        );
                        if (picked != null) {
                          setState(() => selectedImage = File(picked.path));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200],
                        ),
                        child: selectedImage == null
                            ? const Center(
                                child: Text("Tap to pick image (optional)"),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: captionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: "Write a caption...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              final text = captionController.text.trim();
                              socialProvider.addPost(
                                user: "You",
                                imageFile: selectedImage,
                                caption: text,
                              );
                              Navigator.of(ctx).pop();
                            },
                            child: const Text("Post"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// ---------------- Social Feed widget ----------------

class _SocialFeedWidget extends StatelessWidget {
  final void Function() onCreateTap;
  final bool themeBlue;
  const _SocialFeedWidget({
    required this.onCreateTap,
    this.themeBlue = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SocialFeedProvider>(
      builder: (context, feed, _) {
        return Scaffold(
          backgroundColor: themeBlue ? Colors.blue.shade50 : Colors.white,
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorConstraint.primaryColor,
            onPressed: onCreateTap,
            child: const Icon(Icons.add),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: feed.posts.length,
            itemBuilder: (context, idx) {
              final post = feed.posts[idx];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Text(post.user.isNotEmpty ? post.user[0] : "U"),
                      ),
                      title: Text(
                        post.user,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(_formatTime(post.createdAt)),
                      trailing: PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'delete')
                            Provider.of<SocialFeedProvider>(
                              context,
                              listen: false,
                            ).deletePost(post.id);
                        },
                        itemBuilder: (_) => [
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    ),
                    if (post.imageFile != null)
                      Image.file(
                        post.imageFile!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 260,
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Text(post.caption),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              post.isLikedByMe
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: post.isLikedByMe
                                  ? Colors.red
                                  : Colors.black54,
                            ),
                            onPressed: () => Provider.of<SocialFeedProvider>(
                              context,
                              listen: false,
                            ).toggleLike(post.id),
                          ),
                          Text('${post.likes}'),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(Icons.comment_outlined),
                            onPressed: () => _showCommentsSheet(context, post),
                          ),
                          Text('${post.comments.length}'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  static String _formatTime(DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }

  void _showCommentsSheet(BuildContext context, Post post) {
    final commentController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Comments',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                child: Consumer<SocialFeedProvider>(
                  builder: (context, feed, _) {
                    final postFromProvider = feed.posts.firstWhere(
                      (p) => p.id == post.id,
                    );
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: postFromProvider.comments.length,
                      itemBuilder: (context, i) {
                        final c = postFromProvider.comments[i];
                        return ListTile(
                          title: Text(c['user'] ?? ''),
                          subtitle: Text(c['text'] ?? ''),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        decoration: const InputDecoration(
                          hintText: 'Write a comment',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        final text = commentController.text.trim();
                        if (text.isNotEmpty) {
                          Provider.of<SocialFeedProvider>(
                            context,
                            listen: false,
                          ).addComment(post.id, "You", text);
                          commentController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
