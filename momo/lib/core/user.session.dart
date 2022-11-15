/// handles user session information
class UserSessionHandler {
  static String? kUsername, kPhoneNumber;
  static bool kIsLoggedIn = kUsername != null && kUsername!.isNotEmpty;
  static const kMomoPin = '1234', kSmsVerificationCode = '123456';
}
