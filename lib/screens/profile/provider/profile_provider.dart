import 'package:craftify_vendor/common/flush_bar.dart';
import 'package:craftify_vendor/const/local_storage.dart';
import 'package:craftify_vendor/screens/profile/model/user_model.dart';
import 'package:craftify_vendor/screens/profile/model/profile_repository.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel? user;
  bool _isLoading = false;

  get isLoading => _isLoading;

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  final _profileRepo = ProfileRepository();

  fetchUser(BuildContext context) async {
    isLoading = true;
      int? userId = await LocalStorage.getUser();
    try {
      final response = await _profileRepo.fetchUser(userId);

      user = UserModel.fromJson(response.data);

      print('Sucess User Fetch');
      notifyListeners();
    } on Exception catch (e) {
      // Display the parsed error message
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: 'Fetching User Failed', // Clean up message
      );
      print("❌ Registration failed: $e");
    } finally {
      isLoading = false;
    }
  }
}
