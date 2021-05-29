import 'dart:io';

import 'package:demo_application/constants/constants.dart';
import 'package:demo_application/models/storing_video_data.dart';
import 'package:demo_application/topic_details_page/details_Page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:random_color/random_color.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map> topicsData = [
    {'title': 'Lamb', 'id': '9Hq9rf0XgrI'},
    {'title': 'Minions', 'id': 'PjfP2tmjtQM'},
    {'title': 'Zebra', 'id': 'n5yn7V5QOAE'},
    {'title': 'Caterpillar', 'id': 'tYa6OLQHrEc'}
  ];
  RandomColor _randomColor = RandomColor();

  @override
  void initState() {
    super.initState();
    Hive.initFlutter();
    var path = Directory.current.path;
    Hive
      ..init(path)
      ..registerAdapter(VideoDataAdapter());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Application'),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: Container(
        width: Constants.dynamicWidth(context),
        height: Constants.dynamicHeight(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Please Select one topic for details',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    //     maxCrossAxisExtent: 180,
                    //     childAspectRatio: 3 / 3,
                    //     crossAxisSpacing: 20,
                    //     mainAxisSpacing: 20),
                    itemCount: topicsData.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              topicsData[index]['title'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            decoration: BoxDecoration(
                                color: _randomColor.randomColor(
                                    colorHue: ColorHue.blue),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        onTap: () {
                          //Navigate to Controller.
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TopicDetailPage(
                                        title: topicsData[index]['title'],
                                        id: topicsData[index]['id'],
                                      )));
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
