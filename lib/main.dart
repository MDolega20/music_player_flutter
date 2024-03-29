import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model/MusicModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = MusicModel();
    model.findSounds();

    return ScopedModel<MusicModel>(
      model: model,
      child: MaterialApp(
        title: 'Music player',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Library(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MusicModel>(builder: (context, child, model) {
      if (model.loading && model.error == null) {
        return Loading();
      } else {
        return _build(context);
      }
    });
  }

  Widget _build(BuildContext context) {
    return ScopedModelDescendant<MusicModel>(
        builder: (context, child, model) => Scaffold(
              appBar: AppBar(
                title: Text("All songs"),
                actions: <Widget>[
                  InkWell(
                    onTap: () => model.stopTrack(),
                    child: Icon(Icons.stop),
                  )
                ],
              ),
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark,
                child: Stack(
                  children: <Widget>[
//                _tracks(context, model), //TODO temporary
                    ControlsBottom()
                  ],
                ),
              ),
            ));
  }

  Widget _tracks(BuildContext context, model) {
    return ListView.builder(
        itemCount: model.tracks.length,
        itemBuilder: (context, index) {
          final item = model.tracks[index];
          return GestureDetector(
            //TODO  recognize gestures on text or icon but not on background
            onTap: () => model.playTrack(index),
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.title,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        item.author,
//                                    style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  InkWell(
                    child: Icon(Icons.menu),
                  ),
                ],
              ),
            ),
          );
        });
  }
} //NOT USED

class Library extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MusicModel>(builder: (context, child, model) {
      if (model.loading && model.error == null) {
        return Loading();
      } else {
        return _build(context);
      }
    });
  }

  Widget _build(BuildContext context) {
    return ScopedModelDescendant<MusicModel>(
        builder: (context, child, model) => Scaffold(
              appBar: AppBar(title: Text("Library")),
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark,
                child: Stack(
                  children: <Widget>[
                    _tracks(context, model), //TODO temporary
                    ControlsBottom()
                  ],
                ),
              ),
            ));
  }

  Widget _tracks(BuildContext context, model) {
    return ListView.builder(
        itemCount: model.tracks.length,
        itemBuilder: (context, index) {
          final item = model.tracks[index];
          final isPlayed = item == model.track ? true : false;

          return GestureDetector(
            //TODO  recognize gestures on text or icon but not on background
            onTap: () => model.playTrack(index),
            child: Container(
              child: Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.title,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: isPlayed
                                  ? FontWeight.w600
                                  : FontWeight.w400), //TODO temporary
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          item.author,
//                                    style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    InkWell(
                      child: Icon(Icons.menu),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class ControlsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MusicModel>(
      builder: (context, child, model) => _build(context, model),
    );
  }

  Widget _build(BuildContext context, model) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: <Widget>[
          _current(context, model),
          Padding(
            padding: EdgeInsets.only(bottom: 5, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Icon(
                    Icons.arrow_left,
                    size: 50,
                  ),
                  onTap: () => model.prevTrack(),
                ),
                InkWell(
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          model.isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 60,
                        ),
                      )),
                  onTap: () => model.toggleTrack(),
                ),
                InkWell(
                  child: Icon(
                    Icons.arrow_right,
                    size: 50,
                  ),
                  onTap: () => model.nextTrack(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _current(BuildContext context, model) { //TODO fix this error
    if (model.track != null) {
      return Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(model.track.title, style: TextStyle(fontSize: 20),),
            Text(" - ", style: TextStyle(fontSize: 20),),
            Text(model.track.author, style: TextStyle(fontSize: 20),)
          ],
        ),
      );
    }
    return Container();
  }
}

class AppBarCustom extends StatelessWidget {
  //TODO in progress
  final title;
  final actions; // <Widget>[]

  AppBarCustom({@required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("LoAdInG");
  }
}
