import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../data/repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final BaseAuthRepository baseAuthRepository;
  LoginCubit(this.baseAuthRepository) : super(LoginInitial());
  bool isVisible = false;

  toggleVisibility() {
    isVisible = !isVisible;
    emit(ChangeVisibility());
  }

  /*userLogin(String email, String password) async {
    emit(UserLoginLoading());
    Either<ApiErrorModel, LoginResponseModel> result =
        await baseAuthRepository.userLogin(email, password);
    result.fold((l) {
      emit(UserLoginError(l.message!));
    }, (r) {
      emit(UserLoginSuccess(r));
    });
  }

  sendFcmToken(String fcmToken) async {
    await baseAuthRepository.sendFcmToken(fcmToken);
  }*/
}
