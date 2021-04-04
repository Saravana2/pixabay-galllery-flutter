import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_ui/APIHelper.dart';
import 'package:flutter_ui/model/ImageResponse.dart';
import 'package:flutter_ui/screens/ImageDetailScreen.dart';
import 'package:flutter_ui/widget/AppTextField.dart';

import 'lazy_load_Scrollview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch:  Colors.grey,
      ),
      home: MyHomePage(title: 'Mine'),
      //home: ImageDetailScreen(null,hasPrev: false,hasNext: false,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;
  final List<Widget> _children = [
    ExplorePage(),
    UnderDevelopmentPage(),
    UnderDevelopmentPage(),
    UnderDevelopmentPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        toolbarHeight: 30.0,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0.0,
      ),
      body: _children[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              label: 'explore',
              icon: Icon(Icons.search, color: getColourByPosition(0))),
          BottomNavigationBarItem(
              label: 'add',
              icon: Icon(Icons.add_box_outlined, color: getColourByPosition(1))),
          BottomNavigationBarItem(
              label: 'message',
              icon: Icon(Icons.message_outlined, color: getColourByPosition(2))),
          BottomNavigationBarItem(
              label: 'home',
              icon: Icon(Icons.house_rounded, color: getColourByPosition(3))),
        ],
      ),
    );
  }

  _onTapped(int position) {
    if (position != _currentPage) {
      setState(() {
        _currentPage = position;
      });
    }
  }

  Color getColourByPosition(int position) {
    if (position == _currentPage) return Colors.black;
    return Colors.black26;
  }
}


class ExplorePage extends StatefulWidget {

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  bool isLoading=false;
  bool isPageEndReached=false;
  int page = 1;
  List<Hits> imageList = [];
  final _searchTextController = TextEditingController();
  final ScrollController scrollController = new ScrollController();
  APIHelper _apiHelper;
  CancelableOperation apiOperation;
  Future<ImageResponse> imageHandler;


  @override
  void initState() {
    super.initState();
    _reload("");
  }

  _reload(text){
    _apiHelper = APIHelper();
    _apiHelper.pageCount = 1;
    isLoading = true;
    imageList.clear();
    isPageEndReached = false;
    imageHandler = _apiHelper.fetchImages(text);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.0,right: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Explore",style: TextStyle(fontSize: 34.0,fontWeight: FontWeight.bold),),
              Image(
                width: 40.0,
                height: 40.0,
                image: NetworkImage(
                    "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png"),
              ),
            ],
          ),
          searchWidget(),
          Container(child: getMainView(),)
        ],
      ),
    );
  }

  Widget getMainView() {
    return FutureBuilder<ImageResponse>(
      future: imageHandler,
      builder: (context, snapshot) {
        if (snapshot.hasError)
          if(snapshot.error is FormatException)
          return Text((snapshot.error as FormatException).message);
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if(snapshot.data!=null)onSuccessResult(snapshot.data);
            return LazyLoadScrollView(
              isLoading: isLoading,
              scrollDirection: Axis.vertical,
              onEndOfPage:() =>  _loadMore(),
              isPageEndReached: isPageEndReached,
              child: getStagedView(),
            );
          default:
            return Container();
        }
      },
    );
  }

  Widget getStagedView(){
    return
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: isPageEndReached ? imageList.length : imageList.length + 1,
            itemBuilder: (BuildContext context, int index)  {
              if(!isPageEndReached && index == imageList.length){
                return Center(child: CircularProgressIndicator(),);
              }
              return GestureDetector(
                child: gridTile(imageList[index]),
                onTap: () {
                  gotoDetailPage(index);
                },
              );
            },
            staggeredTileBuilder: (int index) {
              if(!isPageEndReached && index == imageList.length){
                return StaggeredTile.count(4, 1);
              }
              if(imageList[index].isLandScape()){
                return StaggeredTile.count(2, 1);
              }else{
                return StaggeredTile.count(2, 2);
              }

            }
            ),
          ),
        );
  }

  gotoDetailPage(position) async {
    bool hasNext = position != imageList.length - 1;
    bool hasPrev = position != 0;
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ImageDetailScreen(
                  imageList[position],
                  hasNext: hasNext,
                  hasPrev: hasPrev,
                )));
    if (result != null) {
      if (result == 1) {
        gotoDetailPage(position - 1);
      } else if (result == 2) {
        gotoDetailPage(position + 1);
      }
    }
  }

  Widget gridTile(Hits image){
    return SizedBox(
      height: 100,
      child: Card(
        semanticContainer: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))
        ),
        color: Colors.white,
        elevation: 5.0,
        child: Stack(
          fit: StackFit.expand,
          children: [
          Container(
            margin: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: Image(
                image: NetworkImage(image.previewURL),
                fit: BoxFit.fill,
              ),
            ),
          )
        ],),
      ),
    );
  }

  Widget getGridView() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.1),
          itemCount: imageList.length,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return gridTile(imageList[index]);
          },
        ),
      ),
    );
  }

  Widget searchWidget() {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: AppTextField(
          _searchTextController,
        "Find something fun",
        onPressed: () {
          _reload(_searchTextController.text);
         // _loadMore();
        },
      ),
    );
  }

  onSuccessResult(ImageResponse value){
    imageList.addAll(value.hits);
    if (_apiHelper.pageCount == value.totalHits) {
      isPageEndReached = true;
    }
    _apiHelper.pageCount++;
  }

  Future _loadMore() async{
      isLoading = true;
      setState(() {

      });
      apiOperation = CancelableOperation.fromFuture(
          _apiHelper.fetchImages(_searchTextController.text)
              .then((value) {
            onSuccessResult(value);
            isLoading = false;
            setState(() {});
          }, onError: (e) {
            isLoading = false;
            _handleError(e);
          })
      );
  }

  _handleError(Exception e) {
    if(e is FormatException)
      print(e.message);
  }
}

class UnderDevelopmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlankPageWithName(title: "Under Development");
  }
}


class BlankPageWithName extends StatelessWidget {
  final String title;

  BlankPageWithName({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}
