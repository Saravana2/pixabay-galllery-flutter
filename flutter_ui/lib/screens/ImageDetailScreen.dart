import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/model/ImageResponse.dart';
import 'package:flutter_ui/widget/AppTextField.dart';

class ImageDetailScreen extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();
  Hits hit;
  bool hasNext=false;
  bool hasPrev=false;
  ImageDetailScreen(this.hit,{this.hasNext,this.hasPrev});

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

  Widget getNextAndPrevButton(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      hasPrev ?  MaterialButton(
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
            _onPageChange(true,context);
          },
        ): Container(),
        hasNext ? MaterialButton(
          minWidth: 0,
          padding: EdgeInsets.all(4.0),
          child: Icon(
            Icons.navigate_next,
          ),
          color: Colors.black38,
          textColor: Colors.white,
          shape: CircleBorder(),
          onPressed: () {
            _onPageChange(false,context);
          },
        ): Container(),
      ],
    );
  }

  _onPageChange(bool isPrev,context){
    var pageType = isPrev ? 1 : 2;
    Navigator.pop(context, pageType);
  }

  Widget getDetailView(context){
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
                    children:[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: Image.network(this.hit.largeImageURL,
                            fit: BoxFit.cover,)),
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
                                Text(this.hit.user == null ? "" : this.hit.user,textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                                SizedBox(height: 2.0,),
                                Text('20.03.2021',textAlign: TextAlign.left,style: TextStyle(color: Colors.grey,fontSize: 12.0),)
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
                          SizedBox(width: 8.0,),
                          Text(
                            this.hit.views.toString(),
                          ),
                          SizedBox(width: 8.0,),
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
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

}
