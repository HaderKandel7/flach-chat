import 'package:flash_chat/layout/login_screen.dart';
import 'package:flash_chat/modules/signUp_bloc/sign_cubit.dart';
import 'package:flash_chat/modules/signUp_bloc/sign_states.dart';
import 'package:flash_chat/services/cache_helper.dart';
import 'package:flash_chat/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameCtr = TextEditingController();
  final TextEditingController emailCtr = TextEditingController();
  final TextEditingController passCtr = TextEditingController();
  final TextEditingController confirmPassCtr = TextEditingController();
  final TextEditingController phoneCtr = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
      body: BlocProvider(
        create: (context) => SignUpCubit(),
        child: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state is CreateUserSuccessDataState) {
                CacheHelper().saveString(key: 'uId', value: uId).then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen(flag: false,),
                      ),
                          (route) => false);
                });
              }
            }, builder: (context, state) {
          SignUpCubit c = SignUpCubit.get(context);
          return Center(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SIGN UP',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.teal,
                        ),
                      ),
                      Text(
                        'Sign up to chat with friends',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          } else
                            return null;
                        },
                        controller: nameCtr,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return 'please enter a valid email address';
                          }
                          return null;
                        },
                        controller: emailCtr,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value)) {
                            return 'please enter a valid password';
                          }
                          return null;
                        },
                        controller: passCtr,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(c.suffix),
                            onPressed: () {
                              c.changePassword();
                            },
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: c.isPassword,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value != passCtr.text.toString()) {
                              return 'please enter a match password';
                            }
                            return null;
                          },
                        controller: confirmPassCtr,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(c.suffix),
                            onPressed: () {
                              c.changePassword();
                            },
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: c.isPassword,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (!RegExp(r"^(?:[+0]9)?[0-9]{11}$")
                              .hasMatch(value)) {
                            return 'please enter a valid phone';
                          }
                          return null;
                        },
                        controller: phoneCtr,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              c.signUpUser(
                                email: emailCtr.text,
                                pass: passCtr.text,
                                name: nameCtr.text,
                                phone: phoneCtr.text,
                              );
                            } else {
                              print('');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('not Data')),
                              );
                            }
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                //   backgroundColor: Colors.teal,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      LoginScreen(),
                                ));
                          },
                          child: Text('login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}