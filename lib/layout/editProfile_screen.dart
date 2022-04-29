import 'package:flash_chat/layout/profile_screen.dart';
import 'package:flash_chat/models/userModel.dart';
import 'package:flash_chat/modules/profile_bloc/profile_cubit.dart';
import 'package:flash_chat/modules/profile_bloc/profile_states.dart';
import 'package:flash_chat/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  final UserModel userModel = constUserModel;

  var nameCtr = TextEditingController();
  var bioCtr = TextEditingController();
  var phoneCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ProfileCubit(),
        child: BlocConsumer<ProfileCubit, States>(
            listener: (context, state) {
              // if(state is UpdateUserSuccessState)
              //   Navigator.pushAndRemoveUntil(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               ProfileScreen()), (route) => false);
            },
            builder: (context, state) {
              ProfileCubit pc = ProfileCubit.get(context);
              nameCtr.text = userModel.name;
              phoneCtr.text = userModel.phone;
              bioCtr.text = userModel.bio;
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()),
                          (route) => false);
                    },
                  ),
                  title: Text('Edit Profile'),
                  // titleSpacing: 20,
                  backgroundColor: Colors.white,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        child: Text('UPDATE'),
                        onPressed: () async{
                          await pc.updateUser(
                                  name: nameCtr.text,
                                  phone: phoneCtr.text,
                                  bio: bioCtr.text);

                        },
                      ),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        (state is UpdateUserLoadingState || state is GetUpdatedUserDataLoadingState)?
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: LinearProgressIndicator(),
                            ):
                            SizedBox(height: 0,),
                        Container(
                          height: 220.0,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Align(
                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    Container(
                                      height: 160.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                            4.0,
                                          ),
                                          topRight: Radius.circular(
                                            4.0,
                                          ),
                                        ),
                                        image: DecorationImage(
                                          image: (pc.coverImage == null)
                                              ? NetworkImage(
                                                  '${userModel.cover}',
                                                )
                                              : FileImage(pc.coverImage),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.white70,
                                        child: IconButton(
                                            icon: Icon(
                                              Icons.camera_alt_rounded,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              pc.getCoverImage();
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                                alignment: AlignmentDirectional.topCenter,
                              ),
                              Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    radius: 64.0,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: CircleAvatar(
                                      radius: 60.0,
                                      backgroundImage: (pc.profileImage == null)
                                          ? NetworkImage(
                                              '${userModel.profile}',
                                            )
                                          : FileImage(pc.profileImage),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.white70,
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.camera_alt_rounded,
                                          color: Colors.black,
                                          size: 22,
                                        ),
                                        onPressed: () {
                                          pc.getProfileImage();
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: UnderlineInputBorder(),
                          ),
                          keyboardType: TextInputType.name,
                          controller: nameCtr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your name';
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.info_outline),
                            border: UnderlineInputBorder(),
                          ),
                          keyboardType: TextInputType.name,
                          controller: bioCtr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your bio';
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            border: UnderlineInputBorder(),
                          ),
                          keyboardType: TextInputType.name,
                          controller: phoneCtr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your phone';
                            } else
                              return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
