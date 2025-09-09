import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholarchat/constant.dart';
import 'package:scholarchat/model/message.dart';
import 'package:scholarchat/widgets/chat_bubble.dart';
import 'package:scholarchat/widgets/chat_bubble_friend.dart';

class ChatPage extends StatefulWidget {
  static String id = 'Chat_Page';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

//
  TextEditingController controller = TextEditingController();
  //
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    //string nooooo is object
    var email = ModalRoute.of(context)!.settings.arguments;

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createedAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];

          //Error parsing message: TypeError: null: type 'Null' is not a subtype of type 'String' to read problem
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            final data = snapshot.data!.docs[i].data() as Map<String, dynamic>;
            messageList.add(Message.fromJson(data));
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blueGrey,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 50,
                  ),
                  Text('chat', style: TextStyle(color: Colors.white))
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      //
                      reverse: true,
                      controller: _controller,
                      itemCount: messageList.length,
                      itemBuilder: (context, idx) {
                        return messageList[idx].id == email
                            ? ChatBubble(
                                message: messageList[idx],
                              )
                            : ChatBubbleFriend(message: messageList[idx]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        'message': data,
                        'createedAt': DateTime.now(),
                        'id': email
                      });
                      controller.clear();
                      _controller.animateTo(
                        _controller.position.maxScrollExtent,
                        duration: Duration(microseconds: 500),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: Icon(
                        Icons.send,
                        color: Colors.amber,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('eror');
        }
      },
    );
  }
}





//1- how to solve width container change in listview
//2- fixed width  , width = value 
//3- expanded widget

//future buider 

// object model 

//

