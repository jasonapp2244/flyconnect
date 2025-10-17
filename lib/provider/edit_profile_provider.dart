import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileProvider extends ChangeNotifier {
  // --- User profile data ---
  String _username = '';
  String _email = '';
  String _phone = '';
  String _password = '';
  XFile? _pickedImage;

  // --- Getters ---
  String get username => _username;
  String get email => _email;
  String get phone => _phone;
  String get password => _password;
  XFile? get pickedImage => _pickedImage;

  // --- Setters / updaters ---
  void setUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPhone(String value) {
    _phone = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _pickedImage = image;
      notifyListeners();
    }
  }

  void clearImage() {
    _pickedImage = null;
    notifyListeners();
  }

  // --- Update / Save Logic ---
  void updateProfile() {
    if (_username.isEmpty ||
        _email.isEmpty ||
        _phone.isEmpty ||
        _password.isEmpty) {
      throw Exception("Please fill all fields before updating.");
    }

    // Example: Save to local DB or API
    debugPrint("✅ Profile Updated:");
    debugPrint("Username: $_username");
    debugPrint("Email: $_email");
    debugPrint("Phone: $_phone");
    debugPrint("Password: $_password");

    notifyListeners();
  }
}
