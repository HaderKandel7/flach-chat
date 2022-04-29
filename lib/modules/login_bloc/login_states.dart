abstract class States{}

class InitialState extends States{}

class ChangePasswordState extends States{}

class LoginLoadingState extends States{}

class LoginSuccessState extends States{}

class LoginErrorState extends States{
  final error;
  LoginErrorState(this.error);

}
