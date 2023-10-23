// ignore_for_file: public_member_api_docs, sort_constructors_first

class AuthModel {
  final bool isUsernameValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool obscureText;
  AuthModel({
    required this.isUsernameValid,
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.obscureText,
  });

  bool get isButtonEnabled => isEmailValid && isPasswordValid && isUsernameValid;

  AuthModel copyWith({
    bool? isUsernameValid,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? obscureText,
  }) {
    return AuthModel(
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      obscureText: obscureText ?? this.obscureText,
    );
  }
}

