import 'dart:convert';
//import 'dart:html';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// class _FilePickerDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
// enum Orientation{
//   portrait,
//   landscape,


class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}
class _FilePickerDemoState extends State<FilePickerDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<PlatformFile> _paths;
  String _directoryPath;
  String _fileName;
  String _extension;
  bool _loadingPath = false;
  FileType _pickingType = FileType.any;
  bool _multiPick = false;


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
        allowedExtensions: [
          'csv',
        ],
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
      _fileSelected = _paths.first;
      //#TODO: use this stream later in the widget
      _fileSelected.readStream

     // Stream<List<int>> stream = new File('Data.txt')
       //   .openRead();

          .transform(utf8.decoder)
          .transform(LineSplitter())
          .listen((value) {
        _listofstream.add(value); //stream into list
      });
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


  Widget _getCellDataWidget(String sRowData) {
    List<String> listsplit = sRowData.split(',');
    // return Card(
    //              child: SizedBox(
    //                                                    width: 50,
    //                                                    height: 50,
    //                                                        child: Column(
    //                                                             mainAxisSize: MainAxisSize.min,
    //                                                             children: <Widget>[
    //                                                               Text(_listofstream)],  )));

    //return Text(sRowData);
    return ConstrainedBox(
        constraints: const BoxConstraints(
            maxWidth: 150, maxHeight: 140, minHeight: 140, minWidth: 150),
        // padding: const EdgeInsets.only(top: 16.0),
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
                    //padding: const EdgeInsets.only(left: 16.0),
                    child: Card(
                        elevation: 10,

                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: <Widget>[
                              ListTile(
                                onTap: () {},
                                isThreeLine: true,

                                title: Text(listsplit.elementAt(0),
                                    style: TextStyle(fontSize: 18.0)),
                                subtitle: Column(children: <Widget>[

                                  Text(listsplit.elementAt(1),
                                    style: TextStyle(fontSize: 18.0),),
                                  Text(listsplit.elementAt(2),
                                      style: TextStyle(fontSize: 18.0))
                                ], //Text(listsplit.elementAt(2)),

                                ),),
                            ]
                        )


                    ),
                  ),
                ),
              ),
            ]));
    //   child: Container(
    //                   padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
    //                   //height: 220,
    //                   //width: double.maxFinite,
    //                    width: 100,
    //                    height: 100,
    //                   child: Card(
    //                           elevation: 10,
    //
    //
    //                           child: ListTile(
    //                                           isThreeLine: true,
    //                                           title: Text(listsplit.elementAt(0)),
    //                                           subtitle: Column(children:<Widget>[Text(listsplit.elementAt(1)),Text(listsplit.elementAt(2))],)
    //
    //                               ),
    //         ),
    //   ),
    // );
  }

  // Widget portrait(String sRowData){
  //   List<String> listsplit = sRowData.split(',');
  //   // return Card(
  //   //              child: SizedBox(
  //   //                                                    width: 50,
  //   //                                                    height: 50,
  //   //                                                        child: Column(
  //   //                                                             mainAxisSize: MainAxisSize.min,
  //   //                                                             children: <Widget>[
  //   //                                                               Text(_listofstream)],  )));
  //
  //   //return Text(sRowData);
  //   return ConstrainedBox(
  //       constraints: const BoxConstraints(
  //           maxWidth: 150, maxHeight: 140, minHeight: 140, minWidth: 150),
  //       // padding: const EdgeInsets.only(top: 16.0),
  //       child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Flexible(
  //               flex: 8,
  //               child: ClipRRect(
  //                 child: Container(
  //                   alignment: FractionalOffset.center,
  //                   //child: new Row(
  //                   decoration: BoxDecoration(
  //                       borderRadius:
  //                       const BorderRadius.all(Radius.circular(12.0)),
  //                       color: Colors.purple),
  //                   width: 220,
  //                   height: 220,
  //                   //padding: const EdgeInsets.only(left: 16.0),
  //                   child: Card(
  //                       elevation: 10,
  //
  //                       child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //
  //                           children:<Widget>[
  //                             ListTile(
  //                               onTap: (){},
  //                               isThreeLine: true,
  //
  //                               title: Text(listsplit.elementAt(0),
  //                                   style: TextStyle(fontSize: 18.0)  ),
  //                               subtitle: Column(children:<Widget>[
  //
  //                                 Text( listsplit.elementAt(1), style: TextStyle(fontSize: 18.0),  ),
  //                                 Text(listsplit.elementAt(2), style: TextStyle(fontSize: 18.0))],//Text(listsplit.elementAt(2)),
  //
  //                               ),  ),]
  //                       )
  //
  //
  //                   ),
  //                 ),
  //               ),
  //             ),]));
  //   //   child: Container(
  //   //                   padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
  //   //                   //height: 220,
  //   //                   //width: double.maxFinite,
  //   //                    width: 100,
  //   //                    height: 100,
  //   //                   child: Card(
  //   //                           elevation: 10,
  //   //
  //   //
  //   //                           child: ListTile(
  //   //                                           isThreeLine: true,
  //   //                                           title: Text(listsplit.elementAt(0)),
  //   //                                           subtitle: Column(children:<Widget>[Text(listsplit.elementAt(1)),Text(listsplit.elementAt(2))],)
  //   //
  //   //                               ),
  //   //         ),
  //   //   ),
  //   // );
  //
  // }
  // Widget landscape(String sRowData){
  //   List<String> listsplit = sRowData.split(',');
  //   // return Card(
  //   //              child: SizedBox(
  //   //                                                    width: 50,
  //   //                                                    height: 50,
  //   //                                                        child: Column(
  //   //                                                             mainAxisSize: MainAxisSize.min,
  //   //                                                             children: <Widget>[
  //   //                                                               Text(_listofstream)],  )));
  //
  //   //return Text(sRowData);
  //   return ConstrainedBox(
  //       constraints: const BoxConstraints(
  //           maxWidth: 150, maxHeight: 140, minHeight: 140, minWidth: 150),
  //       // padding: const EdgeInsets.only(top: 16.0),
  //       child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Flexible(
  //               flex: 8,
  //               child: ClipRRect(
  //                 child: Container(
  //                   alignment: FractionalOffset.center,
  //                   //child: new Row(
  //                   decoration: BoxDecoration(
  //                       borderRadius:
  //                       const BorderRadius.all(Radius.circular(12.0)),
  //                       color: Colors.purple),
  //                   width: 220,
  //                   height: 220,
  //                   //padding: const EdgeInsets.only(left: 16.0),
  //                   child: Card(
  //                       elevation: 10,
  //
  //                       child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //
  //                           children:<Widget>[
  //                             ListTile(
  //                               onTap: (){},
  //                               isThreeLine: true,
  //
  //                               title: Text(listsplit.elementAt(0),
  //                                   style: TextStyle(fontSize: 18.0)  ),
  //                               subtitle: Column(children:<Widget>[
  //
  //                                 Text( listsplit.elementAt(1), style: TextStyle(fontSize: 18.0),  ),
  //                                 Text(listsplit.elementAt(2), style: TextStyle(fontSize: 18.0))],//Text(listsplit.elementAt(2)),
  //
  //                               ),  ),]
  //                       )
  //
  //
  //                   ),
  //                 ),
  //               ),
  //             ),]));
  //   //   child: Container(
  //   //                   padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
  //   //                   //height: 220,
  //   //                   //width: double.maxFinite,
  //   //                    width: 100,
  //   //                    height: 100,
  //   //                   child: Card(
  //   //                           elevation: 10,
  //   //
  //   //
  //   //                           child: ListTile(
  //   //                                           isThreeLine: true,
  //   //                                           title: Text(listsplit.elementAt(0)),
  //   //                                           subtitle: Column(children:<Widget>[Text(listsplit.elementAt(1)),Text(listsplit.elementAt(2))],)
  //   //
  //   //                               ),
  //   //         ),
  //   //   ),
  //   // );
  //
  // }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.grey,

            appBar: AppBar(
              //title: const Text('File Picker example app'),
                title: ElevatedButton(

                  onPressed: () => _openFileExplorer(),
                  child: Text('file pick'),

                )),
            body: Center(
                child: Column(
                  children:<Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
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
                              constraints: const BoxConstraints.tightFor(
                                  width: 100.0),
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
                            // ConstrainedBox(
                            //   constraints: const BoxConstraints.tightFor(
                            //       width: 200.0),
                            //   child: SwitchListTile.adaptive(
                            //     title:
                            //     Text('Pick multiple files',
                            //         textAlign: TextAlign.right),
                            //     onChanged: (bool value) =>
                            //         setState(() => _multiPick = value),
                            //     value: _multiPick,
                            //   ),
                            // ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 50.0, bottom: 20.0),
//                               child: Column(
//                                 children: <Widget>[
//                                   ElevatedButton(
//                                     onPressed: () => _openFileExplorer(),
//                                     child: const Text("Open file picker"),
//                                   ),
//                                   // ElevatedButton(
//                                   //   onPressed: () => _selectFolder(),
//                                   //   child: const Text("Pick folder"),
//                                   // ),
//                                   // ElevatedButton(
//                                   //   onPressed: () => _clearCachedFiles(),
//                                   //   child: const Text("Clear temporary files"),
//                                   // ),
// //                           StreamBuilder<String>(
// //                             // ignore: missing_return
// //                               builder: (BuildContext context, AsyncSnapshot<
// //                                   String> snapshot) {
// //                                 //  if (snapshot.connectionState == ConnectionState.done) {}
// //                                 //  if (!snapshot.hasData){
// //                                 //    return CircularProgressIndicator();
// //                                 //  }
// //                                 //    return (snapshot.data);
// //                                 // ignore: missing_return, missing_return, missing_return, missing_return
// //                                 // }
// //                                 if (snapshot.hasError) {
// //                                   //return error message
// //                                 }
// //
// //                                 if (!snapshot.hasData) {
// //                                   //return a loader
// //                                 }
// //                                 ListView(
// //                                   padding: const EdgeInsets.all(8),
// //                                   children: <Widget>[
// //                                     Container(
// //                                       height: 50,
// //                                       color: Colors.amber[600],
// //                                       child: const Center(
// //                                           child: Text('Entry A')),
// //                                     ),
// //                                     Container(
// //                                       height: 50,
// //                                       color: Colors.amber[500],
// //                                       child: const Center(
// //                                           child: Text('Entry B')),
// //                                     ),
// //                                     Container(
// //                                       height: 50,
// //                                       color: Colors.amber[100],
// //                                       child: const Center(
// //                                           child: Text('Entry C')),
// //                                     ),
// //                                   ],
// //                                 );
// // //else you have data
// //                               List<your items> = snapshot.data;
// // do your thing with ListView.builder
//
//                                 ],
//                               ),
//                             ),


                          ],
                        ),
                      )),
                   Container(
              //
              //       //Container(
              //       //padding: EdgeInsets.only(right: 10),
              //       // OR
                      margin: EdgeInsets.only(right: 10),
              //          //child:Column(
              //         //padding: EdgeInsets.all(32),
                       child: OrientationBuilder(
              //             // ignore: missing_return
                           builder: (context, orientation) {
              //               // if(orientation ==Orientation.portrait){
              //               //     //return _getCellDataWidget();
              //               //
              //               // }
              //               // else{
              //               //
              //               //   return _getCellDataWidget();
              //               // }
              //
              //
                             return GridView.count(
              //                 // itemCount: images.length,
              //                 //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //                 //      crossAxisCount: 2,
              //                 //      crossAxisSpacing: 4.0,
              //                 //      mainAxisSpacing: 4.0
                                 crossAxisCount: orientation == Orientation.portrait
                                    ? 2
                                     : 3,
              //                   // crossAxisSpacing: 4.0,
              //                   // mainAxisSpacing: 8.0,
                                 children: _listofstream.map((value) => _getCellDataWidget(value))
                                      .toList()
                             );
                           })),
              //
               ] ))));
  }


//child:Column(
//      mainAxisAlignment: MainAxisAlignment.start,
// ignore: missing_return

//
//                           children: <Widget>[
//                                   Container(
//                                     child: Column(
//                                       children: <Widget>[
//                                         ElevatedButton(
//                                           onPressed: () => _openFileExplorer(),
//                                           child: const Text("Open file picker"),
//                                         ),],),),
//                                   Container(                                       //yeh chaiye list from stream ke liye
//                                     height: 650,
//                                     width: 1600,
//                                     color: Colors.grey,
//                                     child: ListView.builder(
//                                         itemCount: _listofstream.length,
//                                         itemBuilder: (BuildContext context, int index) {//return new Text(_listofstream[index]);
//                                           // ListView.builder(
//                                           //     itemCount: 3, // the length
//                                           //     itemBuilder: (context, index) {
//                                                 return Container(
//                                                   padding: const EdgeInsets.only(bottom: 8),
//                                                   child: Card(
//                                                      child: SizedBox(
//                                                      width: 50,
//                                                      height: 50,
//                                                          child: Column(
//                                                               mainAxisSize: MainAxisSize.min,
//                                                               children: <Widget>[
//                                                                 Text(_listofstream[index]),],  ),
//     )),);}))
//     ],),  ),});});
//
//
//
//
//
//
//   //<------------------------------------------>
//
// //<------------Useful code is above ------------->
//
//
//
//
//
//
// //
// // body:Container(
// // //padding: ,
// // child:OrientationBuilder(
// // builder: (BuildContext context, Orientation orientation) {
// // switch (orientation) {
// // case Orientation.portrait:
// // return Container();
// // case Orientation.landscape:
// // return Container();
// // }
// // return null;
// // }),
// // )
}