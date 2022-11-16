/// handles user session information
class UserSessionHandler {
  static String? kUsername, kPhoneNumber;
  static bool kIsLoggedIn = kUsername != null && kUsername!.isNotEmpty;
  static String? kMomoPin, kSmsVerificationCode;
}
