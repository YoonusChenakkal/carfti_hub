import 'dart:io';
import 'package:craftify_vendor/common/flush_bar.dart';
import 'package:craftify_vendor/const/local_storage.dart';
import 'package:craftify_vendor/screens/profile/provider/profile_provider.dart';
import 'package:path/path.dart';
import 'package:craftify_vendor/screens/Auth/Auth_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  bool showOtpField = false;
  bool _isLoading = false;
  String? imageName;
  File? _profileImage;
  TextEditingController tcLoginEmail = TextEditingController();
  TextEditingController tcLoginOtp = TextEditingController();

  TextEditingController tcName = TextEditingController();
  TextEditingController tcPhone = TextEditingController();
  TextEditingController tcWhatsappNumber = TextEditingController();
  TextEditingController tcEmail = TextEditingController();
  TextEditingController tcPassword = TextEditingController();
  TextEditingController tcConfirmPassword = TextEditingController();

  get profileImage => _profileImage;
  get isLoading => _isLoading;

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  set profileImage(value) {
    _profileImage = value;
    notifyListeners();
  }

  resetLogin() {
    showOtpField = false;
    tcLoginEmail.clear;
    tcLoginOtp.clear;
    notifyListeners();
  }

  resetRegister() {
    tcName.clear();
    tcPhone.clear();
    tcWhatsappNumber.clear();
    tcEmail.clear();
    tcPassword.clear();
    tcConfirmPassword.clear();
    profileImage = null;
    notifyListeners();
  }

  final _authRepo = AuthRepository();
  // Register Vendor ----------->
  registerVendor(data, BuildContext context) async {
    isLoading = true;
    try {
      final response = await _authRepo.registerVendor(data);
      final userId = response.data['id'];

      await LocalStorage.saveUser(userId);
      await Provider.of<ProfileProvider>(context, listen: false)
          .fetchUser(context);
      resetRegister();

      Navigator.pushReplacementNamed(context, '/bottomBar');
      await showFlushbar(
        context: context,
        color: Colors.green,
        icon: Icons.check,
        message: 'Vendor Registration Successful',
      );
    } catch (e) {
      // Display the parsed error message
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: e.toString().replaceAll('Exception: ', ''), // Clean up message
      );
      print("❌ Registration failed: $e");
    } finally {
      isLoading = false;
    }
  }
  // Login Vendor ------------->

  loginVendor(data, BuildContext context) async {
    isLoading = true;

    try {
      final response = await _authRepo.loginVendor(data);

      final message = response.data['message'];

      await showFlushbar(
        context: context,
        color: Colors.green,
        icon: Icons.check,
        message: message,
      );
      showOtpField = true;
      notifyListeners();
    } on Exception catch (e) {
      // Display the parsed error message
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: e.toString().replaceAll('Exception: ', ''), // Clean up message
      );
      print("❌ Registration failed: $e");
    } finally {
      isLoading = false;
    }
  }
  // login Otp Verify ------------->

  loginOtpVerify(data, BuildContext context) async {
    isLoading = true;
    print('----------------------------------------------------->$data');
    try {
      final response = await _authRepo.loginOtpVerify(data);
      final message = response.data['message'];
      final userId = response.data['vendor_admin_id'];
      await LocalStorage.saveUser(userId);
      await Provider.of<ProfileProvider>(context, listen: false)
          .fetchUser(context);
      Navigator.pushReplacementNamed(context, '/bottomBar');
      await showFlushbar(
        context: context,
        color: Colors.green,
        icon: Icons.login,
        message: message,
      );
      resetLogin();
    } on Exception catch (e) {
      // Display the parsed error message
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: e.toString().replaceAll('Exception: ', ''), // Clean up message
      );
      print("❌ Registration failed: $e");
    } finally {
      isLoading = false;
    }
  }

  pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _profileImage = File(pickedFile.path);
      imageName = basename(pickedFile.path);
      notifyListeners();
    }
  }
}
