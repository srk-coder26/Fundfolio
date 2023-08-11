// import 'dart:math';
// import 'package:flutter/material.dart';
// import '../models/pie_chart_model.dart';

// final linePaint = Paint()
//   ..color = Colors.white
//   ..strokeWidth = 2.0
//   ..style = PaintingStyle.stroke;

// final midPaint = Paint()
//   ..color = Colors.white
//   ..style = PaintingStyle.fill;

// const textStyle = TextStyle(
//   fontWeight: FontWeight.bold,
//   color: Colors.black38,
//   fontSize: 30.0,
// );

// const labelStyle = TextStyle(color: Colors.black, fontSize: 12.0);

// class DonutChartPainter extends CustomPainter {
//   final List<BreakdownData> dataSet;
//   DonutChartPainter(this.dataSet);
//   @override
//   void paint(Canvas canvas, Size size) {
//     final c = Offset(size.width / 2.0, size.height / 2.0);
//     final radius = size.width * 0.9;
//     final rect = Rect.fromCenter(center: c, width: radius, height: radius);
//     var startAngle = 0.0;

//     // drawing the circle with data set values
//     for (var di in dataSet) {
//       final sweepAngle = di.value * 360.0 * pi / 180.0;
//       drawSectors(di, canvas, rect, startAngle, sweepAngle);
//       startAngle += sweepAngle;
//     }

//     // drawing the border lines
//     startAngle = 0.0;
//     for (var di in dataSet) {
//       final sweepAngle = di.value * 360.0 * pi / 180.0;
//       drawLines(radius, startAngle, c, canvas);
//       startAngle += sweepAngle;
//     }

//     startAngle = 0.0;
//     for (var di in dataSet) {
//       final sweepAngle = di.value * 360.0 * pi / 180.0;
//       drawLabels(canvas, c, radius, startAngle, sweepAngle, di.label);
//       startAngle += sweepAngle;
//     }

//     // drawing the inner circle
//     canvas.drawCircle(c, radius * 0.3, midPaint);

//     // drawing the labels
//     drawTextCentered(
//       canvas,
//       c,
//       'Fuck You',
//       textStyle,
//       radius * 0.6,
//       (Size sz) {},
//     );
//   }

//   void drawLabels(
//     Canvas canvas,
//     Offset c,
//     double radius,
//     double startAngle,
//     double sweepAngle,
//     String label,
//   ) {
//     final r = radius * 0.4;
//     final dx = r * cos(startAngle + sweepAngle / 2.0);
//     final dy = r * sin(startAngle + sweepAngle / 2.0);

//     final position = c + Offset(dx, dy);
//     drawTextCentered(canvas, position, label, labelStyle, 100.0, (Size sz) {
//       final rect = Rect.fromCenter(
//         center: c + position,
//         width: sz.width + 5,
//         height: sz.height + 5,
//       );
//       final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(5));
//       canvas.drawRRect(rrect, midPaint);
//     });
//   }

//   TextPainter measureText(
//       String s, TextStyle style, double maxWidth, TextAlign align) {
//     final span = TextSpan(text: s, style: style);
//     final tp = TextPainter(
//       text: span,
//       textAlign: align,
//       textDirection: TextDirection.ltr,
//     );

//     tp.layout(minWidth: 0, maxWidth: maxWidth);
//     return tp;
//   }

//   Size drawTextCentered(Canvas canvas, Offset position, String text,
//       TextStyle style, double maxWidth, Function(Size sz) bgCb) {
//     final tp = measureText(text, style, maxWidth, TextAlign.center);
//     final pos = position + Offset(-tp.width / 2.0, -tp.height / 2.0);
//     bgCb(tp.size);

//     tp.paint(canvas, pos);
//     return tp.size;
//   }

//   void drawLines(double radius, double startAngle, Offset c, Canvas canvas) {
//     final dx = radius / 2.0 * cos(startAngle);
//     final dy = radius / 2.0 * sin(startAngle);
//     final p2 = c + Offset(dx, dy);
//     canvas.drawLine(c, p2, linePaint);
//   }

//   double drawSectors(BreakdownData di, Canvas canvas, Rect rect,
//       double startAngle, double sweepAngle) {
//     final paint = Paint()
//       ..style = PaintingStyle.fill
//       ..color = di.color;
//     canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
//     return sweepAngle;
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
