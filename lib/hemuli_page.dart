import 'package:flutter/material.dart';
import 'src/color_changer.dart';

class HemuliPage extends StatefulWidget {
  @override
  _HemuliPageState createState() => _HemuliPageState();
}

class _HemuliPageState extends State<HemuliPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double _hemuli = 0;

  @override
  Widget build(BuildContext context) {
    return buildHemuliSlider();
  }

  Widget buildHemuliSlider() {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Hemuli ' + _hemuli.toInt().toString()),
          backgroundColor: getRandomColor(),
        ),
        body: SingleChildScrollView(child: Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                Image.network(
                    "https://vignette.wikia.nocookie.net/muumitalo/images/4/4a/Hemuli_juoksee_sarvikuonoa_pakoon.png/revision/latest?cb=20180422191047"),
                _buildSlider(setState),
                TextField(
                  onSubmitted: (value) => _showHemuliSnackBar(value),
                  decoration: InputDecoration(
                      hintText: "Syötä oma Hemulinimi",
                      contentPadding: EdgeInsets.all(16.0)),
                ),
                TextField(
                  onSubmitted: (value) => _showHemuliSnackBar(value),
                  decoration: InputDecoration(
                      hintText: "Lisää hemuliunelma",
                      contentPadding: EdgeInsets.all(16.0)),
                )
              ],
            );
          },
        )));
  }

  Widget _buildSlider(StateSetter _setState) {
    return Slider(
      divisions: 10,
      label: _hemuli.toString(),
      value: _hemuli,
      onChanged: (newValue) => _setState(() {
        _hemuli = newValue;
      }),
      onChangeEnd: (newValue) => _setState(() {
        _showHemuliSnackBar(newValue.toInt().toString());
      }),
      min: 0.0,
      max: 20.0,
    );
  }

  Widget _createHemuliSnackBar(String _value) {
    return SnackBar(
      backgroundColor: Colors.cyan,
      duration: new Duration(milliseconds: 100),
      content: Text('Hemuli changed! ' + _value),
    );
  }

  void _showHemuliSnackBar(String _value) {
    print(_value);
    _scaffoldKey.currentState.showSnackBar(_createHemuliSnackBar(_value));
  }
}
