import 'dart:convert';

import 'package:demo_application/constants/constants.dart';
import 'package:demo_application/quiz-screens/quiz_home_page.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:demo_application/models/storing_video_data.dart';

class TopicDetailPage extends StatefulWidget {
  TopicDetailPage({this.title, this.id});

  final String title;
  final String id;

  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  //Controller for you tube.
  YoutubePlayerController _controller;

  //Controller for text field.
  TextEditingController nameController = TextEditingController();

  //Flag to maintain focus status for text field.
  FocusNode _focusNode = new FocusNode();
  bool isKeyboardVisible = false;

  //Flag to maintain hive boc instance.
  Box<dynamic> _hiveBox;

  //Flag to store today value. i.e yyyymmdd
  String value;

  List<VideoData> dataValue = List<VideoData>();

  //region: Overridden functions
  @override
  void initState() {
    super.initState();
    _initScreenVariables();
  }

  @override
  void dispose() {
    _hiveBox?.close();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black54,
        actions: [
          IconButton(
            icon: Icon(Icons.question_answer),
            tooltip: "Play Quiz",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          QuizHomePage(
                            title: widget.title,
                          )));
            },
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.note_add),
          backgroundColor: new Color(0xFFE57373),
          onPressed: () {
            _modalBottomSheetMenu();
          }),
      body: Container(
        color: Colors.white,
        height: Constants.dynamicHeight(context),
        width: Constants.dynamicWidth(context),
        child: Column(
          children: [
            YoutubePlayer(
              width: Constants.dynamicWidth(context),
              controller: _controller,
              topActions: const <Widget>[],
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              onReady: () {},
              onEnded: (YoutubeMetaData data) {},
            ),
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dataValue.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          child: Row(
                        children: [
                          Text(
                            dataValue[index].timeStamp,
                            style: TextStyle(color: Colors.blue),
                          ),
                          Text(' : '),
                          Text(dataValue[index].note)
                        ],
                      )),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  //endregion

  //region: widgets
  FlatButton flatButton() {
    return FlatButton(
      // splashColor: Colors.red,
      color: Colors.black54,
      // textColor: Colors.white,
      child: Text(
        'Save',
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
      onPressed: () {
        var videoData = VideoData(timeStamp: value, note: nameController.text);
        dataValue.add(videoData);
        _saveDataToCache(dataValue, widget.title);
        _saveDataToCache(value, 'notesCache');
        setState(() {
          dataValue;
        });
      },
    );
  }

  //endregion

  //region: Private functions
  Future<void> _initScreenVariables() async {
    final DateTime dateTime = DateTime.now();
    value = dateTime.year.toString() +
        dateTime.month.toString().padLeft(2, '0') +
        dateTime.day.toString().padLeft(2, '0');

    _focusNode.addListener(_focusNodeListener);
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    await _initialiseHive();
    _getData();
  }

  Future<void> _getData() async {
    try {
      await _getDataFromCache(widget.title);
      print(' data loaded from cache');
      setState(() {
        dataValue;
      });
    } catch (e) {
      print(' _getData: $e');
    }
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Enter Note',
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TextField(
                      decoration:
                          InputDecoration(hintText: 'Please enter note'),
                      autofocus: true,
                      controller: nameController,
                    ),
                  ),
                  SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 50.0,
                      width: Constants.dynamicWidth(context),
                      child: flatButton(),
                    ),
                  )
                ],
              ),
            ));
  }

  Future<Null> _focusNodeListener() async {
    if (_focusNode.hasFocus || _focusNode.hasFocus) {
      setState(() {
        isKeyboardVisible = true;
      });
    } else {
      setState(() {
        isKeyboardVisible = false;
      });
    }
  }

  Future<void> _initialiseHive() async {
    try {
      _hiveBox = await Hive.openBox(widget.title);
    } catch (error) {
      print('_initialiseHive: $error');
    }
  }

  Future<void> _saveDataToCache(dynamic data, String key) async {
    try {
      await _hiveBox.put(key, data);
    } catch (e) {
      print('$key _saveDataToCache: $e');
    }
  }

  Future<void> _getDataFromCache(String key) async {
    try {
      final dynamic data = _hiveBox.get(key);
      if (data == null) {
        return;
      }
      print('Print the data $data');
      final data1 = (data as List)?.map((e) => e as VideoData)?.toList();
      // print("method 1 prints: $data1");
      // List<VideoData> dataS = List<VideoData>();
      dataValue.addAll(data1);
    } catch (e) {
      print('$key _getDataFromCache: $e');
    }
  }
//endregion
}
