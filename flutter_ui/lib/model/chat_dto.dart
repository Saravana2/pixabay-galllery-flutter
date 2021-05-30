import 'package:flutter/cupertino.dart';

class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;
  bool isRead;

  ChatUsers(
      {@required this.name,
      @required this.messageText,
      @required this.imageURL,
      @required this.time,
      @required this.isRead});

  static List<ChatUsers> getDummyChatList() {
    List<ChatUsers> chatList = [];
    chatList.add(ChatUsers(
        name: "Hannah",
        messageText: "Hi Justin",
        imageURL: "image/391890.png",
        time: "2m ago",
        isRead: false));
    chatList.add(ChatUsers(
        name: "Jessica",
        messageText: "it was a beautiful day.",
        imageURL: "image/391897.png",
        time: "2m ago",
        isRead: false));
    chatList.add(ChatUsers(
        name: "Clay",
        messageText: "It's an emergency. pick my call dude",
        imageURL: "image/391889.png",
        time: "1hr ago",
        isRead: true));
    chatList.add(ChatUsers(
        name: "Sheri",
        messageText: "......",
        imageURL: "image/391488.png",
        time: "4:00 AM",
        isRead: false));
    chatList.add(ChatUsers(
        name: "Zach",
        messageText: "be ready...",
        imageURL: "image/391479.png",
        time: "4 Aug",
        isRead: true));
    chatList.add(ChatUsers(
        name: "Tyler",
        messageText: "I am innocent. ",
        imageURL: "image/391495.png",
        time: "4 Aug",
        isRead: true));
    chatList.add(ChatUsers(
        name: "Alex",
        messageText: "I am an Android app developer..",
        imageURL: "image/391901.png",
        time: "4 Jul",
        isRead: true));
    chatList.add(ChatUsers(
        name: "Tony",
        messageText: "I am tony stark",
        imageURL: "image/390991.png",
        time: "4 Jul",
        isRead: true));
    return chatList;
  }
}

class ChatMessage{
  String messageText;
  String time;
  bool isSenderMsg;

  ChatMessage(this.messageText,this.time,this.isSenderMsg);

  static List<ChatMessage> getDummyChatMsgList() {
    List<ChatMessage> chatList = [];
    chatList.add(ChatMessage("Hi", "2m ago", true));
    chatList.add(ChatMessage("Hey", "2m ago", false));
    chatList.add(ChatMessage("How are you doing?", "2m ago", true));
    chatList.add(ChatMessage("Are you okay?", "2m ago", true));
    chatList.add(ChatMessage("Yeah. I'm just fine..", "2m ago", false));
    chatList.add(ChatMessage("Shall we meet for dinner?", "2m ago", true));
    chatList.add(ChatMessage("Yeah. sure.. same place ?", "2m ago", false));
    chatList.add(ChatMessage("Will send yu the new location", "2m ago", true));
    chatList.add(ChatMessage("ok.. i will thr by 8'o clk", "2m ago", false));
    return chatList;
  }

}
