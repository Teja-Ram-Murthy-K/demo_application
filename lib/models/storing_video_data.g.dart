// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storing_video_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoDataAdapter extends TypeAdapter<VideoData> {
  @override
  final int typeId = 1;

  @override
  VideoData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoData(
      timeStamp: fields[0] as String,
      note: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VideoData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.timeStamp)
      ..writeByte(1)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
