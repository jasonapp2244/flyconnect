import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/provider/edit_profile_provider.dart';
import 'package:flyconnect/screens/widgets/custom_textfield.dart';
import 'package:flyconnect/utils/responsive.dart';

import 'package:provider/provider.dart';
import 'dart:io';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EditProfileProvider>(context);

    // Text controllers for fields
    final usernameController = TextEditingController(text: provider.username);
    final emailController = TextEditingController(text: provider.email);
    final phoneController = TextEditingController(text: provider.phone);
    final passwordController = TextEditingController(text: provider.password);

    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            // 🔹 Full-screen Background Image
            Positioned.fill(
              child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
            ),

            // 🔹 Content Overlay
            Container(
              padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Image
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: provider.pickImage,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: provider.pickedImage != null
                                ? FileImage(File(provider.pickedImage!.path))
                                : null,
                            child: provider.pickedImage == null
                                ? const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.white54,
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                    Text(
                      'Username',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: Responsive.sp(13),
                      ),
                    ),
                    SizedBox(height: 5),

                    // Username
                    CustomTextField(
                      label: "Username",
                      icon: Icons.person,
                      controller: usernameController,
                    ),
                    const SizedBox(height: 16),

                    // Email
                    Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: Responsive.sp(13),
                      ),
                    ),
                    SizedBox(height: 5),

                    CustomTextField(
                      label: "Email",
                      icon: Icons.email,
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),

                    // Phone
                    Text(
                      'Phone Number',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: Responsive.sp(13),
                      ),
                    ),
                    SizedBox(height: 5),

                    CustomTextField(
                      label: "Phone Number",
                      icon: Icons.phone,
                      controller: phoneController,
                    ),
                    const SizedBox(height: 16),

                    // Password
                    Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: Responsive.sp(13),
                      ),
                    ),
                    SizedBox(height: 5),

                    CustomTextField(
                      label: "Password",
                      icon: Icons.lock,
                      controller: passwordController,
                      obscureText: true,
                      suffixIcon: Icons.visibility_off,
                    ),
                    const SizedBox(height: 30),

                    // Update Button
                    ElevatedButton(
                      onPressed: () {
                        provider.setUsername(usernameController.text);
                        provider.setEmail(emailController.text);
                        provider.setPhone(phoneController.text);
                        provider.setPassword(passwordController.text);

                        try {
                          provider.updateProfile();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Profile Updated")),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstraint.redColor,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Update Profile",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
