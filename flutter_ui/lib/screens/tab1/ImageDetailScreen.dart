import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/model/ImageResponse.dart';
import 'package:flutter_ui/screens/helper_screens.dart';
import 'package:flutter_ui/widget/AppTextField.dart';

class ImageDetailScreen extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();
  Hits hit;
  bool hasNext = false;
  bool hasPrev = false;

  ImageDetailScreen(this.hit, {this.hasNext, this.hasPrev});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AppBar appBar = AppBar(
    // Here we take the value from the MyHomePage object that was created by
    // the App.build method, and use it to set our appbar title.
    backgroundColor: Colors.white,
    shadowColor: Colors.white,
    elevation: 0.0,
    centerTitle: true,
    title: Text("Post"),
    actions: [
      Padding(
          padding: EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.save_alt),
          ))
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: appBar,
      body: Container(
          color: Colors.purple.shade50,
          child: SingleChildScrollView(
            child: getBodyWidget(context),
          )),
    );
  }

  Widget getBodyWidget(context) {
    double height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return SizedBox(
      height: height,
      child: getDetailView(context),
    );
  }

  Widget getNextAndPrevButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        hasPrev
            ? MaterialButton(
                minWidth: 0,
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.navigate_next,
                  textDirection: TextDirection.rtl,
                ),
                color: Colors.black38,
                textColor: Colors.white,
                shape: CircleBorder(),
                onPressed: () {
                  _onPageChange(true, context);
                },
              )
            : Container(),
        hasNext
            ? MaterialButton(
                minWidth: 0,
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.navigate_next,
                ),
                color: Colors.black38,
                textColor: Colors.white,
                shape: CircleBorder(),
                onPressed: () {
                  _onPageChange(false, context);
                },
              )
            : Container(),
      ],
    );
  }

  _onPageChange(bool isPrev, context) {
    var pageType = isPrev ? 1 : 2;
    Navigator.pop(context, pageType);
  }

  Widget getDetailView(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 24.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32.0),
                    bottomRight: Radius.circular(32.0))),
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: Image.network(
                            this.hit.largeImageURL,
                            fit: BoxFit.cover,
                          )),
                      getNextAndPrevButton(context),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: Image.network(
                                this.hit.userImageURL,
                                width: 40,
                                height: 40,
                              )),
                          Container(
                            margin: EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  this.hit.user == null ? "" : this.hit.user,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  '20.03.2021',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            this.hit.views.toString(),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(16.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AppTextField(
                    _textEditingController,
                    "Send Message",
                    onPressed: () {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 12.0),
                  child: MaterialButton(
                    minWidth: 0,
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.ios_share,
                    ),
                    color: Colors.white,
                    textColor: Colors.black,
                    shape: CircleBorder(),
                    onPressed: () {
                      _showBottomSheet(context);
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  _showBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) => BottomSheetView(),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(32.0),
        topRight: const Radius.circular(32.0),
      )),
    );
  }
}

class BottomSheetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
              child: Text(
            "Share",
            style: TextStyle(
              fontSize: 20.0,
            ),
          )),
          BottomSheetPageView(_getHits()),
          RaisedButton(
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Text(
              "Share",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            color: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  List<Hits> _getHits() {
    List<String> userProfileUrl = [];
    userProfileUrl.add(
        "https://cdn.pixabay.com/user/2019/11/08/12-57-56-969_250x250.jpg");
    userProfileUrl.add(
        "https://i.pinimg.com/236x/17/e5/94/17e594f4f7da0bb823ec8a9099b18a88.jpg");
    userProfileUrl.add(
        "https://cdn.pixabay.com/user/2016/12/13/22-15-04-376_250x250.jpg");
    userProfileUrl.add(
        "https://i.pinimg.com/236x/17/e5/94/17e594f4f7da0bb823ec8a9099b18a88.jpg");
    userProfileUrl.add(
        "https://cdn.pixabay.com/user/2019/09/05/14-05-20-901_250x250.jpg");
    userProfileUrl.add(
        "https://cdn.pixabay.com/user/2019/01/29/15-01-52-802_250x250.jpg");
    userProfileUrl.add(
        "https://cdn.pixabay.com/user/2021/03/15/05-41-18-807_250x250.jpg");
    List<String> userName = [];
    userName.add("Sathish");
    userName.add("Maeve Wiley");
    userName.add("Joseph");
    userName.add("Maeve Wiley");
    userName.add("Otis");
    userName.add("Hannah");
    userName.add("Clay");
    List<Hits> hits = [];
    for (int i = 0; i < 29; i++) {
      int randomIndex = Random().nextInt(6);
      hits.add(Hits(
          user: userName[randomIndex],
          userImageURL: userProfileUrl[randomIndex]));
    }
    return hits;
  }
}

class BottomSheetPageView extends StatefulWidget {
  final List<Hits> hits;

  BottomSheetPageView(this.hits);

  @override
  _BottomSheetPageViewState createState() => _BottomSheetPageViewState();
}

class _BottomSheetPageViewState extends State<BottomSheetPageView> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 16.0),
        child: PageView(
          controller: _controller,
          children: getPageViewChildren(),
        ),
      ),
    );
  }

  List<Widget> getPageViewChildren() {
    List<Widget> listWidgets = [];
    if (widget.hits == null || widget.hits.length == 0) {
      listWidgets.add(ShareGridPage(null));
      return listWidgets;
    }

    int totalPage = widget.hits.length ~/ 8;
    for (int i = 0; i < widget.hits.length; i += 8) {
      if (i / 8 == totalPage) {
        listWidgets.add(ShareGridPage(widget.hits.sublist(i)));
      } else {
        listWidgets.add(ShareGridPage(widget.hits.sublist(i, i + 8)));
      }
    }
    return listWidgets;
  }
}

class ShareGridPage extends StatelessWidget {
  final List<Hits> hits;

  ShareGridPage(this.hits);

  @override
  Widget build(BuildContext context) {
    if (hits == null || hits.length == 0) {
      return BlankPageWithName(title: "No users to share");
    }
    return Center(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: hits.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.white,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.network(
                    hits[index].userImageURL,
                    height: 50,
                    width: 50,
                  ),
                ),
                SizedBox(height: 10),
                Text(hits[index].user == null ? "NULL" : hits[index].user)
              ],
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, childAspectRatio: 0.8),
      ),
    );
  }
}
