// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     final List<Map<String, dynamic>> data = [
// //       {'month': 1, 'value': 1200000.0},
// //       {'month': 2, 'value': 850000.0},
// //       {'month': 3, 'value': 337813.0},
// //       {'month': 4, 'value': 100806.0},
// //       {'month': 5, 'value': 1540000.0},
// //       {'month': 6, 'value': 1980000.0},
// //       {'month': 7, 'value': 900000.0},
// //       {'month': 8, 'value': 2100000.0},
// //       {'month': 9, 'value': 1340000.0},
// //       {'month': 10, 'value': 1600000.0},
// //       {'month': 11, 'value': 750000.0},
// //       {'month': 12, 'value': 1800000.0},
// //     ];

// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: Scaffold(
// //         appBar: AppBar(title: const Text('Business Value Bar Graph')),
// //         body: Container(
// //           child: Padding(
// //             padding: const EdgeInsets.all(16),
// //             child: SizedBox(
// //               height: 400,
// //               child: Column(
// //                 children: [
// //                   const Text(
// //                     'Horizontal Bar Graph',
// //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                   ),
// //                   const SizedBox(height: 16),
// //                   Expanded(
// //                     child: BusinessValueBarGraph(
// //                       data: data,
// //                       baseColor: const Color.fromARGB(255, 109, 244, 56),
// //                       barWidth: 14,
// //                       gridLines: 7,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class BusinessValueBarGraph extends StatelessWidget {
// //   final List<Map<String, dynamic>> data;
// //   final double barWidth;
// //   final Color baseColor;
// //   final int gridLines;

// //   const BusinessValueBarGraph({
// //     Key? key,

// //     required this.data,
// //     this.barWidth = 20,
// //     this.baseColor = const Color.fromARGB(199, 120, 245, 70),
// //     this.gridLines = 7,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     if (data.isEmpty) return const Center(child: Text('No data'));

// //     return Container(
// //       padding: const EdgeInsets.all(8),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Column(
// //             mainAxisAlignment: MainAxisAlignment.start,
// //             children:
// //                 data.map((monthData) {
// //                   return Padding(
// //                     padding: const EdgeInsets.symmetric(vertical: 6.0),
// //                     child: SizedBox(
// //                       height: barWidth,
// //                       child: Text(
// //                         _getMonthName(monthData['month']),
// //                         style: const TextStyle(
// //                           fontSize: 11,
// //                           color: Colors.black,
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                 }).toList(),
// //           ),

// //           Container(width: 2, height: 320, color: Colors.black),

// //           Expanded(
// //             child: SingleChildScrollView(
// //               scrollDirection: Axis.horizontal,
// //               child: GestureDetector(
// //                 onTap: () {
// //                   showDialog(
// //                     context: context,
// //                     builder:
// //                         (ctx) => AlertDialog(
// //                           content: Text(
// //                             '${data[0]['value'].toStringAsFixed(2)}',
// //                             style: const TextStyle(fontSize: 14),
// //                           ),

// //                           contentPadding: const EdgeInsets.all(16),
// //                           insetPadding: const EdgeInsets.symmetric(
// //                             horizontal: 100,
// //                             vertical: 200,
// //                           ),
// //                         ),
// //                   );
// //                 },
// //                 child: CustomPaint(
// //                   size: Size(data.length * (barWidth + 15), 400),
// //                   painter: _BarGraphPainter(
// //                     data: data,
// //                     barWidth: barWidth,
// //                     baseColor: baseColor,
// //                     gridLines: gridLines,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   String _getMonthName(int month) {
// //     const months = [
// //       "Jan",
// //       "Feb",
// //       "Mar",
// //       "Apr",
// //       "May",
// //       "Jun",
// //       "Jul",
// //       "Aug",
// //       "Sep",
// //       "Oct",
// //       "Nov",
// //       "Dec",
// //     ];
// //     return months[month - 1];
// //   }
// // }

// // class _BarGraphPainter extends CustomPainter {
// //   final List<Map<String, dynamic>> data;
// //   final double barWidth;
// //   final Color baseColor;
// //   final int gridLines;

// //   _BarGraphPainter({
// //     required this.data,
// //     required this.barWidth,
// //     required this.baseColor,
// //     required this.gridLines,
// //   });

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     const leftMargin = 40.0;
// //     const bottomMargin = 30.0;
// //     const topMargin = 30.0;
// //     const rightMargin = 20.0;

// //     final axisPaint =
// //         Paint()
// //           ..color = Colors.black
// //           ..strokeWidth = 2;
// //     final gridPaint =
// //         Paint()
// //           ..color = Colors.grey.shade300
// //           ..strokeWidth = 1;
// //     final textPainter = TextPainter(textDirection: TextDirection.ltr);

// //     final maxValue = data
// //         .map((e) => e['value'] as double)
// //         .reduce((a, b) => a > b ? a : b);
// //     final chartWidth = size.width - leftMargin - rightMargin;
// //     // final chartHeight = size.height - topMargin - bottomMargin;

// //     for (int i = 0; i <= gridLines; i++) {
// //       final x = leftMargin + (chartWidth / gridLines) * i;
// //       canvas.drawLine(
// //         Offset(x, topMargin),
// //         Offset(x, size.height - bottomMargin),
// //         gridPaint,
// //       );

// //       final label = _formatAmount(maxValue / gridLines * i);
// //       textPainter.text = TextSpan(
// //         text: label,
// //         style: const TextStyle(fontSize: 10, color: Colors.black),
// //       );
// //       textPainter.layout();
// //       textPainter.paint(
// //         canvas,
// //         Offset(x - textPainter.width / 2, size.height - bottomMargin + 4),
// //       );
// //     }

// //     canvas.drawLine(
// //       Offset(leftMargin, size.height - bottomMargin),
// //       Offset(size.width - rightMargin, size.height - bottomMargin),
// //       axisPaint,
// //     );

// //     final segment = chartWidth / data.length;
// //     for (int i = 0; i < data.length; i++) {
// //       final value = data[i]['value'] as double;
// //       final width = (value / maxValue) * chartWidth;
// //       final y = topMargin + segment * i;

// //       final Paint barPaint = Paint()..color = _getBarColor(value, maxValue);
// //       canvas.drawRect(Rect.fromLTWH(leftMargin, y, width, barWidth), barPaint);

// //       textPainter.text = TextSpan(
// //         text: _formatAmount(value),
// //         style: const TextStyle(fontSize: 10, color: Colors.white),
// //       );
// //       textPainter.layout();
// //       final dx = leftMargin + width - textPainter.width - 4;
// //       final dy = y + (barWidth - textPainter.height) / 2;
// //       canvas.drawRect(
// //         Rect.fromLTWH(
// //           dx - 2,
// //           dy - 2,
// //           textPainter.width + 4,
// //           textPainter.height + 4,
// //         ),
// //         Paint()..color = Colors.black45,
// //       );
// //       textPainter.paint(canvas, Offset(dx, dy));
// //     }
// //   }

// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

// //   String _formatAmount(double value) {
// //     if (value >= 1e7) {
// //       return "${(value / 1e7).toStringAsFixed(1)}Cr";
// //     } else if (value >= 1e5) {
// //       return "${(value / 1e5).toStringAsFixed(1)}L";
// //     } else if (value >= 1e3) {
// //       return "${(value / 1e3).toStringAsFixed(1)}K";
// //     }
// //     return value.toStringAsFixed(0);
// //   }

// //   Color _getBarColor(double value, double maxValue) {
// //     double intensity = value / maxValue;
// //     return Color.lerp(baseColor.withOpacity(0.4), baseColor, intensity)!;
// //   }
// // }

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {'month': 1, 'value': 1200000.0},
      {'month': 2, 'value': 850000.0},
      {'month': 3, 'value': 337813.0},
      {'month': 4, 'value': 100806.0},
      {'month': 5, 'value': 1540000.0},
      {'month': 6, 'value': 1980000.0},
      {'month': 7, 'value': 900000.0},
      {'month': 8, 'value': 2100000.0},
      {'month': 9, 'value': 1340000.0},
      {'month': 10, 'value': 1600000.0},
      {'month': 11, 'value': 750000.0},
      {'month': 12, 'value': 1800000.0},
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Business Value Bar Graph')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 400,
            child: Column(
              children: [
                const Text(
                  'Horizontal Bar Graph',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: BusinessValueBarGraph(
                    data: data,
                    baseColor: const Color.fromARGB(255, 109, 244, 56),
                    barWidth: 14,
                    gridLines: 7,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BusinessValueBarGraph extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final double barWidth;
  final Color baseColor;
  final int gridLines;

  const BusinessValueBarGraph({
    Key? key,
    required this.data,
    this.barWidth = 20,
    this.baseColor = const Color.fromARGB(199, 120, 245, 70),
    this.gridLines = 7,
  }) : super(key: key);

  @override
  State<BusinessValueBarGraph> createState() => _BusinessValueBarGraphState();
}

class _BusinessValueBarGraphState extends State<BusinessValueBarGraph> {
  int? _selectedIndex;
  
  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) return const Center(child: Text('No data'));

    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Column(
            children: widget.data.map((monthData) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: SizedBox(
                  height: widget.barWidth,
                  child: Text(
                    _getMonthName(monthData['month']),
                    style: const TextStyle(fontSize: 11, color: Colors.black),
                  ),
                ),
              );
            }).toList(),
          ),
          Container(width: 2, height: 320, color: Colors.black),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              
              child: GestureDetector(
      onTapDown: (TapDownDetails details) {
        double tapY = details.localPosition.dy;
        double segmentHeight = 20 + 6; 
        int tappedIndex = (tapY / segmentHeight).floor();

        if (tappedIndex >= 0 && tappedIndex < widget.data.length) {
          setState(() {
            _selectedIndex = tappedIndex;
          });

          showDialog(
            context: context,
            builder: (ctx) => CustomValueDialog(
              month: _getMonthName(widget.data[tappedIndex]['month']),
              value: widget.data[tappedIndex]['value'],
            ),
          );
        }
                },
                child: CustomPaint(
                  size: Size(widget.data.length * (widget.barWidth + 15), 400),
                  painter: _BarGraphPainter(
                    data: widget.data,
                    barWidth: widget.barWidth,
                    baseColor: widget.baseColor,
                    gridLines: widget.gridLines,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }
}



class CustomValueDialog extends StatelessWidget {
  final double value;
  final String month;

  const CustomValueDialog({
    Key? key,
    required this.value,
    required this.month,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightGreen.shade200, Colors.lightGreen.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
           boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 10),
            )
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$month Monthly  value',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Value: ${_formatAmount(value)}',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  String _formatAmount(double value) {
    if (value >= 1e7) {
      return "${(value / 1e7).toStringAsFixed(1)}Cr";
    } else if (value >= 1e5) {
      return "${(value / 1e5).toStringAsFixed(1)}L";
    } else if (value >= 1e3) {
      return "${(value / 1e3).toStringAsFixed(1)}K";
    }
    return value.toStringAsFixed(0);
  }
}

class _BarGraphPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final double barWidth;
  final Color baseColor;
  final int gridLines;

  _BarGraphPainter({
    required this.data,
    required this.barWidth,
    required this.baseColor,
    required this.gridLines,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const leftMargin = 40.0;
    const bottomMargin = 30.0;
    const topMargin = 30.0;
    const rightMargin = 20.0;

    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;
    final gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final maxValue = data
        .map((e) => e['value'] as double)
        .reduce((a, b) => a > b ? a : b);
    final chartWidth = size.width - leftMargin - rightMargin;

    for (int i = 0; i <= gridLines; i++) {
      final x = leftMargin + (chartWidth / gridLines) * i;
      canvas.drawLine(
        Offset(x, topMargin),
        Offset(x, size.height - bottomMargin),
        gridPaint,
      );

      final label = _formatAmount(maxValue / gridLines * i);
      textPainter.text = TextSpan(
        text: label,
        style: const TextStyle(fontSize: 10, color: Colors.black),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, size.height - bottomMargin + 4),
      );
    }

    canvas.drawLine(
      Offset(leftMargin, size.height - bottomMargin),
      Offset(size.width - rightMargin, size.height - bottomMargin),
      axisPaint,
    );

    final segment = chartWidth / data.length;
    for (int i = 0; i < data.length; i++) {
      final value = data[i]['value'] as double;
      final width = (value / maxValue) * chartWidth;
      final y = topMargin + segment * i;

      final Paint barPaint = Paint()..color = _getBarColor(value, maxValue);
      canvas.drawRect(Rect.fromLTWH(leftMargin, y, width, barWidth), barPaint);

      textPainter.text = TextSpan(
        text: _formatAmount(value),
        style: const TextStyle(fontSize: 10, color: Colors.white),
      );
      textPainter.layout();
      final dx = leftMargin + width - textPainter.width - 4;
      final dy = y + (barWidth - textPainter.height) / 2;
      canvas.drawRect(
        Rect.fromLTWH(dx - 2, dy - 2, textPainter.width + 4, textPainter.height + 4),
        Paint()..color = Colors.black45,
      );
      textPainter.paint(canvas, Offset(dx, dy));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  String _formatAmount(double value) {
    if (value >= 1e7) {
      return "${(value / 1e7).toStringAsFixed(1)}Cr";
    } else if (value >= 1e5) {
      return "${(value / 1e5).toStringAsFixed(1)}L";
    } else if (value >= 1e3) {
      return "${(value / 1e3).toStringAsFixed(1)}K";
    }
    return value.toStringAsFixed(0);
  }

  Color _getBarColor(double value, double maxValue) {
    double intensity = value / maxValue;
    return Color.lerp(baseColor.withOpacity(0.4), baseColor, intensity)!;
  }
}





// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> data = [
//       {'month': 1, 'value': 1200000.0},
//       {'month': 2, 'value': 850000.0},
//       {'month': 3, 'value': 337813.0},
//       {'month': 4, 'value': 100806.0},
//       {'month': 5, 'value': 1540000.0},
//       {'month': 6, 'value': 1980000.0},
//       {'month': 7, 'value': 900000.0},
//       {'month': 8, 'value': 2100000.0},
//       {'month': 9, 'value': 1340000.0},
//       {'month': 10, 'value': 1600000.0},
//       {'month': 11, 'value': 750000.0},
//       {'month': 12, 'value': 1800000.0},
//     ];

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Business Value Bar Graph')),
//         body: Padding(
//           padding: const EdgeInsets.all(16),
//           child: SizedBox(
//             height: 400,
//             child: Column(
//               children: [
//                 const Text(
//                   'Horizontal Bar Graph',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 16),
//                 // Our interactive graph (stateful now)
//                 Expanded(
//                   child: BusinessValueBarGraph(
//                     data: data,
//                     baseColor: const Color.fromARGB(255, 109, 244, 56),
//                     barWidth: 14,
//                     gridLines: 7,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BusinessValueBarGraph extends StatefulWidget {
//   final List<Map<String, dynamic>> data;
//   final double barWidth;
//   final Color baseColor;
//   final int gridLines;

//   const BusinessValueBarGraph({
//     Key? key,
//     required this.data,
//     this.barWidth = 20,
//     this.baseColor = const Color.fromARGB(199, 120, 245, 70),
//     this.gridLines = 7,
//   }) : super(key: key);

//   @override
//   _BusinessValueBarGraphState createState() => _BusinessValueBarGraphState();
// }

// class _BusinessValueBarGraphState extends State<BusinessValueBarGraph> {
//   int? _selectedBarIndex;

//   @override
//   Widget build(BuildContext context) {
//     if (widget.data.isEmpty) return const Center(child: Text('No data'));

//     // These constants are used both by the painter and our tap calculation.
//     const double leftMargin = 40.0;
//     const double rightMargin = 20.0;
//     const double topMargin = 30.0;
//     // Note: barWidth is passed as widget.barWidth.
//     // Our CustomPaint width is computed the same as in your original code.
//     final double customPaintWidth = widget.data.length * (widget.barWidth + 15);
//     final double chartWidth = customPaintWidth - leftMargin - rightMargin;
//     // We use the horizontal grid width (from leftMargin to rightMargin)
//     // to determine the vertical spacing (segment) for each bar.
//     final double segment = chartWidth / widget.data.length;

//     return Container(
//       padding: const EdgeInsets.all(8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Month labels at left
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: widget.data.map((monthData) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 6.0),
//                 child: SizedBox(
//                   height: widget.barWidth,
//                   child: Text(
//                     _getMonthName(monthData['month']),
//                     style: const TextStyle(fontSize: 11, color: Colors.black),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//           Container(width: 2, height: 320, color: Colors.black),
//           // GestureDetector to catch taps and update _selectedBarIndex dynamically.
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: GestureDetector(
//                 onTapDown: (TapDownDetails details) {
//                   final localPosition = details.localPosition;
//                   // Loop through each bar using the same vertical layout logic.
//                   // Here, each bar starts at: y = topMargin + segment * i with a fixed height.
//                   for (int i = 0; i < widget.data.length; i++) {
//                     final double yStart = topMargin + segment * i;
//                     final double yEnd = yStart + widget.barWidth;
//                     // Use the tap's y-coordinate to determine which bar was tapped.
//                     if (localPosition.dy >= yStart && localPosition.dy <= yEnd) {
//                       setState(() {
//                         _selectedBarIndex = i;
//                       });
//                       break;
//                     }
//                   }
//                 },
//                 child: CustomPaint(
//                   size: Size(customPaintWidth, 400),
//                   painter: _BarGraphPainter(
//                     data: widget.data,
//                     barWidth: widget.barWidth,
//                     baseColor: widget.baseColor,
//                     gridLines: widget.gridLines,
//                     selectedIndex: _selectedBarIndex,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _getMonthName(int month) {
//     const months = [
//       "Jan", "Feb", "Mar", "Apr", "May", "Jun",
//       "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
//     ];
//     return months[month - 1];
//   }
// }

// class _BarGraphPainter extends CustomPainter {
//   final List<Map<String, dynamic>> data;
//   final double barWidth;
//   final Color baseColor;
//   final int gridLines;
//   final int? selectedIndex;

//   _BarGraphPainter({
//     required this.data,
//     required this.barWidth,
//     required this.baseColor,
//     required this.gridLines,
//     this.selectedIndex,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     const double leftMargin = 40.0;
//     const double rightMargin = 20.0;
//     const double topMargin = 30.0;
//     const double bottomMargin = 30.0;

//     final axisPaint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 2;

//     final gridPaint = Paint()
//       ..color = Colors.grey.shade300
//       ..strokeWidth = 1;

//     final textPainter = TextPainter(
//       textDirection: TextDirection.ltr,
//     );

//     final maxValue = data
//         .map((e) => e['value'] as double)
//         .reduce((a, b) => a > b ? a : b);

//     final chartWidth = size.width - leftMargin - rightMargin;

//     // Draw grid lines and labels along the X-axis (bottom).
//     for (int i = 0; i <= gridLines; i++) {
//       final double x = leftMargin + (chartWidth / gridLines) * i;
//       canvas.drawLine(
//         Offset(x, topMargin),
//         Offset(x, size.height - bottomMargin),
//         gridPaint,
//       );

//       final String label = _formatAmount(maxValue / gridLines * i);
//       textPainter.text = TextSpan(
//         text: label,
//         style: const TextStyle(fontSize: 10, color: Colors.black),
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(x - textPainter.width / 2, size.height - bottomMargin + 4),
//       );
//     }

//     // Draw the X-axis line.
//     canvas.drawLine(
//       Offset(leftMargin, size.height - bottomMargin),
//       Offset(size.width - rightMargin, size.height - bottomMargin),
//       axisPaint,
//     );

//     // Use the calculated horizontal space (chartWidth) for vertical spacing.
//     final double segment = chartWidth / data.length;

//     for (int i = 0; i < data.length; i++) {
//       final double value = data[i]['value'] as double;
//       final double width = (value / maxValue) * chartWidth;
//       final double y = topMargin + segment * i;

//       // Draw the bar rectangle.
//       final Paint barPaint = Paint()..color = _getBarColor(value, maxValue);
//       canvas.drawRect(Rect.fromLTWH(leftMargin, y, width, barWidth), barPaint);

//       // If this bar is the one selected (tapped), draw the formatted value above it.
//       if (selectedIndex != null && selectedIndex == i) {
//         final String formattedValue = _formatAmount(value);
//         final TextPainter overlayTextPainter = TextPainter(
//           text: TextSpan(
//             text: formattedValue,
//             style: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           textDirection: TextDirection.ltr,
//         );
//         overlayTextPainter.layout();
//         // Center horizontally over the bar:
//         final double textX = leftMargin + width / 2 - overlayTextPainter.width / 2;
//         // Place above the bar with some spacing.
//         final double textY = y - overlayTextPainter.height - 8;
//         final Rect bgRect = Rect.fromLTWH(
//             textX - 4, textY - 2, overlayTextPainter.width + 8, overlayTextPainter.height + 4);
//         final RRect bgRRect = RRect.fromRectAndRadius(bgRect, const Radius.circular(4));
//         canvas.drawRRect(bgRRect, Paint()..color = Colors.white.withOpacity(0.8));

//         overlayTextPainter.paint(canvas, Offset(textX, textY));
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

//   String _formatAmount(double value) {
//     if (value >= 1e7) {
//       double cr = value / 1e7;
//       return cr == cr.floorToDouble() ? "${cr.toInt()}Cr" : "${cr.toStringAsFixed(1)}Cr";
//     } else if (value >= 1e5) {
//       double l = value / 1e5;
//       return l == l.floorToDouble() ? "${l.toInt()}L" : "${l.toStringAsFixed(1)}L";
//     } else if (value >= 1e3) {
//       double k = value / 1e3;
//       return k == k.floorToDouble() ? "${k.toInt()}K" : "${k.toStringAsFixed(1)}K";
//     }
//     return value.toStringAsFixed(0);
//   }

//   Color _getBarColor(double value, double maxValue) {
//     double intensity = value / maxValue;
//     return Color.lerp(baseColor.withOpacity(0.4), baseColor, intensity)!;
//   }
// }
