import 'package:flash_chat/modules/login_bloc/login_states.dart';
import 'package:flash_chat/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginCubit extends Cubit<States> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  var isVisible = false;

  void changePassword() {
    isVisible = !isVisible;
    emit(ChangePasswordState());
  }

  void loginUser({@required var email, @required var pass}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      // print(value.user.email);
      // print(value.user.uid);
      uId= value.user.uid;
      print(uId);
      emit(LoginSuccessState());
    }).catchError((error) {
      print('lllllllllllllll');
      print(error.toString());
      emit(LoginErrorState(error));
    });
  }
}
