import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';

/// This allows the `VideoData` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'storing_video_data.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
@HiveType(typeId: 1)
class VideoData {
  VideoData({this.timeStamp, this.note});

  @HiveField(0)
  String timeStamp;

  @HiveField(1)
  String note;

  @override
  VideoData toData() {
    return VideoData(note: note, timeStamp: timeStamp);
  }
}
