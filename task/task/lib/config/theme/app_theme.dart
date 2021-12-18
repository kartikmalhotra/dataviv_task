// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   static double _height = 100,
//       _offset = 10,
//       _one = -(_height - _offset),
//       _two = (_height - _offset);
//   final double _oneFixed = -(_height - _offset);
//   final double _twoFixed = (_height - _offset);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Testing")),
//       body: SizedBox(
//         height: _height,
//         child: Stack(
//           children: <Widget>[
//             Positioned(
//               left: 0,
//               right: 0,
//               height: _height,
//               child:
//                   _myContainer(color: Colors.grey[800]!, text: "Old Container"),
//             ),
//             Positioned(
//               left: 0,
//               right: 0,
//               top: _one,
//               height: _height,
//               child: GestureDetector(
//                 onPanUpdate: (details) {
//                   _one += details.delta.dy;
//                   if (_one >= 0) _one = 0;
//                   if (_one <= _oneFixed) _one = _oneFixed;
//                   setState(() {});
//                 },
//                 child: _myContainer(
//                     color: _one >= _oneFixed + 1
//                         ? Colors.red[800]!
//                         : Colors.transparent,
//                     text: "Upper Container"),
//               ),
//             ),
//             Positioned(
//               left: 0,
//               right: 0,
//               top: _two,
//               height: _height,
//               child: GestureDetector(
//                 onPanUpdate: (details) {
//                   _two += details.delta.dy;
//                   if (_two <= 0) _two = 0;
//                   if (_two >= _twoFixed) _two = _twoFixed;
//                   setState(() {});
//                 },
//                 child: _myContainer(
//                     color: _two <= _twoFixed - 1
//                         ? Colors.green[800]!
//                         : Colors.transparent,
//                     text: "Bottom Container"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _myContainer({Color? color, String? text}) {
//     return Container(
//       color: color,
//       alignment: Alignment.center,
//       child: Text(text!,
//           style: TextStyle(
//               fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
//     );
//   }
// }
