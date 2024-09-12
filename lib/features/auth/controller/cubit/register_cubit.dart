import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_planner/features/auth/data/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final FirebaseAuth auth;
  final BaseAuthRepository baseAuthRepository;
  RegisterCubit(this.baseAuthRepository, this.auth) : super(RegisterInitial());
  bool isVisible = false;
  toggleVisibility() {
    isVisible = !isVisible;
    emit(ChangeVisibility());
  }

  signUpWithEmail(String email, String password) async {
    emit(UserRegisterLoading());
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(UserRegisterSuccess(result.user!));
    } catch (e) {
      emit(UserRegisterError(e.toString()));
    }
  }
}
