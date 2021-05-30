import 'package:flutter/material.dart';
import 'package:flutter_ui/model/chat_dto.dart';

class ChatDetailScreen extends StatelessWidget {
  final ChatUsers chatUser;
  ChatDetailScreen(this.chatUser);

  List<ChatMessage> messages = ChatMessage.getDummyChatMsgList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: Stack(
        children: [
          _getChatList(),
          _getBottomInput()
        ],
      ),
    );
  }

  AppBar _getAppBar(context){
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 16),
          child: Row(
            children: [
              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back,color: Colors.black,),
              ),
              SizedBox(width: 2,),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                child: Image.asset(chatUser.imageURL,width: 50.0,height: 50.0,),
              ),
              SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(chatUser.name,style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                    SizedBox(height: 6,),
                    Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBottomInput(){
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
        height: 60,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: (){
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.add, color: Colors.white, size: 20, ),
              ),
            ),
            SizedBox(width: 15,),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Write message...",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none
                ),
              ),
            ),
            SizedBox(width: 15,),
            FloatingActionButton(
              onPressed: (){},
              child: Icon(Icons.send,color: Colors.white,size: 18,),
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
          ],

        ),
      ),
    );
  }

  Widget _getChatList(){
    return Container(
      margin: EdgeInsets.only(bottom: 48.0),
      child: ListView.builder(
        itemCount: messages.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10,bottom: 10),
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index){
          return Container(
            padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
            child: Align(
              alignment: (messages[index].isSenderMsg ?Alignment.topRight:Alignment.topLeft),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: (messages[index].isSenderMsg?Colors.grey.shade200:Colors.blue[200]),
                ),
                padding: EdgeInsets.all(16),
                child: Text(messages[index].messageText, style: TextStyle(fontSize: 15),),
              ),
            ),
          );
        },
      ),
    );
  }
}
