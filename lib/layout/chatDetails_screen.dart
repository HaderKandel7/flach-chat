import 'package:flash_chat/models/messageModel.dart';
import 'package:flash_chat/models/userModel.dart';
import 'package:flash_chat/modules/home_bloc/home_cubit.dart';
import 'package:flash_chat/modules/home_bloc/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel friendUserModel;

  ChatDetailsScreen(this.friendUserModel);

  var textCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          HomeCubit()..getAllMessage(receiverId: friendUserModel.uId),
      child: FutureBuilder(
        builder: (context, snapshot) => BlocConsumer<HomeCubit, States>(
          listener: (context, state) {},
          builder: (context, state) {
            HomeCubit hc = HomeCubit.get(context);
            return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              NetworkImage('${friendUserModel.profile}'),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          '${friendUserModel.name}',
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: (hc.messages.length == 0)
                            ? Center()
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  if (friendUserModel.uId ==
                                      hc.messages[index].senderId)
                                    return otherMessage(hc.messages[index]);
                                  else
                                    return myMessage(hc.messages[index]);
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 10,
                                    ),
                                itemCount: hc.messages.length),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300], width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: TextFormField(
                                  controller: textCtr,
                                  decoration: InputDecoration(
                                    hintText: 'write your message ......',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.teal,
                              child: MaterialButton(
                                child: Icon(
                                  Icons.send,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                minWidth: 1,
                                onPressed: () {
                                  hc.sendMessage(
                                    dateTime: DateTime.now().toString(),
                                    receiverId: friendUserModel.uId,
                                    text: textCtr.text,
                                  );
                                  textCtr.text = '';
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }

  Widget myMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: Colors.teal[300]),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Text('${model.text}'),
        ),
      );

  Widget otherMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.grey[300]),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Text('${model.text}'),
        ),
      );
}
