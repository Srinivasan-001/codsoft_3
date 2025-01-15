import 'package:flutter_application_3/models/playlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/components/my_drawer.dart';
import 'package:flutter_application_3/models/song.dart';
import 'package:flutter_application_3/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get the play list provider
  late final dynamic playlistprovider;
  @override
  void initState() {
    
    super.initState();
    //get playlist provider
    playlistprovider = Provider.of<Playlistprovider>(context, listen: false);
  }

  // go to a song
  void goToSong(int songindex) {
//update current song index
    playlistprovider.currentsongIndex = songindex;

//navigation to song page
Navigator.push(context,
 MaterialPageRoute(builder: (context)=> SongPage(),
),
);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("P L A Y L I S T"),
      ),
      drawer: const MyDrawer(),
      body: Consumer<Playlistprovider>(
        builder: (context, value, child) {
          //get the playlist
          final List<Song> playlist = value.playlist;
          // return list view ui
          return ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index) {
                //get the individual song
                final Song song = playlist[index];

                //return list title ui
                return ListTile(
                  title: Text(song.songName),
                  subtitle: Text(song.artistName),
                  leading: Image.asset(song.albumArtImagePath),
                  onTap: () => goToSong(index),
                );
              });
        },
      ),
    );
  }
}
