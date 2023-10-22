
/// Constant values used within the application are defined as static properties in [ApplicationConstants].
class ApplicationConstants{
  static String FONT_FAMILY = "POPPINS";
  static String LANG_ASSET_PATH = "asset/language";
  static String EMAIL_REGEX = r"^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$";
  static String STRONG_PASSWORD_REGEX = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])(?=.{8,})";

  static RegExp phoneNumberRegex = RegExp(r"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$");

}