// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:voco_case_study/core/init/network/models/base_request_model.dart';

class AuthRequest extends BaseRequestModel {
  final String username;
  final String email;
  final String password;
  AuthRequest({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  Object toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
    };
  }

}

