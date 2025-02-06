import 'package:chat_app_using_firebase/core/route_utils/route_utils.dart';
import 'package:chat_app_using_firebase/views/chats/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/snack_bar.dart';

part 'states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInit());

  String? email, password;

  Future<void> login() async {
    if (email == null || password == null) {
      return;
    }
    emit(LoginLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email!,
          password: password!,
      );
      if (credential.user?.uid != null) {
        RouteUtils.pushAndPopAll(ChatsView());
        return;
      }
      throw FirebaseAuthException(code: "0", message: null);
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message ?? "Something went wrong", isError: true);
    }
    emit(LoginInit());
  }
}
