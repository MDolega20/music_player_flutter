import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:scoped_model/scoped_model.dart';

// idea
// https://github.com/florent37/Flutter-AssetsAudioPlayer

class MusicModel extends Model {
  Track track;
  List<Track> tracks = [];
  List<Track> favourite = [];
  bool loading = true;
  String error;
  bool isPlaying = false;

  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  void findSounds() {
    loading = true;
    List<Track> _tracks = [
      Track(
          title: "Nazwa utworu 1",
          author: "Autor 1",
          assetName: "track01.mp3",
          assetFolder: "music"),
      Track(
          title: "Nazwa utworu 2",
          author: "Autor 2",
          assetName: "track01.mp3",
          assetFolder: "music"),
      Track(
          title: "Nazwa utworu 3",
          author: "Autor 3",
          assetName: "track01.mp3",
          assetFolder: "music"),
      Track(
          title: "Nazwa utworu 4",
          author: "Autor 4",
          assetName: "track01.mp3",
          assetFolder: "music"),
      Track(
          title: "Nazwa utworu 5",
          author: "Autor 5",
          assetName: "track01.mp3",
          assetFolder: "music"),
    ];

    tracks = _tracks;

    loading = false;
    notifyListeners();
  }

  void playTrack(Track _track) {
    if (track != null || track != _track) {
      track = _track;

      assetsAudioPlayer.stop();
      isPlaying = false;

      assetsAudioPlayer.open(AssetsAudio(
        asset: _track.assetName,
        folder: "assets/${_track.assetFolder}/",
      ));
    }
    assetsAudioPlayer.play();
    isPlaying = true;



    notifyListeners();
  }

  void stopTrack() {
//    final PlayingAudio playing = assetsAudioPlayer.current.value;
//
//    assetsAudioPlayer.current.listen((playingAudio){
//      final asset = playingAudio.assetAudio;
//      final songDuration = playingAudio.duration;
//    });

    assetsAudioPlayer.playOrPause();
    isPlaying = false;
  }


}

class Track {
  String title;
  String author;
  String assetName;
  String assetFolder;
  String duration = null;
  String image = "default.jpg";

  Track(
      {
        this.title,
      this.author,
      this.assetName,
      this.assetFolder,
      this.duration,
      this.image});
}
