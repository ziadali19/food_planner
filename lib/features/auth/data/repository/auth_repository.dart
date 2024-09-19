import '../remote_data_source/auth_remote_data_source.dart';

abstract class BaseAuthRepository {
  /* Future<Either<ApiErrorModel, LoginResponseModel>> userLogin(
      String email, String password);
  Future<Either<ApiErrorModel, String>> sendFcmToken(String fcmToken);*/
}

class AuthRepository extends BaseAuthRepository {
  final BaseAuthRemoteDataSource baseAuthRemoteDataSource;

  AuthRepository(
      this.baseAuthRemoteDataSource); /*
  @override
  Future<Either<ApiErrorModel, LoginResponseModel>> userLogin(
      String email, String password) async {
    try {
      LoginResponseModel response =
          await baseAuthRemoteDataSource.userLogin(email, password);
      return right(response);
    } on NetworkException catch (e) {
      ApiErrorModel apiErrorModel =
          ErrorHandler.instance.handleError(e.dioException);

      return left(apiErrorModel);
    }
  }

  @override
  Future<Either<ApiErrorModel, String>> sendFcmToken(String fcmToken) async {
    try {
      String response = await baseAuthRemoteDataSource.sendFcmToken(fcmToken);
      return right(response);
    } on NetworkException catch (e) {
      ApiErrorModel apiErrorModel =
          ErrorHandler.instance.handleError(e.dioException);

      return left(apiErrorModel);
    }
  }*/
}
