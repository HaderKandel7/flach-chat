import 'package:flash_chat/models/messageModel.dart';
import 'package:flash_chat/models/userModel.dart';
import 'package:flash_chat/modules/home_bloc/home_states.dart';
import 'package:flash_chat/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeCubit extends Cubit<States> {
  HomeCubit() : super(InitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  UserModel userModel;

  void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      constUserModel = userModel;
      print('see the user model data ${userModel.uId}');
      print(userModel.cover);
      emit(GetUserDataSuccessState());
      getAllUsers();
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState());
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    emit(GetAllUsersDataLoadingState());
    users = [];
    // print('userssssssssssssssss');
    FirebaseFirestore.instance.collection('users').get().then((value) {
      print(value.docs.length);
      // print(constUserModel.uId);
      value.docs.forEach((element) {
        // print(element.data()['bio']);
        // print('uid creazyyyyyyy ${userModel.uId}');
        if (element.data()['uId'] != userModel.uId)
          users.add(UserModel.fromJson(element.data()));
      });
      emit(GetAllUsersDataSuccessState());
    }).catchError((error) {
      emit(GetAllUsersDataErrorState());
    });
  }

  List<MessageModel> messages=[] ;

  void sendMessage({
    @required dateTime,
    @required receiverId,
    @required text,
  }) {
    MessageModel messageModel = MessageModel(
      text: text,
      receiverId: receiverId,
      dateTime: dateTime,
      senderId: uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  void getAllMessage({
    @required receiverId,
  }) {

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
        emit(GetMessagesSuccessState());
      });
    });
  }
}
