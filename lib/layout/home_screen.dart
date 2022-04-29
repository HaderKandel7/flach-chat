import 'package:flash_chat/layout/chatDetails_screen.dart';
import 'package:flash_chat/layout/profile_screen.dart';
import 'package:flash_chat/models/userModel.dart';
import 'package:flash_chat/modules/home_bloc/home_cubit.dart';
import 'package:flash_chat/modules/home_bloc/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatelessWidget {
  final flag;

  const HomeScreen({this.flag}) : super();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()..getUserData()
      // ..getAllUsers()
      ,
      child: BlocConsumer<HomeCubit, States>(
        listener: (context, state) {},
        builder: (context, state) {
          if (flag == false) {
            // print('a7a');
            FirebaseAuth.instance.currentUser
                .sendEmailVerification()
                .then((value) {
              Fluttertoast.showToast(
                  msg: "check your mail",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }).catchError((error) {
              print(error.toString());
            });
          }
          // print('a7eeeh${FirebaseAuth.instance.currentUser.emailVerified}');
          HomeCubit hc = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: Text('Home'),
              titleSpacing: 20,
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
                IconButton(
                  icon: Icon(Icons.person_outlined),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                  },
                )
              ],
            ),
            body: (hc.users.length == 0)
                ? Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemBuilder: (context, index) =>
                        buildChatItem(hc.users[index], context),
                    separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 1,
                            color: Colors.grey[300],
                          ),
                        ),
                    itemCount: hc.users.length),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 75,
              width: 75,
              child: FloatingActionButton(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('create'), Text('post')],
                ),
                onPressed: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildChatItem(UserModel model, context) => GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatDetailsScreen(model)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('${model.profile}'),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              '${model.name}',
              style: TextStyle(
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
