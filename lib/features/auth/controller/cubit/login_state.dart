part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class ChangeVisibility extends LoginState {}

final class UserLoginLoading extends LoginState {}

final class UserLoginSuccess extends LoginState {
  final User? user;
  UserLoginSuccess(this.user);
}

final class UserLoginError extends LoginState {
  final String errorMsg;

  UserLoginError(this.errorMsg);
}
