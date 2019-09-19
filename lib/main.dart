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
    return ScopedModelDescendant<MusicModel>(
        builder: (context, child, model) {
          if(!model.loading && model.error == null){
            return _placeholder(context);
          }else{
            return _build(context);
          }
        }
    );

  }

  Widget _build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("List of songs"),
      ),
      body: ScopedModelDescendant<MusicModel>(
        builder: (context, child, model) => AnnotatedRegion<SystemUiOverlayStyle>(
          child: ListView.builder(itemCount: model.tracks.length,
              itemBuilder: (context, index){
                final item = model.tracks[index];
                return Text(item.title);
              })
          ,
        ),
      ),
    );
  }
  Widget _placeholder(BuildContext context){
    //TODO loading screen
    return Text("LOADING");
  }
}
