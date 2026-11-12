import 'package:flutter/material.dart';

import '../../domain/entities/gate_type.dart';

/// ゲートボタンの中に描く、効果の見取り図。
class GateEffectIcon extends StatelessWidget {
  final GateType gate;

  /// CNOTの1駒目。true なら黒、false なら白のとき2駒目が反転する。
  final bool cnotControlIsBlack;

  const GateEffectIcon({
    super.key,
    required this.gate,
    this.cnotControlIsBlack = true,
  });

  static const double _dot = 16;

  @override
  Widget build(BuildContext context) {
    switch (gate) {
      case GateType.x:
        return const _ExchangeRow(
          left: _PieceMark.white,
          right: _PieceMark.black,
        );
      case GateType.z:
        return const _ExchangeRow(
          left: _PieceMark.plus,
          right: _PieceMark.minus,
        );
      case GateType.h:
        return const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ExchangeRow(left: _PieceMark.white, right: _PieceMark.plus),
            SizedBox(height: 3),
            _ExchangeRow(left: _PieceMark.black, right: _PieceMark.minus),
          ],
        );
      case GateType.y:
        return const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ExchangeRow(left: _PieceMark.white, right: _PieceMark.black),
            SizedBox(height: 3),
            _ExchangeRow(left: _PieceMark.plus, right: _PieceMark.minus),
          ],
        );
      case GateType.cnot:
        return _CnotIcon(controlIsBlack: cnotControlIsBlack);
      case GateType.swap:
        return const _SwapIcon();
    }
  }
}

enum _PieceMark { white, black, plus, minus, gray }

class _PieceDot extends StatelessWidget {
  final _PieceMark mark;
  final double size;

  /// 駒の中に描く文字。指定すると＋/−よりこちらを出す。
  final String? label;

  const _PieceDot(this.mark, {this.size = GateEffectIcon._dot, this.label});

  @override
  Widget build(BuildContext context) {
    final Color fill;
    Color? symbolColor;
    String? symbol;
    switch (mark) {
      case _PieceMark.white:
        fill = Colors.white;
        symbolColor = null;
        symbol = null;
      case _PieceMark.black:
        fill = Colors.black;
        symbolColor = null;
        symbol = null;
      case _PieceMark.plus:
        fill = Colors.grey.shade600;
        symbolColor = Colors.white;
        symbol = '+';
      case _PieceMark.minus:
        fill = Colors.grey.shade600;
        symbolColor = Colors.black;
        symbol = '−';
      case _PieceMark.gray:
        fill = Colors.grey.shade600;
        symbolColor = Colors.white;
        symbol = null;
    }

    if (label != null) {
      symbol = label;
      symbolColor = mark == _PieceMark.white
          ? const Color(0xFF1A1A1A)
          : Colors.white;
    }

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: fill,
        border: Border.all(color: Colors.grey.shade700, width: 1),
      ),
      child: symbol == null
          ? null
          : Text(
              symbol,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: symbolColor,
                fontSize: label != null ? size * 0.72 : size * 0.62,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
    );
  }
}

class _DoubleArrow extends StatelessWidget {
  const _DoubleArrow();

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(
      size: Size(18, 12),
      painter: _DoubleArrowPainter(),
    );
  }
}

class _DoubleArrowPainter extends CustomPainter {
  const _DoubleArrowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final y = size.height / 2;
    final left = Offset(2.2, y);
    final right = Offset(size.width - 2.2, y);
    canvas.drawLine(left, right, paint);
    canvas.drawLine(left, left + const Offset(4.2, -3.2), paint);
    canvas.drawLine(left, left + const Offset(4.2, 3.2), paint);
    canvas.drawLine(right, right + const Offset(-4.2, -3.2), paint);
    canvas.drawLine(right, right + const Offset(-4.2, 3.2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ExchangeRow extends StatelessWidget {
  final _PieceMark left;
  final _PieceMark right;

  const _ExchangeRow({required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _PieceDot(left),
        const SizedBox(width: 2),
        const _DoubleArrow(),
        const SizedBox(width: 2),
        _PieceDot(right),
      ],
    );
  }
}

class _IndexBadge extends StatelessWidget {
  final String label;

  const _IndexBadge(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 13,
      height: 13,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8,
          fontWeight: FontWeight.w800,
          height: 1,
        ),
      ),
    );
  }
}

class _CnotIcon extends StatelessWidget {
  final bool controlIsBlack;

  const _CnotIcon({required this.controlIsBlack});

  @override
  Widget build(BuildContext context) {
    const dot = GateEffectIcon._dot;
    const arrowWidth = 18.0;
    // 2駒目の「白 ↔ 黒」の矢印の中央に、1駒目を乗せる。
    const controlLeft = dot + 2 + (arrowWidth - dot) / 2;
    const stemLeft = 13 + 3 + controlLeft + dot / 2 - 0.75;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _IndexBadge('1'),
            const SizedBox(width: 3),
            SizedBox(width: controlLeft),
            _PieceDot(controlIsBlack ? _PieceMark.black : _PieceMark.white),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: stemLeft),
          child: SizedBox(
            width: 1.5,
            height: 5,
            child: ColoredBox(color: Colors.white),
          ),
        ),
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _IndexBadge('2'),
            SizedBox(width: 3),
            _ExchangeRow(left: _PieceMark.white, right: _PieceMark.black),
          ],
        ),
      ],
    );
  }
}

class _SwapIcon extends StatelessWidget {
  const _SwapIcon();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 74,
      height: 40,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _SwapCyclePainter()),
          ),
          Positioned(
            left: 4,
            top: 11,
            child: _PieceDot(_PieceMark.gray, size: 18, label: '1'),
          ),
          Positioned(
            right: 4,
            top: 11,
            child: _PieceDot(_PieceMark.gray, size: 18, label: '2'),
          ),
        ],
      ),
    );
  }
}

class _SwapCyclePainter extends CustomPainter {
  const _SwapCyclePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final left = Offset(12, size.height / 2);
    final right = Offset(size.width - 12, size.height / 2);
    final topStart = Offset(left.dx + 10, left.dy - 7);
    final topEnd = Offset(right.dx - 8, right.dy - 7);
    final top = Path()
      ..moveTo(topStart.dx, topStart.dy)
      ..quadraticBezierTo(size.width / 2, 1.5, topEnd.dx, topEnd.dy);
    canvas.drawPath(top, paint);
    _head(canvas, topEnd, const Offset(1, 0.15), paint);

    final bottomStart = Offset(right.dx - 10, right.dy + 7);
    final bottomEnd = Offset(left.dx + 8, left.dy + 7);
    final bottom = Path()
      ..moveTo(bottomStart.dx, bottomStart.dy)
      ..quadraticBezierTo(
        size.width / 2,
        size.height - 1.5,
        bottomEnd.dx,
        bottomEnd.dy,
      );
    canvas.drawPath(bottom, paint);
    _head(canvas, bottomEnd, const Offset(-1, 0.15), paint);
  }

  void _head(Canvas canvas, Offset tip, Offset direction, Paint paint) {
    final dir = direction / direction.distance;
    final normal = Offset(-dir.dy, dir.dx);
    final base = tip - dir * 5;
    canvas.drawLine(tip, base + normal * 3.1, paint);
    canvas.drawLine(tip, base - normal * 3.1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
