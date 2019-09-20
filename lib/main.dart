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
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MusicModel>(builder: (context, child, model) {
      if (model.loading && model.error == null) {
        return _placeholder(context);
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
                    _tracks(context, model),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 5, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              child: Icon(
                                Icons.arrow_left,
                                size: 50,
                              ),
                              onTap: () {}, //TODO preverious track
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
                                      model.isPlaying ? Icons.pause : Icons.play_arrow
                                      , //TODO icon change
                                      size: 60,
                                    ),
                                  )),
                              onTap: () => model.stopTrack(),
                            ),
                            InkWell(
                              child: Icon(
                                Icons.arrow_right,
                                size: 50,
                              ),
                              onTap: () {}, //TODO next track
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  Widget _placeholder(BuildContext context) {
    //TODO loading screen
    return Text("LOADING");
  }

  Widget _tracks(BuildContext context, model) {
    return ListView.builder(
        itemCount: model.tracks.length,
        itemBuilder: (context, index) {
          final item = model.tracks[index];
          return GestureDetector(
            onTap: () => model.playTrack(item),
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
}
