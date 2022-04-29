import 'dart:io';

import 'package:flash_chat/models/userModel.dart';
import 'package:flash_chat/modules/profile_bloc/profile_states.dart';
import 'package:flash_chat/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileCubit extends Cubit<States> {
  ProfileCubit() : super(InitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  UserModel userModel = constUserModel;

  File profileImage;
  var picker = ImagePicker();
  var coverPicker=ImagePicker();
  Future<void> getProfileImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(profileImage);
      emit(PickProfileImageSuccessState());
    } else {
      print('no Image is selected');
      emit(PickProfileImageErrorState());
    }
  }

  File coverImage;

  Future<void> getCoverImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await coverPicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(coverImage);
      emit(PickCoverImageSuccessState());
    } else {
      print('no Image is selected');
      emit(PickCoverImageErrorState());
    }
  }

  String pImageUrl;

  Future<void> updateProfileImage() async {
    print('update profileImage');
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users')
        .child('${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      emit(UploadProfileImageSuccessState());
      value.ref.getDownloadURL().then((value) {
        emit(DownloadUrlProfileImageSuccessState());
        print('profileeeeeeeee  $value');
        pImageUrl = value;
        print('valueeeeeeeeeeeeeeeeeeeeee  $value');
        print('$pImageUrl            a7aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
        userModel.profile = pImageUrl;
      }).catchError((error) {
        print('DownloadUrlProfileImageErrorState${error.toString()}');
        emit(DownloadUrlProfileImageErrorState());
      });
    }).catchError((error) {
      print('UploadProfileImageErrorState${error.toString()}');
      emit(UploadProfileImageErrorState());
    });
  }

  String cImageUrl;

  Future<void> updateCoverImage() async {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      emit(UploadCoverImageSuccessState());
      value.ref.getDownloadURL().then((value) {
        emit(DownloadUrlCoverImageSuccessState());
        cImageUrl = value;
        userModel.cover = cImageUrl;
      }).catchError((error) {
        print('DownloadUrlCoverImageErrorState${error.toString()}');
        emit(DownloadUrlCoverImageErrorState());
      });
    }).catchError((error) {
      print('UploadCoverImageErrorState${error.toString()}');
      emit(UploadCoverImageErrorState());
    });
  }

  Future<void> updateUser({@required name, @required phone, @required bio}) async{
    emit(UpdateUserLoadingState());
    if (profileImage != null) {
      await updateProfileImage();
      print('pImageUrl$pImageUrl');
    }
    print(userModel.profile);
    if (coverImage != null) {
      await updateCoverImage();
      print('cImageUrl$cImageUrl');
    }
    print(userModel.cover);
    // userModel.cover= 'https://img.freepik.com/free-photo/closeup-diverse-people-joining-their-hands_53876-96081.jpg?t=st=1645065461~exp=1645066061~hmac=f8c58e78ef3d7d49b8267ad92efe573e3d81023c5f8483551ae30c9f01e14802&w=826';
    // userModel.profile='https://img.freepik.com/free-photo/cheerful-curly-business-girl-wearing-glasses_176420-206.jpg?w=740';
    userModel.name = name;
    userModel.bio = bio;
    userModel.phone = phone;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(userModel.toMap())
        .then((value) async{
      emit(UpdateUserSuccessState());
      await getUpdatedData();
    }).catchError((error) {
      emit(UpdateUserErrorState());
      print('updateUser${error.toString()}');
    });
  }

  Future<void> getUpdatedData()async {
    emit(GetUpdatedUserDataLoadingState());
    await FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      constUserModel = userModel;
      emit(GetUpdatedUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUpdatedUserDataErrorState());
    });
  }
}
