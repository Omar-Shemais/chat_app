import 'package:chat_app_using_firebase/core/route_utils/route_utils.dart';
import 'package:chat_app_using_firebase/views/chats/cubit.dart';
import 'package:chat_app_using_firebase/views/splash/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../chat_details/view.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsCubit()..getUsers(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                RouteUtils.pushAndPopAll(SplashView());
              },
              icon: Icon(Icons.arrow_right_alt),
            ),
          ],
        ),
        body: BlocBuilder<ChatsCubit, ChatsStates>(
          builder: (context, state) {
            if (state is ChatsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final users = BlocProvider.of<ChatsCubit>(context).users;
            return ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    child: Text(users[index].email[0].toUpperCase()),
                  ),
                  title: Text(users[index].email),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => RouteUtils.push(ChatDetailsView(
                    user: users[index],
                  )),
                );
              },
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.black),
            );
          },
        ),
      ),
    );
  }
}
