import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flyconnect/provider/edit_profile_provider.dart';

import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EditProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Image
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
              const SizedBox(height: 20),

              // Username
              TextField(
                decoration: const InputDecoration(
                  hintText: "Username",
                  hintStyle: TextStyle(color: Colors.white54),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: provider.setUsername,
              ),
              const SizedBox(height: 16),

              // Email
              TextField(
                decoration: const InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.white54),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: provider.setEmail,
              ),
              const SizedBox(height: 16),

              // Phone
              TextField(
                decoration: const InputDecoration(
                  hintText: "Phone Number",
                  hintStyle: TextStyle(color: Colors.white54),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: provider.setPhone,
              ),
              const SizedBox(height: 16),

              // Password
              TextField(
                decoration: const InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.white54),
                ),
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                onChanged: provider.setPassword,
              ),
              const SizedBox(height: 30),

              // Update Button
              ElevatedButton(
                onPressed: () {
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
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text(
                  "Update Profile",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
