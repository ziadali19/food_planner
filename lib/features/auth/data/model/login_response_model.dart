class LoginResponseModel {
  final String? status;
  final String? message;
  final String? token;
  final int? expiresIn;
  final LoginData? data;

  LoginResponseModel(
      this.status, this.message, this.token, this.expiresIn, this.data);

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      map['status'],
      map['message'],
      map['token'],
      map['expiresIn']?.toInt(),
      map['data'] != null ? LoginData.fromMap(map['data']) : null,
    );
  }
}

class LoginData {
  final String? userId;
  final String? name;
  final String? email;
  final String? phone;
  final Title? title;
  final String? organizationName;
  final String? avatar;
  final String? type;

  LoginData(this.userId, this.name, this.email, this.phone, this.title,
      this.organizationName, this.avatar, this.type);

  factory LoginData.fromMap(Map<String, dynamic> map) {
    return LoginData(
      map['user_id'],
      map['name'],
      map['email'],
      map['phone'],
      map['title'] != null ? Title.fromMap(map['title']) : null,
      map['organization_name'],
      map['avatar'],
      map['type'],
    );
  }
}

class Title {
  final String? name;

  Title(this.name);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Title.fromMap(Map<String, dynamic> map) {
    return Title(
      map['name'],
    );
  }
}
