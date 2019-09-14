import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model/MusicModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MusicModel>(
      model: MusicModel(),
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
  void initState() {
    super.initState();
    ScopedModel.of<MusicModel>(context).findSounds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of songs"),
      ),
      body: ScopedModelDescendant<MusicModel>(
          builder: (context, child, model) => AnnotatedRegion<SystemUiOverlayStyle>(
          child: ListView.builder(itemCount: model.all.length,
              itemBuilder: (context, index){
            final item = model.all[index];
              return Text(item.title);
          })
        ,
        ),
      ),
    );
  }
}
