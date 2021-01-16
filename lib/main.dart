import 'package:drawing_area/drawing_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DrawingAreaController _controller = DrawingAreaController();
  Color _pickerColor = Colors.black;

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: DrawingArea(
          controller: _controller,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: _showColorDialog,
                tooltip: 'Change color',
                child: Icon(Icons.colorize),
              ),
              SizedBox(width: 10),
              FloatingActionButton(
                onPressed: () {
                  _controller.clear();
                },
                tooltip: 'Clear canvas',
                child: Icon(Icons.clear),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  _controller.changeBrushSize(1);
                },
                tooltip: 'Increase brush size',
                child: Icon(Icons.plus_one),
              ),
              SizedBox(width: 10),
              FloatingActionButton(
                onPressed: () {
                  _controller.changeBrushSize(-1);
                },
                tooltip: 'Decrease brush size',
                child: Icon(Icons.exposure_minus_1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void changeColor(Color color) {
    setState(() => _pickerColor = color);
  }

  Future<void> _showColorDialog() async {
    return showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: _pickerColor,
            onColorChanged: changeColor,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() => _controller.changeColor(_pickerColor));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
