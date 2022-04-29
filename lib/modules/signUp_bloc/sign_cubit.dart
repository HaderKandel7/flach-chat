import 'package:flash_chat/models/userModel.dart';
import 'package:flash_chat/modules/signUp_bloc/sign_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData suffix = Icons.visibility;

  changePassword() {
    isPassword = !isPassword;
    suffix = (isPassword) ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordState());
  }

  void signUpUser(
      {@required var email,
      @required var pass,
      @required var name,
      @required var phone}) {
    emit(SignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      print(value.user.email);
      print(value.user.uid);
      var um = UserModel(bio:'write your bio .....',cover: '',profile: '',
          name: name, email: email, phone: phone, uId: value.user.uid);
      createUser(um);
      emit(SignUpSuccessDataState());
    }).catchError((error) {
      emit(SignUpErrorState(error));
    });
  }

  void createUser(UserModel um) {

    emit(CreateUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(um.uId)
        .set(um.toMap())
        .then((value) {
      emit(CreateUserSuccessDataState());
    }).catchError((error) {
      emit(CreateUserErrorState(error));
    });
  }
}
