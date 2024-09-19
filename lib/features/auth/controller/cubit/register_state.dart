part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class ChangeVisibility extends RegisterState {}

final class UserRegisterLoading extends RegisterState {}

final class UserRegisterSuccess extends RegisterState {
  final User user;
  UserRegisterSuccess(this.user);
}

final class UserRegisterError extends RegisterState {
  final String errorMsg;

  UserRegisterError(this.errorMsg);
}
