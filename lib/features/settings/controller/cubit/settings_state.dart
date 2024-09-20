part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsLoggedOut extends SettingsState {}

final class SettingsError extends SettingsState {
  final String message;
  SettingsError({required this.message});
}
