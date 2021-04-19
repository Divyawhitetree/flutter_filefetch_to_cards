// import 'dart:convert';
// //import 'dart:html';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:transparent_image/transparent_image.dart';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// // class _FilePickerDemo extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container();
// //   }
// // }
// enum Orientation{
//   portrait,
//   landscape,
//
// }
// class FilePickerDemo extends StatefulWidget {
//   @override
//   _FilePickerDemoState createState() => _FilePickerDemoState();
// }
// class _FilePickerDemoState extends State<FilePickerDemo> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   List<PlatformFile> _paths;
//   String _directoryPath;
//   String _extension;
//   bool _loadingPath = false;
//   TextEditingController _controller = TextEditingController();
//   final _listofstream = <String>[];
//   PlatformFile _fileSelected;
//
//   String get value => null;
//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() => _extension = _controller.text);
//   }
//
//   void _openFileExplorer() async {
//     try {
//       _directoryPath = null;
//       _paths = (await FilePicker.platform.pickFiles(
//         allowedExtensions: [
//           'csv',
//         ],
//         withReadStream: true,
//       ))
//           ?.files;
//     } on PlatformException catch (e) {
//       print("Unsupported operation" + e.toString());
//     } catch (ex) {
//       print(ex);
//     }
//     if (!mounted) return;
//     setState(() {
//       _loadingPath = false;
//       _fileSelected = _paths.first;
//       //#TODO: use this stream later in the widget
//       _fileSelected.readStream
//           .transform(utf8.decoder)
//           .transform(LineSplitter())
//           .listen((value) {
//         _listofstream.add(value); //stream into list
//       });
//     });
//   }
//   // Widget _portraitView(){
//   //
//   //   // Return Your Widget View Here Which you want to Load on Portrait Orientation.
//   //   return Container(
//   //       width: 300.00,
//   //       color: Colors.green,
//   //       padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//   //       child: Text(' Portrait View Detected. ',
//   //           textAlign: TextAlign.center,
//   //           style: TextStyle(fontSize: 24, color: Colors.white)));
//   // }
//   //
//   // Widget _landscapeView(){
//   //
//   //   // // Return Your Widget View Here Which you want to Load on Landscape Orientation.
//   //   return Container(
//   //       width: 300.00,
//   //       color: Colors.pink,
//   //       padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//   //       child: Text(' Landscape View Detected.',
//   //           textAlign: TextAlign.center,
//   //           style: TextStyle(fontSize: 24, color: Colors.white)));
//   // }
//
//   Widget _getCellDataWidget(String sRowData)
//   {
//     List<String> listsplit = sRowData.split(',');
//     // return Card(
//     //              child: SizedBox(
//     //                                                    width: 50,
//     //                                                    height: 50,
//     //                                                        child: Column(
//     //                                                             mainAxisSize: MainAxisSize.min,
//     //                                                             children: <Widget>[
//     //                                                               Text(_listofstream)],  )));
//
//     //return Text(sRowData);
//     return ConstrainedBox(
//         constraints: const BoxConstraints(
//             maxWidth: 150, maxHeight: 140, minHeight: 140, minWidth: 150),
//         // padding: const EdgeInsets.only(top: 16.0),
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Flexible(
//                 flex: 8,
//                 child: ClipRRect(
//                   child: Container(
//                     alignment: FractionalOffset.center,
//                     //child: new Row(
//                     decoration: BoxDecoration(
//                         borderRadius:
//                         const BorderRadius.all(Radius.circular(12.0)),
//                         color: Colors.purple),
//                     width: 220,
//                     height: 220,
//
//                     //padding: const EdgeInsets.only(left: 16.0),
//                     child: Card(
//                         elevation: 10,
//
//                         child: Column(
//                             children:<Widget>[
//                               ListTile(
//                                 onTap: (){},
//                                 isThreeLine: true,
//                                 title: Text(listsplit.elementAt(0),
//                                     style: TextStyle(fontSize: 30.0)  ),
//                                 subtitle: Column(children:<Widget>[Text(listsplit.elementAt(1), style: TextStyle(fontSize: 18.0)),Text(listsplit.elementAt(2), style: TextStyle(fontSize: 18.0))],//Text(listsplit.elementAt(2)),
//
//                                 ),  ),]
//                         )
//
//
//                     ),
//                   ),
//                 ),
//               ),]));
//     //   child: Container(
//     //                   padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
//     //                   //height: 220,
//     //                   //width: double.maxFinite,
//     //                    width: 100,
//     //                    height: 100,
//     //                   child: Card(
//     //                           elevation: 10,
//     //
//     //
//     //                           child: ListTile(
//     //                                           isThreeLine: true,
//     //                                           title: Text(listsplit.elementAt(0)),
//     //                                           subtitle: Column(children:<Widget>[Text(listsplit.elementAt(1)),Text(listsplit.elementAt(2))],)
//     //
//     //                               ),
//     //         ),
//     //   ),
//     // );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//             key: _scaffoldKey,
//             backgroundColor: Colors.grey,
//
//             appBar: AppBar(
//               //title: const Text('File Picker example app'),
//                 title:  ElevatedButton(
//
//                   onPressed: () => _openFileExplorer(),
//                   child: Text('file pick'),
//
//                 )),
//             // body: Container(
//             //   // child: Container(
//             //   //   //Container(
//             //   //   //padding: EdgeInsets.only(right: 10),
//             //   //   // OR
//             //   //     margin: EdgeInsets.only(right: 10),
//             //   //
//             //   //     //padding: EdgeInsets.all(32),
//             //   //     child: OrientationBuilder(
//             //   //         builder: (context, orientation) {
//             //   //           return GridView.count(
//             //   //             // itemCount: images.length,
//             //   //             //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             //   //             //      crossAxisCount: 2,
//             //   //             //      crossAxisSpacing: 4.0,
//             //   //             //      mainAxisSpacing: 4.0
//             //   //               crossAxisCount: orientation == Orientation.portrait
//             //   //                   ? 2
//             //   //                   : 3,
//             //   //               // crossAxisSpacing: 4.0,
//             //   //               // mainAxisSpacing: 8.0,
//             //   //               children: _listofstream.map((value) => _getCellDataWidget(value))
//             //   //                   .toList()
//             //   //           );
//             //   //         })),
//             //   margin: EdgeInsets.all(12),
//             //   child:  //StaggeredGridView.extentBuilder(
//             //       StaggeredGridView.countBuilder(
//             //         crossAxisCount: 4,
//             //         itemCount: 8,
//             //         itemBuilder: (BuildContext context, int index) => new Container(
//             //             color: Colors.green,
//             //             child: new Center(
//             //
//             //
//             //                         child: Card(
//             //                         elevation: 10,
//             //                         child: Column(
//             //                             List<String> listsplit = sRowData.split(',');
//             //
//             //                             children:<Widget>[
//             //                         ListTile(
//             //                         onTap: (){},
//             //                         isThreeLine: true,
//             //                         title: Text(listsplit.elementAt(0),
//             //                         style: TextStyle(fontSize: 30.0)  ),
//             //                         subtitle: Column(children:<Widget>[Text(listsplit.elementAt(1),
//             //                                       style: TextStyle(fontSize: 18.0)),
//             //                         Text(listsplit.elementAt(2), style: TextStyle(fontSize: 18.0))],//Text(listsplit.elementAt(2)),
//             //                          ),  ),]
//             //                         )
//             //                         ),
//             //                         //
//             //             //   child: new CircleAvatar(
//             //             //     backgroundColor: Colors.white,
//             //             //     child: new Text('$index'),
//             //             //   ),
//             //             // )),
//             //                             staggeredTileBuilder: (int index) =>
//             //                             new StaggeredTile.count(2, index.isEven ? 2 : 1),
//             //                             mainAxisSpacing: 4.0,
//             //                             crossAxisSpacing: 4.0,
//             //       ))
//
//                   // //crossAxisCount: 2,
//                   // crossAxisSpacing: 4,
//                   // //mainAxisSpacing: 12,
//                   // padding: const EdgeInsets.all(2.0),
//                   // children:snap
//                   // //itemCount: .length,
//                   // itemBuilder: (context, index) {
//                   //   return Container(
//                   //     decoration: BoxDecoration(
//                   //         color: Colors.transparent,
//                   //         borderRadius: BorderRadius.all(
//                   //             Radius.circular(15))
//                   //     ),);
//                       //children:<Widget>[_listofstream.map((value) => _getCellDataWidget(value))
//                         //           .toList()]
//                       // child: ClipRRect(
//                       //   borderRadius: BorderRadius.all(
//                       //       Radius.circular(15)),
//                       //   child: FadeInImage.memoryNetwork(
//                       //     placeholder: kTransparentImage,
//                       //     image: _listofstream[index],fit: BoxFit.cover,),
//                       // ),
//                     //);
//
//                   // staggeredTileBuilder: (index) {
//                   //   return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
//                   // }),
//              // body: Container(
//              //   child: StaggeredGridView.extent(maxCrossAxisExtent: 4,
//              //       staggeredTiles:_listofstream,
//              //   children: [],
//              //   mainAxisSpacing: 4.0,
//              //   crossAxisSpacing: 4.0),
//              // ),
//           body: StaggeredGridView.count(
//               crossAxisCount: 4,
//               crossAxisSpacing: 12.0,
//               mainAxisSpacing: 12.0,
//               padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
//               children:  _listofstream.map((value) => _getCellDataWidget(value))
//                       .toList(),
//                staggeredTileBuilder: (int index) =>
//                     new StaggeredTile.fit(index),
//                     mainAxisSpacing: 4.0,
//                     crossAxisSpacing: 4.0,
//                   ),
//
//
//
//               //itemBuilder: (BuildContext context, int index) =>
//                           //_getCellDataWidget(value),
//                       // Card(
//                       //       elevation: 10,
//                       //       child: Column(
//                       //           children:<Widget>[
//                       //             ListTile(
//                       //               onTap: (){},
//                       //               isThreeLine: true,
//                       //               title: Text(_listofstream.elementAt(0),
//                       //                   style: TextStyle(fontSize: 30.0)  ),
//                       //               //subtitle: Column(children:<Widget>[Text(listsplit.elementAt(1), style: TextStyle(fontSize: 18.0)),Text(listsplit.elementAt(2), style: TextStyle(fontSize: 18.0))],//Text(listsplit.elementAt(2)),
//                       //
//                       //               ),],)  ),
//                       //                 staggeredTileBuilder: (int index) =>
//                       //                 new StaggeredTile.fit(index),
//                       //                 mainAxisSpacing: 4.0,
//                       //                 crossAxisSpacing: 4.0,
//                       //               ),
//
//
//
//
//
//               // Card(
//               //               child: Column(
//               //               children: <Widget>[
//               //               Image.network(images[index]),
//               //               Text("Some text"),
//               //               ],
//               //               ),
//               //               ),
//
//         ));
//                           }
//                    // ),
//                      //     );
//     // ));
//   }
//
//   //           )));
//   // }}
//
// //child:Column(
// //      mainAxisAlignment: MainAxisAlignment.start,
// // ignore: missing_return
//
// //
// //                           children: <Widget>[
// //                                   Container(
// //                                     child: Column(
// //                                       children: <Widget>[
// //                                         ElevatedButton(
// //                                           onPressed: () => _openFileExplorer(),
// //                                           child: const Text("Open file picker"),
// //                                         ),],),),
// //                                   Container(                                       //yeh chaiye list from stream ke liye
// //                                     height: 650,
// //                                     width: 1600,
// //                                     color: Colors.grey,
// //                                     child: ListView.builder(
// //                                         itemCount: _listofstream.length,
// //                                         itemBuilder: (BuildContext context, int index) {//return new Text(_listofstream[index]);
// //                                           // ListView.builder(
// //                                           //     itemCount: 3, // the length
// //                                           //     itemBuilder: (context, index) {
// //                                                 return Container(
// //                                                   padding: const EdgeInsets.only(bottom: 8),
// //                                                   child: Card(
// //                                                      child: SizedBox(
// //                                                      width: 50,
// //                                                      height: 50,
// //                                                          child: Column(
// //                                                               mainAxisSize: MainAxisSize.min,
// //                                                               children: <Widget>[
// //                                                                 Text(_listofstream[index]),],  ),
// //     )),);}))
// //     ],),  ),});});
// //
// //
// //
// //
// //
// //
// //   //<------------------------------------------>
// //
// // //<------------Useful code is above ------------->
// //
// //
// //
// //
// //
// //
// // //
// // // body:Container(
// // // //padding: ,
// // // child:OrientationBuilder(
// // // builder: (BuildContext context, Orientation orientation) {
// // // switch (orientation) {
// // // case Orientation.portrait:
// // // return Container();
// // // case Orientation.landscape:
// // // return Container();
// // // }
// // // return null;
// // // }),
// // // )