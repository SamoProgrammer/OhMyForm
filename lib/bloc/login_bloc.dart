import 'package:bloc/bloc.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, bool> {
  LoginBloc() : super(false);
}
