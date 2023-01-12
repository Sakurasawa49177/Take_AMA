import 'package:shared_preferences/shared_preferences.dart';
import 'package:take_ama/models/UserLogin.dart';

Profile? globalProfile;

class StorageLocal {
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('UserId');
    return userId;
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('Username');
    return username;
  }

  static Future<String?> getFirstname() async {
    final prefs = await SharedPreferences.getInstance();
    String? firstname = prefs.getString('Firstname');
    return firstname;
  }

  static Future<String?> getLastname() async {
    final prefs = await SharedPreferences.getInstance();
    String? lastname = prefs.getString('Lastname');
    return lastname;
  }

  static Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString('UserType');
    return userType;
  }

  static Future<bool?> setUserId(String v) async {
    final prefs = await SharedPreferences.getInstance();
    bool ok = await prefs.setString('UserId', v);
    return ok;
  }

  static Future<bool?> setUsername(String v) async {
    final prefs = await SharedPreferences.getInstance();
    bool ok = await prefs.setString('Username', v);
    return ok;
  }

  static Future<bool?> setFirstname(String v) async {
    final prefs = await SharedPreferences.getInstance();
    bool ok = await prefs.setString('Firstname', v);
    return ok;
  }

  static Future<bool> setLastname(String v) async {
    final prefs = await SharedPreferences.getInstance();
    bool ok = await prefs.setString('Lastname', v);
    return ok;
  }

  static Future<bool> setUserType(String v) async {
    final prefs = await SharedPreferences.getInstance();
    bool ok = await prefs.setString('UserType', v);
    return ok;
  }

  static Future<Profile> getUser() async {
    Profile profile = Profile();
    profile.id = await StorageLocal.getUserId();
    profile.userType = await StorageLocal.getUserType();
    profile.username = await StorageLocal.getUsername();
    profile.firstName = await StorageLocal.getFirstname();
    profile.lastName = await StorageLocal.getLastname();
    globalProfile = profile;
    return profile;
  }

  static Future storageUser(UserLogin userLogin) async {
    await StorageLocal.setUserId(userLogin.data!.id!);
    await StorageLocal.setUserType(userLogin.data!.userType!);
    await StorageLocal.setUsername(userLogin.data!.username!);
    await StorageLocal.setFirstname(userLogin.data!.firstName!);
    await StorageLocal.setLastname(userLogin.data!.lastName!);
  }

  static void clearUser() {
    StorageLocal.setUserId('');
    StorageLocal.setUserType('');
    StorageLocal.setUsername('');
    StorageLocal.setFirstname('');
    StorageLocal.setLastname('');
  }
}
