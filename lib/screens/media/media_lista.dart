import 'package:flutter/material.dart';
import 'package:mediaconsumo/data/media_helper.dart';
import 'package:mediaconsumo/models/media.dart';
import 'package:mediaconsumo/screens/media/media_add.dart';
import 'package:mediaconsumo/screens/media/media_detalhes.dart';
import 'package:mediaconsumo/utils/ini/media_ini.dart';
import 'package:mediaconsumo/utils/utils/date.dart';

class MediaList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MediaListState();
  }
}

class _MediaListState extends State {
  var dbHelper = new MediaHelper();
  var txt = MediaTexto();

  List<Media> media;
  int mediaCount = 0;

  @override
  void initState() {
    getMedias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(txt.lista),
      ),
      body: buildMediaList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addMedia();
        },
        child: Icon(Icons.add),
        tooltip: txt.cadastra,
      ),
    );
  }

  ListView buildMediaList() {
    var dataUtils = DataUtils();
    return ListView.builder(
      itemCount: mediaCount,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.green[700],
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green[900],
              child: Icon(
                Icons.calculate_outlined,
                color: Colors.white,
              ),
            ),
            title: Text(
              this.media[position].veiculo +
                  ": " +
                  this.media[position].media.toStringAsFixed(2),
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              dataUtils.parseDateReverse(this.media[position].data.toString()),
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              detalhes(this.media[position]);
            },
          ),
        );
      },
    );
  }

  void addMedia() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MediaAdd()));
    if (result != null) {
      if (result) {
        getMedias();
      }
    }
  }

  void getMedias() async {
    var mediaFuture = dbHelper.getMedias();
    mediaFuture.then((data) {
      setState(() {
        this.media = data;
        mediaCount = data.length;
      });
    });
  }

  void detalhes(Media media) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => MediasDetalhes(media)));
    if (result != null) {
      if (result) {
        getMedias();
      }
    }
  }
}
