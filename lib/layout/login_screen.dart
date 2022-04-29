import 'package:flash_chat/layout/home_screen.dart';
import 'package:flash_chat/layout/signUp_screen.dart';
import 'package:flash_chat/modules/login_bloc/login_cubit.dart';
import 'package:flash_chat/modules/login_bloc/login_states.dart';
import 'package:flash_chat/services/cache_helper.dart';
import 'package:flash_chat/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailCtr = TextEditingController();
  var passCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, States>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            print('loginSuccess');
            CacheHelper().saveString(key: 'uId', value: uId).then((value) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen(flag: true,),
                  ),
                      (route) => false);
            });
          }},
        builder: (context, state) {
          LoginCubit c = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
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
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Login',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5
                              .copyWith(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'login to communicate with friends',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            prefixIcon: Icon(Icons.email_outlined),
                            border: UnderlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailCtr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your email address';
                            } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return 'please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            border: UnderlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: (c.isVisible)
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () {
                                c.changePassword();
                              },
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !c.isVisible,
                          controller: passCtr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your password';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            child: Text(
                              'forget password?',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              print(emailCtr.text);
                              if (formKey.currentState.validate()) {
                                c.loginUser(
                                    email: emailCtr.text, pass: passCtr.text);
                              }
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  //   backgroundColor: Colors.teal,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("don't have an account? "),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            SignUpScreen(),
                                      ));
                                },
                                child: Text('REGISTER')),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
