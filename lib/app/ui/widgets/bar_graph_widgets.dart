import 'package:flutter/material.dart';

class MonthAmount {
  final String month;
  final double amount;
  MonthAmount({required this.month, required this.amount});
}

enum BarGraphOrientation { horizontal, vertical }

class BarGraph extends StatelessWidget {
  final List<MonthAmount> data;

  final BarGraphOrientation orientation;

   final double barThickness;

  final Color barColor;

  final int gridLines;

  final EdgeInsets margins;

  BarGraph({
    Key? key,
    required this.data,
    this.orientation = BarGraphOrientation.horizontal,
    this.barThickness = 20.0,
    this.barColor = Colors.blue,
    this.gridLines = 5,
    this.margins = const EdgeInsets.fromLTRB(40, 20, 20, 40), required int barWidth,
  })  : assert(data.isNotEmpty, 'Data cannot be empty'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: _BarGraphPainter(
            data: data,
            orientation: orientation,
            barThickness: barThickness,
            barColor: barColor,
            gridLines: gridLines,
            margins: margins,
          ),
        );
      },
    );
  }
}

class _BarGraphPainter extends CustomPainter {
  final List<MonthAmount> data;
  final BarGraphOrientation orientation;
  final double barThickness;
  final Color barColor;
  final int gridLines;
  final EdgeInsets margins;

  _BarGraphPainter({
    required this.data,
    required this.orientation,
    required this.barThickness,
    required this.barColor,
    required this.gridLines,
    required this.margins,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final left = margins.left;
    final top = margins.top;
    final right = margins.right;
    final bottom = margins.bottom;
    final chartWidth = size.width - left - right;
    final chartHeight = size.height - top - bottom;
    final maxValue = data.map((e) => e.amount).reduce((a, b) => a > b ? a : b);

    final axisPaint = Paint()..color = Colors.black..strokeWidth = 2;
    final gridPaint = Paint()..color = Colors.grey.shade300..strokeWidth = 1;
    final barPaint = Paint()..color = barColor;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    if (orientation == BarGraphOrientation.horizontal) {
      final rowHeight = chartHeight / data.length;

      for (int i = 0; i <= gridLines; i++) {
        final x = left + (chartWidth / gridLines) * i;
        canvas.drawLine(Offset(x, top), Offset(x, size.height - bottom), gridPaint);
        textPainter.text = TextSpan(
          text: (maxValue / gridLines * i).round().toString(),
          style: const TextStyle(fontSize: 10),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(x - textPainter.width / 2, size.height - bottom + 4));
      }

      canvas.drawLine(Offset(left, top), Offset(left, size.height - bottom), axisPaint);
      canvas.drawLine(Offset(left, size.height - bottom), Offset(size.width - right, size.height - bottom), axisPaint);

    
      for (int i = 0; i < data.length; i++) {
        final d = data[i];
        final y = top + rowHeight * i + (rowHeight - barThickness) / 2;
        final width = (d.amount / maxValue) * chartWidth;

        // Bar
        canvas.drawRect(Rect.fromLTWH(left, y, width, barThickness), barPaint);

        textPainter.text = TextSpan(
          text: d.amount.round().toString(),
          style: const TextStyle(fontSize: 10),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(left + width + 4, y + (barThickness - textPainter.height) / 2));

        textPainter.text = TextSpan(
          text: d.month,
          style: const TextStyle(fontSize: 12),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(4, y + (barThickness - textPainter.height) / 2));
      }
    } else {
      final colWidth = chartWidth / data.length;

      for (int i = 0; i <= gridLines; i++) {
        final y = top + (chartHeight / gridLines) * (gridLines - i);
        canvas.drawLine(Offset(left, y), Offset(size.width - right, y), gridPaint);
        textPainter.text = TextSpan(
          text: (maxValue / gridLines * i).round().toString(),
          style: const TextStyle(fontSize: 10),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(left - textPainter.width - 4, y - textPainter.height / 2));
      }

      canvas.drawLine(Offset(left, top), Offset(left, size.height - bottom), axisPaint);
      canvas.drawLine(Offset(left, size.height - bottom), Offset(size.width - right, size.height - bottom), axisPaint);

      for (int i = 0; i < data.length; i++) {
        final d = data[i];
        final x = left + colWidth * i + (colWidth - barThickness) / 2;
        final height = (d.amount / maxValue) * chartHeight;
        final y = size.height - bottom - height;

        canvas.drawRect(Rect.fromLTWH(x, y, barThickness, height), barPaint);

        textPainter.text = TextSpan(
          text: d.amount.round().toString(),
          style: const TextStyle(fontSize: 10),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(x + (barThickness - textPainter.width) / 2, y - textPainter.height - 2));

        textPainter.text = TextSpan(
          text: d.month,
          style: const TextStyle(fontSize: 12),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(x + (barThickness - textPainter.width) / 2, size.height - bottom + 4));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}