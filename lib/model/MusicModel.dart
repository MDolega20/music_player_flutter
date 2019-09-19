import 'package:scoped_model/scoped_model.dart';

// ideas
// https://github.com/iampawan/Flutter-Music-Player/blob/master/lib/data/song_data.dart
// https://github.com/florent37/Flutter-AssetsAudioPlayer


class MusicModel extends Model{
  Track _song;
  List<Track> tracks = [];
  bool loading = true;
  String error;

  void findSounds() {
    loading = true;
    List<Track> _tracks = [
      Track(title:"Nazwa utworu 1", author:"Autor", assetName:"track01.mp3", assetFolder: "music"),
      Track(title:"Nazwa utworu 2", author:"Autor", assetName:"track01.mp3", assetFolder: "music"),
      Track(title:"Nazwa utworu 3", author:"Autor", assetName:"track01.mp3", assetFolder: "music"),
      Track(title:"Nazwa utworu 4", author:"Autor", assetName:"track01.mp3", assetFolder: "music"),
      Track(title:"Nazwa utworu 5", author:"Autor", assetName:"track01.mp3", assetFolder: "music"),
    ];

    tracks = _tracks;

    loading = false;
    notifyListeners();
  }
}

class Track {
  String title;
  String author;
  String assetName;
  String assetFolder;

  Track({this.title, this.author, this.assetName, this.assetFolder});
}