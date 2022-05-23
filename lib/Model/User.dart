import 'package:hsc_app_flutter/Pages/Firebase/DataBaseService.dart';



// class UserField {
//   static final String lastMessageTime = 'lastMessageTime';
// }


class User {
  final String idUser;
  final String name;
  final String residenceType;
  // final String lastMessageTime;

  const User({
    required this.idUser,
    required this.name,
    required this.residenceType,
    // required this.lastMessageTime
    // required this.urlAvatar,
  });

  User copyWith({
    required String idUser,
    required String name,
    required String residenceType,
    // required String lastMessageTime,

  }) =>
      User(
          idUser: idUser,
          name: name,
          residenceType: residenceType,
          // lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      );

  static User fromJson(Map<String, dynamic> json) => User(
    idUser: json[DataBaseService.idField],
    name: json[DataBaseService.nameField],
    residenceType: json[DataBaseService.residenceTypeField],
    // lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
  );

  Map<String, dynamic> toJson() => {
    'idUser': idUser,
    'name': name,
    'residence_type': residenceType,
    // 'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
  };
}