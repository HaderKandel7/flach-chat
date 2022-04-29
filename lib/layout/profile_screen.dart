import 'package:flash_chat/layout/editProfile_screen.dart';
import 'package:flash_chat/layout/login_screen.dart';
import 'package:flash_chat/models/userModel.dart';
import 'package:flash_chat/modules/profile_bloc/profile_cubit.dart';
import 'package:flash_chat/modules/profile_bloc/profile_states.dart';
import 'package:flash_chat/services/cache_helper.dart';
import 'package:flash_chat/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProfileScreen extends StatelessWidget {
  UserModel userModel=constUserModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ProfileCubit(),
        child: BlocConsumer<ProfileCubit, States>(
            listener: (context, state) {},
            builder: (context, state) {
              ProfileCubit pc = ProfileCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                  //leading: Text('Profile'),
                  title: Text('Profile'),
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
                  IconButton(icon: Icon(Icons.logout), onPressed: (){
                    constUserModel= null;
                    uId=null;
                    CacheHelper().saveString(key: 'uId', value: '');
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreen()),(route) => false);
                  })
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 190.0,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              child: Container(
                                height: 140.0,
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
                                    image: NetworkImage(
                                      '${userModel.cover}',
                                      // 'https://img.freepik.com/free-photo/happiness-wellbeing-confidence-concept-cheerful-attractive-african-american-woman-curly-haircut-cross-arms-chest-self-assured-powerful-pose-smiling-determined-wear-yellow-sweater_176420-35063.jpg?t=st=1645493812~exp=1645494412~hmac=8adc15658bfc1142c9ecc1d96185beba2ec1eb642c982f9dc68daf5c0115d42f&w=740'
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              alignment: AlignmentDirectional.topCenter,
                            ),
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: NetworkImage(
                                  '${userModel.profile}',
                                  // 'https://img.freepik.com/free-photo/happiness-wellbeing-confidence-concept-cheerful-attractive-african-american-woman-curly-haircut-cross-arms-chest-self-assured-powerful-pose-smiling-determined-wear-yellow-sweater_176420-35063.jpg?t=st=1645493812~exp=1645494412~hmac=8adc15658bfc1142c9ecc1d96185beba2ec1eb642c982f9dc68daf5c0115d42f&w=740'
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${userModel.name}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        '${userModel.bio}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      '100',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    Text(
                                      'Posts',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      '265',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    Text(
                                      'Photos',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      '10k',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    Text(
                                      'Followers',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      '64',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    Text(
                                      'Followings',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Text(
                                'Add Photos',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfileScreen()), (route) => false);
                            },
                            child: Icon(
                              Icons.edit,
                              size: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            )
    );
  }
}
