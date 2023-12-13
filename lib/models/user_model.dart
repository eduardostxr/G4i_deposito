import 'package:g4i_deposito/utilitys/app_config.dart';
import 'package:g4i_deposito/database/tables/user_table.dart';

class UserModel {
  String user;
  String userName;
  String userId;

  UserModel({
    required this.user,
    required this.userName,
    required this.userId,
  });

  UserModel copyWith({
    String? user,
    String? userName,
    String? userId,
  }) {
    return UserModel(
      user: user ?? this.user,
      userName: userName ?? this.userName,
      userId: userId ?? this.userId,
    );
  }

  static MapSD toDb(UserModel model) {
    return {
      fieldUsers: model.user,
    };
  }
}
