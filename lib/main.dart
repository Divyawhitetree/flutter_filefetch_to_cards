import 'dart:convert';
//import 'dart:html';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//enum Orientation{
//portrait,
//landscape,

//}

void main(){
  runApp(FilePickerDemo());
}
class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<PlatformFile> _paths;
  String _directoryPath;
  String _extension;
  //bool _loadingPath = false;
  TextEditingController _controller = TextEditingController();
  final _listofstream = <String>[];
  PlatformFile _fileSelected;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        allowedExtensions:
         (_extension?.isNotEmpty ?? false)
              ? _extension?.replaceAll(' ', '').split(',')
              : null,
       
//         [
//           'csv',
//         ],
        withReadStream: true,
      ))
          ?.files;
      setState(() {
        if (!mounted) {
          return;
        }
        //_loadingPath = false;
        _fileSelected = _paths.first;
        //#TODO: use this stream later in the widget
        _fileSelected.readStream
            .transform(utf8.decoder)
            .transform(LineSplitter())
            .listen((value) {
          _listofstream.add(value); //stream into list
        });
      });

    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    }

  Widget _getCellDataWidget(String sRowData) {
    List<String> listsplit = sRowData.split(',');
    return ConstrainedBox(
        constraints: const BoxConstraints(
            maxWidth: 150, maxHeight: 140, minHeight: 140, minWidth: 150),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 8,
                child: ClipRRect(
                  child: Container(
                    alignment: FractionalOffset.center,
                    //child: new Row(
                    decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(12.0)),
                        color: Colors.purple),
                    width: 220,
                    height: 220,
                    child: Card(
                        elevation: 10,
                        child: Column(children: <Widget>[
                          ListTile(
                            onTap: () {},
                            isThreeLine: true,
                            title: Text(listsplit.elementAt(0),
                                style: TextStyle(fontSize: 30.0)),
                            subtitle: Column(
                              children: <Widget>[
                                Text(listsplit.elementAt(1),
                                    style: TextStyle(fontSize: 18.0)),
                                Text(listsplit.elementAt(2),
                                    style: TextStyle(fontSize: 18.0))
                              ], //Text(listsplit.elementAt(2)),
                            ),
                          ),
                        ])),
                  ),
                ),
              ),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.grey,
            appBar: AppBar(
                title: ElevatedButton(
                  onPressed: () => _openFileExplorer(),
                  child: Text('file pick'),
                )),
            body: Center(
              child: Container(
                  margin: EdgeInsets.only(right: 10),

                  //padding: EdgeInsets.all(32),
                  child: OrientationBuilder(builder: (context, orientation) {
                    return GridView.count(
                        crossAxisCount:
                        orientation == Orientation.portrait ? 2 : 3,
                        children: _listofstream
                            .map((value) => _getCellDataWidget(value))
                            .toList());
                  })),
            )));
  }
}
