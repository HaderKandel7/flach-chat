abstract class SignUpState{}
class SignUpInitialState extends SignUpState{}

class ChangePasswordState extends SignUpState{}

class SignUpLoadingState extends SignUpState{}

class SignUpSuccessDataState extends SignUpState{
}

class SignUpErrorState extends SignUpState{
  final String error;

  SignUpErrorState(this.error);
}

class CreateUserLoadingState extends SignUpState{}

class CreateUserSuccessDataState extends SignUpState{
}

class CreateUserErrorState extends SignUpState{
  final String error;

  CreateUserErrorState(this.error);
}

// class RegisterLoadingState extends RegisterState{}