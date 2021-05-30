import 'package:flutter/material.dart';
import 'package:flutter_ui/model/chat_dto.dart';
import 'package:flutter_ui/screens/tab2/chat_detail_screen.dart';
import 'package:flutter_ui/widget/AppTextField.dart';

class ChatListScreen extends StatelessWidget {

  List<ChatUsers> _list = ChatUsers.getDummyChatList();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Conversations",
                style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),),
              Text("New"),
            ],
          ),
          searchWidget(),
          SizedBox(height: 8.0,),
          Container(
            child: getMainView(),)
        ],
      ),
    );
  }

  Widget getMainView() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _getListItem(index,context);
        },
        itemCount: _list.length,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),),
    );
  }

  Widget _getListItem(int index,BuildContext context) {
    ChatUsers chatUser = _list[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChatDetailScreen(_list[index])
            )
        );
      },
      child: Container(
        padding:
            EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  child: Image.asset(chatUser.imageURL,width: 50.0,height: 50.0,),
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(chatUser.name,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500,
                      color: chatUser.isRead ? Colors.black : Colors.blue),),
                      SizedBox(
                        height: 6,
                      ),
                      Text(chatUser.messageText,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13.0,color: Colors.grey.shade700),)
                    ],
                  ),
                ),
              ],
            ),
            Text(chatUser.time,style: TextStyle(fontSize: 12.0,color: chatUser.isRead ? Colors.grey.shade700 : Colors.blue))
          ],
        ),
      ),
    );
  }


  Widget searchWidget() {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: AppTextField(
        TextEditingController(),
        "Search Conversation",
        onPressed: () {

        },
      ),
    );
  }
}
