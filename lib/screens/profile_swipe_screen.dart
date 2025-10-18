import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/provider/profile_swiping_provider.dart';
import 'package:flyconnect/provider/social_feed_provider.dart';

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

  // ---------- Social creation sheet (Instagram-style) ----------
  Future<void> _showCreatePostSheet() async {
    // First, show Instagram-style selection (Camera, Gallery, or Text Only)
    final ImagePicker picker = ImagePicker();

    // Show selection modal
    final String? choice = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Create New Post',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.purple.shade700,
                    ),
                  ),
                  title: const Text(
                    'Camera',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text('Take a new photo'),
                  onTap: () => Navigator.pop(ctx, 'camera'),
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.photo_library,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  title: const Text(
                    'Gallery',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text('Choose from your photos'),
                  onTap: () => Navigator.pop(ctx, 'gallery'),
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.text_fields,
                      color: Colors.orange.shade700,
                    ),
                  ),
                  title: const Text(
                    'Text Only',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text('Share your thoughts'),
                  onTap: () => Navigator.pop(ctx, 'text'),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );

    if (choice == null) return; // User cancelled

    // Handle text-only post
    if (choice == 'text') {
      _showCaptionSheet(null);
      return;
    }

    // Pick image from selected source
    final ImageSource source = choice == 'camera'
        ? ImageSource.camera
        : ImageSource.gallery;

    try {
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile == null) return; // No image selected

      final File selectedImage = File(pickedFile.path);

      // Show caption screen with the selected image
      if (!mounted) return;

      _showCaptionSheet(selectedImage);
    } catch (e) {
      // Handle error (e.g., permission denied)
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _showCaptionSheet(File? imageFile) async {
    final socialProvider = Provider.of<SocialFeedProvider>(
      context,
      listen: false,
    );
    final captionController = TextEditingController();
    final bool isTextOnly = imageFile == null;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Text(
                        isTextOnly ? 'Share Your Thoughts' : 'New Post',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          final text = captionController.text.trim();
                          if (text.isEmpty && isTextOnly) {
                            // Show error for text-only posts without text
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please write something to share',
                                ),
                                backgroundColor: Colors.orange,
                              ),
                            );
                            return;
                          }
                          socialProvider.addPost(
                            user: "You",
                            imageFile: imageFile,
                            caption: text.isEmpty ? "✈️ Travel moment" : text,
                          );
                          Navigator.pop(ctx);

                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Post shared! ✨'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        child: Text(
                          'Share',
                          style: TextStyle(
                            color: ColorConstraint.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Image preview and caption OR text-only field
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: isTextOnly
                      ? Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.orange.shade200,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.create,
                                    color: Colors.orange.shade700,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Share your travel thoughts, tips, or experiences!',
                                      style: TextStyle(
                                        color: Colors.orange.shade900,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: captionController,
                              maxLines: 8,
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText:
                                    'What\'s on your mind?\n\nShare your travel stories, tips, recommendations...',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: ColorConstraint.primaryColor,
                                    width: 2,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(16),
                              ),
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image thumbnail
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                imageFile,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Caption field
                            Expanded(
                              child: TextField(
                                controller: captionController,
                                maxLines: 5,
                                autofocus: true,
                                decoration: const InputDecoration(
                                  hintText: 'Write a caption...',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 16),
              ],
            ),
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
  const _SocialFeedWidget({required this.onCreateTap, this.themeBlue = false});

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
                    // Display image if post has one (either from file or sample image)
                    if (post.imageFile != null || _hasAssetImage(post.id))
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: Stack(
                          children: [
                            // Image display
                            if (post.imageFile != null)
                              Image.file(
                                post.imageFile!,
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            else
                              Image.asset(
                                _getPostImage(post.id),
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            // Like button overlay
                            Positioned(
                              right: 16,
                              bottom: 16,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        Provider.of<SocialFeedProvider>(
                                          context,
                                          listen: false,
                                        ).toggleLike(post.id),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        post.isLikedByMe
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: post.isLikedByMe
                                            ? Colors.red
                                            : Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${post.likes}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  GestureDetector(
                                    onTap: () =>
                                        _showCommentsSheet(context, post),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.comment_outlined,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${post.comments.length}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    // For text-only posts, show interaction buttons below
                    if (post.imageFile == null && !_hasAssetImage(post.id))
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
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
                                    : Colors.grey,
                              ),
                              onPressed: () => Provider.of<SocialFeedProvider>(
                                context,
                                listen: false,
                              ).toggleLike(post.id),
                            ),
                            Text(
                              '${post.likes}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              icon: const Icon(Icons.comment_outlined),
                              onPressed: () =>
                                  _showCommentsSheet(context, post),
                            ),
                            Text(
                              '${post.comments.length}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Text(post.caption),
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

  bool _hasAssetImage(String postId) {
    // Check if this is a sample post with an asset image
    return ['1', '2', '3', '4', '5'].contains(postId);
  }

  String _getPostImage(String postId) {
    // Map post IDs to asset images
    switch (postId) {
      case '1':
        return 'assets/images/craft_journey.png'; // Tokyo
      case '2':
        return 'assets/images/scenic_hiking.png'; // Swiss Alps
      case '3':
        return 'assets/images/revival_cafe.png'; // Bangkok food
      case '4':
        return 'assets/images/royal_palace.png'; // Santorini
      case '5':
        return 'assets/images/embark_journey.png'; // Bali
      default:
        return 'assets/images/tale.png';
    }
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
