import 'package:flutter/material.dart';

class MonthAmount {
  final String label;
  final double value;
  MonthAmount({required this.label, required this.value});
}

enum GridOrientation { horizontal, vertical }

class LineGraph extends StatelessWidget {
  final List<MonthAmount> data;

  final Color lineColor;

  final double pointRadius;

  final int horizontalGridLines;

  final EdgeInsets margins;

  const LineGraph({
    Key? key,
    required this.data,
    this.lineColor = Colors.blue,
    this.pointRadius = 4.0,
    this.horizontalGridLines = 5,
    this.margins = const EdgeInsets.fromLTRB(40, 20, 20, 40),
  }) : assert(data.length >= 2, 'Need at least 2 points'),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('No data'));
    }
    // Wrap in LayoutBuilder to get the available size
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: _LineGraphPainter(
            data: data,
            lineColor: lineColor,
            pointRadius: pointRadius,
            horizontalGridLines: horizontalGridLines,
            margins: margins,
          ),
        );
      },
    );
  }
}

class _LineGraphPainter extends CustomPainter {
  final List<MonthAmount> data;
  final Color lineColor;
  final double pointRadius;
  final int horizontalGridLines;
  final EdgeInsets margins;

  _LineGraphPainter({
    required this.data,
    required this.lineColor,
    required this.pointRadius,
    required this.horizontalGridLines,
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
    final maxValue = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final segmentX = chartWidth / (data.length - 1);

    final axisPaint =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 2;
    final gridPaint =
        Paint()
          ..color = Colors.grey.shade300
          ..strokeWidth = 1;
    final linePaint =
        Paint()
          ..color = lineColor
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;
    final pointPaint = Paint()..color = lineColor;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (int i = 0; i <= horizontalGridLines; i++) {
      final dy = top + (chartHeight / horizontalGridLines) * i;
      canvas.drawLine(
        Offset(left, dy),
        Offset(size.width - right, dy),
        gridPaint,
      );

      final valueLabel =
          ((horizontalGridLines - i) * maxValue / horizontalGridLines)
              .round()
              .toString();
      textPainter.text = TextSpan(
        text: valueLabel,
        style: const TextStyle(fontSize: 10),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(left - textPainter.width - 4, dy - textPainter.height / 2),
      );
    }

    canvas.drawLine(
      Offset(left, top),
      Offset(left, size.height - bottom),
      axisPaint,
    );

    canvas.drawLine(
      Offset(left, size.height - bottom),
      Offset(size.width - right, size.height - bottom),
      axisPaint,
    );

    final points = <Offset>[];
    for (var i = 0; i < data.length; i++) {
      final dx = left + segmentX * i;
      final dy = top + chartHeight * (1 - data[i].value / maxValue);
      points.add(Offset(dx, dy));
    }

    final path = Path()..moveTo(points[0].dx, points[0].dy);
    for (var pt in points.skip(1)) path.lineTo(pt.dx, pt.dy);
    canvas.drawPath(path, linePaint);

    for (var i = 0; i < data.length; i++) {
      canvas.drawCircle(points[i], pointRadius, pointPaint);

      textPainter.text = TextSpan(
        text: data[i].label,
        style: const TextStyle(fontSize: 12),
      );
      textPainter.layout();
      final tx = points[i].dx - textPainter.width / 2;
      final ty = size.height - bottom + 4;
      textPainter.paint(canvas, Offset(tx, ty));
    }
  }

  @override
  bool shouldRepaint(covariant _LineGraphPainter old) =>
      old.data != data ||
      old.lineColor != lineColor ||
      old.pointRadius != pointRadius ||
      old.horizontalGridLines != horizontalGridLines ||
      old.margins != margins;
}
