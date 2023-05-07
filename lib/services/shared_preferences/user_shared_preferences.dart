import 'package:shared_preferences/shared_preferences.dart';

/// CLASS THAT USES THE SHARED PREFERENCES PACKAGE
class UserSharedPreferences {
  /// FUNCTION TO STORE ALL USER DETAILS IN A CACHE.
  /// To be used when a user logs in
  cacheUserDetails({
    String firstName = '',
    String lastName = '',
    String email = '',
    String profilePicture = '',
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('first_name', firstName);
    preferences.setString('last_name', lastName);
    preferences.setString('email', email);
    preferences.setString('profile_pic', profilePicture);
  }

  /// FUNCTION TO GET USER DATA FROM CACHE AND STORE IN A MAP
  Future<Map<String, dynamic>> getCachedUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> cachedUserData = {
      'first_name': preferences.getString('first_name'),
      'last_name': preferences.getString('last_name'),
      'email': preferences.getString('email'),
      'profile_pic': preferences.getString('profile_pic'),
    };

    return cachedUserData;
  }

  /// FUNCTION TO GET USER FIRST NAME FROM CACHE
  Future<String> getFirstName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String firstName = preferences.getString('first_name') ?? '';

    return firstName;
  }

  /// FUNCTION TO GET USER LAST NAME FROM CACHE
  Future<String> getLastName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String lastName = preferences.getString('last_name') ?? '';

    return lastName;
  }

  /// FUNCTION TO GET USER EMAIL FROM CACHE
  Future<String> getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String email = preferences.getString('email') ?? '';

    return email;
  }

  /// FUNCTION TO GET USER PROFILE PICTURE FROM CACHE
  Future<String> getProfilePicture() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String profilePicture = preferences.getString('profile_pic') ?? '';

    return profilePicture;
  }

  /// FUNCTION TO CLEAR EVEYRTHING FROM CACHE
  /// To be used when the user logs out
  void clearCache() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.clear();
  }
}
