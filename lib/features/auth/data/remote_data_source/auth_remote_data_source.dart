import '../../../../core/network/dio_helper.dart';

abstract class BaseAuthRemoteDataSource {
  /*Future<LoginResponseModel> userLogin(String email, String password);
  Future<String> sendFcmToken(String fcmToken);*/
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  final DioHelper dioHelper;

  AuthRemoteDataSource(
      this.dioHelper); /*
  @override
  Future<LoginResponseModel> userLogin(String email, String password) async {
    try {
      Response response = await dioHelper
          .post('login', body: {"email": email, "password": password});

      return LoginResponseModel.fromMap(response.data);
    } on DioException catch (e) {
      throw NetworkException(dioException: e);
    }
  }

  @override
  Future<String> sendFcmToken(String fcmToken) async {
    try {
      Response response = await dioHelper
          .update('user/fcm_token', body: {"fcm_token": fcmToken});

      return response.data['message'];
    } on DioException catch (e) {
      throw NetworkException(dioException: e);
    }
  }*/
}
