import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _userId = 'user_id';

  /// Save user in SharedPreferences
  static Future<void> saveUser(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userId, userId);
  }

  /// Get user
  static Future<int?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt(_userId);
    if (userId == null) return null;
    return userId;
  }

  /// Remove user  (logout)
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userId);
  }
}
