
import 'package:voco_case_study/core/init/network/models/base_response_model.dart';

class UsersResponseModel extends BaseResponseModel<UsersResponseModel>{
  late List<SingleUserModel> users;
  UsersResponseModel({
    required this.users,
  });

  UsersResponseModel.blank();

  @override
  UsersResponseModel fromResponse(Object jsonData) {
    var data = jsonData as Map<String, dynamic>;
    return UsersResponseModel(users: (data["data"] as List).map((e) => SingleUserModel.fromJson(e)).toList());
  }

}

class SingleUserModel {
  final int id;
  final String email;
  final String first_name;
  final String last_name;
  final String avatar;
  SingleUserModel({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.avatar,
  });

  SingleUserModel.fromJson(Map<String, dynamic> json):
    id = json["id"],
    email = json["email"],
    first_name = json["first_name"],
    last_name = json["last_name"],
    avatar = json["avatar"];

  String get nameSurname => "$first_name $last_name";

}

