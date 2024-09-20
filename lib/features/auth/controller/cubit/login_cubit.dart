import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:meta/meta.dart';

import '../../../../core/utils/constants.dart';
import '../../data/repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  final BaseAuthRepository baseAuthRepository;
  LoginCubit(this.baseAuthRepository, this.auth, this.googleSignIn)
      : super(LoginInitial());
  bool isVisible = false;

  toggleVisibility() {
    isVisible = !isVisible;
    emit(ChangeVisibility());
  }

  signInWithEmail(String email, String password) async {
    AppConstants.isGuest = false;
    emit(UserLoginLoading());
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(UserLoginSuccess(result.user!));
    } catch (e) {
      emit(UserLoginError(e.toString()));
    }
  }

  signInWithGoogle() async {
    AppConstants.isGuest = false;
    emit(UserLoginLoading());
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        emit(UserLoginError("Google sign-in aborted."));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        emit(
            UserLoginError("Failed to retrieve Google authentication tokens."));
        return;
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await auth.signInWithCredential(credential);
      emit(UserLoginSuccess(result.user!));
    } catch (e) {
      print(e.toString());
      emit(UserLoginError("Sign-in failed: ${e.toString()}"));
    }
  }

  loginAsGuest() {
    AppConstants.isGuest = true; // Set guest mode
    emit(UserLoginSuccess(null)); // Emit success with null user
  }
}
