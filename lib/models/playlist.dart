import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/song.dart';

class Playlistprovider extends ChangeNotifier {
//playlist of song
  final List<Song> _playlist = [
//song 1
    Song(
        songName: "so sick",
        artistName: "Neyo",
        albumArtImagePath: "assets/images/maaye-sky-force-500-500.jpg",
        audioPath:
            "audio/Dum Hai To Rok Ke Bata Pushpa 2 The Rule 128 Kbps.mp3"),

//song 2
    Song(
        songName: "puspha",
        artistName: "sunniravo",
        albumArtImagePath: "assets/images/kissik-pushpa-2-the-rule-500-500.jpg",
        audioPath: "audio/Kissik Pushpa 2 The Rule 128 Kbps.mp3"),

//song 3
    Song(
        songName: "Rappp",
        artistName: "kunilrachno",
        albumArtImagePath:
            "assets/images/dum-hai-to-rok-ke-bata-pushpa-2-the-rule-500-500.jpg",
        audioPath: "audio/Maaye Sky Force 128 Kbps.mp3"),
  ];
// current song paying index
  int? _currentSongIndex;
  /*
  AUDIO PLAYER





  */
// audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

//duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
//constructor
  Playlistprovider() {
    listenToDuration();
  }
//initally notplaying
  bool _isPlaying = false;
//play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); //stop current song
    await _audioPlayer.play(AssetSource(path)); // play  new song
    _isPlaying = true;
    notifyListeners();
  }

//pause the song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

//resume the song
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

//pause or resume
  void pauseOrResume() {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

// seek to specific possition
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

//play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        // go next song if it si not a lost song
        currentsongIndex = _currentSongIndex! + 1;
      } else {
        //it's the last song loo[ back to first song
        currentsongIndex = 0;
      }
    }
  }

//play previous song
  void playPreviousSong() async {
    // if more than 2 seconds have passed ,reset  current song
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    }
    //if it's within first 2 seconds of the song ,go to previus song
    else {
      if (_currentSongIndex! > 0) {
        currentsongIndex = _currentSongIndex! - 1;
      } else {
        //if it's the first song ,loop back to last song
        currentsongIndex = _playlist.length - 1;
      }
    }
  }

//lisyt of duration
  void listenToDuration() {
// listern for totl durtion
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
//listern for current duration
    _audioPlayer.onPositionChanged.listen((newposition) {
      _currentDuration = newposition;
      notifyListeners();
    });
// listern for song  completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }
//dispose audio pllayer

  /*
  GETTERS


  */
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  /*
  SETTTERS



  */
  set currentsongIndex(int? newIndex) {
    //update current song
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play(); // paly the song at the new index
    }
    //update ui
    notifyListeners();
  }
}
