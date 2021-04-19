import 'dart:async';
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_app_n1/main.dart';

class FilePickerDemoooo extends StatefulWidget {
  @override
  _FilePickerDemooooState createState() => _FilePickerDemooooState();
}

class _FilePickerDemooooState extends State<FilePickerDemoooo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fileName;
  List<PlatformFile> _paths;
  String _directoryPath;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();
  final _listofstream = <String>[];

  // StreamController _streamController;
  StreamController<String> imgStream = StreamController<String>();

  //final  = StreamController<String>();
  // final Stream<String> _bids;
  //
  // _FilePickerDemooooState(this._bids);


  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    // setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: //['csv',],
          (_extension?.isNotEmpty ?? false)
              ? _extension?.replaceAll(' ', '').split(',')
              : null,
        withReadStream: true,

      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      PlatformFile file1 = _paths.first;
      // _fileSelected.readStream
      //     .transform(utf8.decoder)
      //     .transform(LineSplitter())
      //     .listen((value) {
      //   _listofstream.add(value); //stream into list
      // });
      //


      file1.readStream.
      transform(utf8.decoder)
          .transform(LineSplitter())
          .listen((value) {
            _listofstream.add(value);
        print("listen: $value");
      });
      // print(_paths.first.bytes);
      _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
    });
  }

  void _clearCachedFiles() {
    FilePicker.platform.clearTemporaryFiles().then((result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: result ? Colors.green : Colors.red,
          content: Text((result
              ? 'Temporary files removed with success.'
              : 'Failed to clean temporary files')),
        ),
      );
    });
  }

  void _selectFolder() {
    FilePicker.platform.getDirectoryPath().then((value) {
      setState(() => _directoryPath = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('File Picker example app'),
        ),
        body: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      // child: DropdownButton<FileType>(
                      //     hint: const Text('LOAD PATH FROM'),
                      //     value: _pickingType,
                      //     items: <DropdownMenuItem<FileType>>[
                      //       DropdownMenuItem(
                      //         child: const Text('FROM AUDIO'),
                      //         value: FileType.audio,
                      //       ),
                      //       DropdownMenuItem(
                      //         child: const Text('FROM IMAGE'),
                      //         value: FileType.image,
                      //       ),
                      //       DropdownMenuItem(
                      //         child: const Text('FROM VIDEO'),
                      //         value: FileType.video,
                      //       ),
                      //       DropdownMenuItem(
                      //         child: const Text('FROM MEDIA'),
                      //         value: FileType.media,
                      //       ),
                      //       DropdownMenuItem(
                      //         child: const Text('FROM ANY'),
                      //         value: FileType.any,
                      //       ),
                      //       DropdownMenuItem(
                      //         child: const Text('CUSTOM FORMAT'),
                      //         value: FileType.custom,
                      //       ),
                      //     ],
                      //     onChanged: (value) => setState(() {
                      //       _pickingType = value;
                      //       if (_pickingType != FileType.custom) {
                      //         _controller.text = _extension = '';
                      //       }
                      //     })),
                    ),

                    // StreamBuilder(
                    //   stream: imgStream.stream,
                    //   builder: (BuildContext ctx, AsyncSnapshot snapshot){
                    //     if(snapshot.data == null){
                    //       return Container(
                    //         child:Center(child: Text("Enter a search word")),
                    //       );
                    //     }
                    //     if(snapshot.data == "waiting"){
                    //       return Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     }
                    //     return ListView.builder(
                    //       itemCount: snapshot.data.length <= 20 ? snapshot.data.length : 20,
                    //       itemBuilder: (BuildContext context,int index){
                    //         return AnimationConfiguration.staggeredList(
                    //           position: index,
                    //           duration: const Duration(milliseconds: 375),
                    //           child: SlideAnimation(
                    //             verticalOffset: 50.0,
                    //             child: FadeInAnimation(
                    //               child: Container(
                    //                 color: Colors.grey[300],
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(8.0),
                    //                   child: ListTile(
                    //                     // leading: snapshot.data.length!=2 ? null : CircleAvatar(),
                    //                     title: Text(snapshot.data[index]["word"]),
                    //                     subtitle: Text(snapshot.data[index]["definition"]),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),



                    ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 100.0),
                      child: _pickingType == FileType.custom
                          ? TextFormField(
                        maxLength: 15,
                        autovalidateMode: AutovalidateMode.always,
                        controller: _controller,
                        decoration:
                        InputDecoration(labelText: 'File extension'),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.none,
                      )
                          : const SizedBox(),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 200.0),
                      child: SwitchListTile.adaptive(
                        title:
                        Text('Pick multiple files', textAlign: TextAlign.right),
                        onChanged: (bool value) =>
                            setState(() => _multiPick = value),
                        value: _multiPick,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                      child: Column(
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () => _openFileExplorer(),
                            child: const Text("Open file picker"),
                          ),
                          // ElevatedButton(
                          //   onPressed: () => _selectFolder(),
                          //   child: const Text("Pick folder"),
                          // ),
                          // ElevatedButton(
                          //   onPressed: () => _clearCachedFiles(),
                          //   child: const Text("Clear temporary files"),
                          // ),
//                           StreamBuilder<String>(
//                             // ignore: missing_return
//                               builder: (BuildContext context, AsyncSnapshot<
//                                   String> snapshot) {
//                                 //  if (snapshot.connectionState == ConnectionState.done) {}
//                                 //  if (!snapshot.hasData){
//                                 //    return CircularProgressIndicator();
//                                 //  }
//                                 //    return (snapshot.data);
//                                 // ignore: missing_return, missing_return, missing_return, missing_return
//                                 // }
//                                 if (snapshot.hasError) {
//                                   //return error message
//                                 }
//
//                                 if (!snapshot.hasData) {
//                                   //return a loader
//                                 }
//                                 ListView(
//                                   padding: const EdgeInsets.all(8),
//                                   children: <Widget>[
//                                     Container(
//                                       height: 50,
//                                       color: Colors.amber[600],
//                                       child: const Center(
//                                           child: Text('Entry A')),
//                                     ),
//                                     Container(
//                                       height: 50,
//                                       color: Colors.amber[500],
//                                       child: const Center(
//                                           child: Text('Entry B')),
//                                     ),
//                                     Container(
//                                       height: 50,
//                                       color: Colors.amber[100],
//                                       child: const Center(
//                                           child: Text('Entry C')),
//                                     ),
//                                   ],
//                                 );
// //else you have data
//                               List<your items> = snapshot.data;
// do your thing with ListView.builder

                        ],
                      ),
                    ),
                    // Builder(
                    //   builder: (BuildContext context) =>
                    //   _loadingPath
                    //       ? Padding(
                    //     padding: const EdgeInsets.only(bottom: 10.0),
                    //     child: const CircularProgressIndicator(),
                    //   )
                    //       : _directoryPath != null
                    //       ? ListTile(
                    //     title: const Text('Directory path'),
                    //     subtitle: Text(_directoryPath),
                    //   )
                    //       : _paths != null
                    //       ? Container(
                    //     padding: const EdgeInsets.only(bottom: 30.0),
                    //     height:
                    //     MediaQuery
                    //         .of(context)
                    //         .size
                    //         .height * 0.50,
                    //     child: Scrollbar(
                    //         child: ListView.separated(
                    //           itemCount:
                    //           _paths != null && _paths.isNotEmpty
                    //               ? _paths.length
                    //               : 1,
                    //           itemBuilder:
                    //               (BuildContext context, int index) {
                    //             final bool isMultiPath =
                    //                 _paths != null && _paths.isNotEmpty;
                    //             final String name = 'File $index: ' +
                    //                 (isMultiPath
                    //                     ? _paths
                    //                     .map((e) => e.name)
                    //                     .toList()[index]
                    //                     : _fileName ?? '...');
                    //             final path = _paths
                    //                 .map((e) => e.path)
                    //                 .toList()[index]
                    //                 .toString();
                    //
                    //             return ListTile(
                    //               title: Text(
                    //                 name,
                    //               ),
                    //               subtitle: Text(path),
                    //             );
                    //           },
                    //           separatorBuilder:
                    //               (BuildContext context, int index) =>
                    //           const Divider(),
                    //         )),
                    //   )
                    //       : const SizedBox(),
                    // ),
                  ],
                ),
              ),
            )),
      ),
    );
  }


// Widget _buildSuggestions() {
//   return new ListView.builder(
//       }
}