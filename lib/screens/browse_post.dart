import 'package:Marketplace/paths/image_path.dart';
import 'package:Marketplace/screens/post_details.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class BrowsePost extends StatefulWidget {
  BrowsePost({Key key, this.db, this.userId, this.item})
      : super(key: key);
  final db;
  final userId;
  final item;
  @override
  _BrowsePostState createState() {
    return new _BrowsePostState();
  }
}

class _BrowsePostState extends State<BrowsePost> {
  List<ImageUrl> _imgUrlList;
  List<String> _urls = new List();

  StreamSubscription<Event> _onItemAddedSubscription;
  StreamSubscription<Event> _onItemChangedSubscription;

  Query _imgUrlQuery;

  @override
  void initState() {
    super.initState();

    _imgUrlList = new List();
    _imgUrlQuery = widget.db
        .reference()
        .child("imageUrl")
        .orderByChild("itemTitle")
        .equalTo(widget.item.title);

    _onItemAddedSubscription = _imgUrlQuery.onChildAdded.listen(_onEntryAdded);
    _onItemChangedSubscription = _imgUrlQuery.onChildChanged.listen(_onEntryChanged);

  }

  @override
  void dispose() {
    _onItemAddedSubscription.cancel();
    _onItemChangedSubscription.cancel();
    super.dispose();
  }

  _onEntryChanged(Event event) {
    var oldEntry = _imgUrlList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _imgUrlList[_imgUrlList.indexOf(oldEntry)] = ImageUrl.fromSnapshot(event.snapshot);
    });
  }

  _onEntryAdded(Event event) {
    setState(() {
      _imgUrlList.add(ImageUrl.fromSnapshot(event.snapshot));
      _urls.add(ImageUrl.fromSnapshot(event.snapshot).url);
    });
  }

  Widget _buildGridView() {
    return GridView.count(
        crossAxisCount: 2,
        children: List.generate(_urls.length, (index) {
          return GestureDetector(
            child: Hero(
                tag: index.toString(),
                child: new Container(
                    child: _urls[index] == null ? Image.asset(
                      'images/mbp_2017.jpeg', height: 110.0,)
                        :
                    CachedNetworkImage(
                      imageUrl: _urls[index],
                      placeholder: (context, url) => new Center(
                          child: Container(
                              width: 32,
                              height: 32,
                              child: new CircularProgressIndicator()
                          )
                      ),
                      errorWidget: (context, url, error) => new Icon(Icons.error),
                    )
                )
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return DetailScreen(tag: widget.item.title, url: _urls[index]);
              }));
            },
          );
        })
    );
  }

  Widget _browsePostContent(BuildContext context) {
    return new Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0),
            child: new Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ListTile(
                title: new Text("Title: "),
                trailing: new Text(widget.item.title),
              ),
            ),
          ),

          new Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0),
            child: new Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ListTile(
                title: new Text("Price: "),
                trailing: new Text("\$" + widget.item.price),
              ),
            ),
          ),

          new Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0),
            child: new Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ListTile(
                title: new Text("Description: "),
                trailing: new Text(widget.item.description),
              ),
            ),
          ),

          _urls.length == 0 ? new Text("No photo") :

          Expanded(
            child: _buildGridView(),
          )
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Marketplace'),
      ),
      body: _browsePostContent(context),
    );
  }

}