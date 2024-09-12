import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:meta/meta.dart';

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
    emit(UserLoginLoading());
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await auth.signInWithCredential(credential);
      emit(UserLoginSuccess(result.user!));
    } catch (e) {
      print(e.toString());
      emit(UserLoginError(e.toString()));
    }
  }
}
