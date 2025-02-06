import 'package:chat_app_using_firebase/views/chat_details/cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/models/user.dart' as User;

class ChatDetailsView extends StatelessWidget {
  const ChatDetailsView({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User.User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatDetailsCubit(user: user)..getMessages(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(user.email),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<ChatDetailsCubit, ChatDetailsStates>(
            builder: (context, state) {
              if (state is ChatDetailsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final cubit = BlocProvider.of<ChatDetailsCubit>(context);
              final messages = cubit.messages;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isMe = message.uid == FirebaseAuth.instance.currentUser?.uid;
                        return Row(
                          mainAxisAlignment: isMe
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            UnconstrainedBox(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 10,
                                  maxWidth: 300,
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(top: 12),
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    message.message,
                                    style: TextStyle(
                                      color: isMe ? null : Colors.white,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: isMe
                                        ? Colors.grey.withOpacity(0.5)
                                        : Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: cubit.textEditingController,
                          textInputAction: TextInputAction.send,
                          decoration: InputDecoration(
                            hintText: "Message...",
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      InkWell(
                        onTap: cubit.sendMessage,
                        child: Icon(
                          Icons.send
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
