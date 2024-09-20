import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_planner/core/services/service_locator.dart';
import 'package:food_planner/features/favorite/controller/cubit/favorites_cubit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  final FirebaseAuth _firebaseAuth = sl<FirebaseAuth>();
  final GoogleSignIn _googleSignIn = sl<GoogleSignIn>();

  Future<void> logout(BuildContext context) async {
    emit(SettingsLoading());
    try {
      context.read<FavoritesCubit>().clearFavorites();
      await _firebaseAuth.signOut();

      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      emit(SettingsLoggedOut());
    } catch (e) {
      emit(SettingsError(message: e.toString()));
    }
  }
}
