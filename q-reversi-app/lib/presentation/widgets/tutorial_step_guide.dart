import 'package:flutter/material.dart';

/// チャレンジ初回ガイドと同じ暗幕と吹き出し。
/// 「次へ」で解説を進め、操作はそのあと行う。
class TutorialStepGuide extends StatelessWidget {
  const TutorialStepGuide({
    super.key,
    this.targetRect,
    this.imageAsset,
    this.heading,
    required this.message,
    required this.nextLabel,
    required this.onNext,
  });

  /// 穴あきにする対象。無いときは画面中央の説明だけ出す。
  final Rect? targetRect;

  /// 中央表示のとき、文章の上に出す画像。
  final String? imageAsset;

  /// 画像の下に、中央ぞろえで出す見出し。
  final String? heading;
  final String message;
  final String nextLabel;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final area = Size(constraints.maxWidth, constraints.maxHeight);
        final hole = targetRect;
        if (hole == null) {
          return Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: onNext,
                  behavior: HitTestBehavior.opaque,
                  child: const ColoredBox(color: Colors.black54),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: _bubble(
                    width: (area.width - 32)
                        .clamp(220.0, imageAsset == null ? 320.0 : 480.0)
                        .toDouble(),
                    maxImageHeight: (area.height * 0.38).clamp(96.0, 220.0),
                  ),
                ),
              ),
            ],
          );
        }
        final highlight = hole.inflate(4);
        final bubbleWidth = (area.width - 24).clamp(200.0, 320.0).toDouble();
        final left = (highlight.center.dx - bubbleWidth / 2)
            .clamp(12.0, area.width - bubbleWidth - 12.0)
            .toDouble();
        const estimatedHeight = 132.0;
        final below = highlight.bottom + 8;
        final placeBelow = below + estimatedHeight < area.height - 8;
        final top = (placeBelow ? below : highlight.top - estimatedHeight - 8)
            .clamp(8.0, area.height - estimatedHeight - 8.0)
            .toDouble();
        final connectorX = (highlight.center.dx - left)
            .clamp(16.0, bubbleWidth - 16.0)
            .toDouble();

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: onNext,
                behavior: HitTestBehavior.opaque,
                child: const ColoredBox(color: Colors.transparent),
              ),
            ),
            IgnorePointer(
              child: Stack(
                children: [
                  _dim(0, 0, area.width, highlight.top),
                  _dim(
                    0,
                    highlight.bottom,
                    area.width,
                    area.height - highlight.bottom,
                  ),
                  _dim(0, highlight.top, highlight.left, highlight.height),
                  _dim(
                    highlight.right,
                    highlight.top,
                    area.width - highlight.right,
                    highlight.height,
                  ),
                  Positioned(
                    left: highlight.left,
                    top: highlight.top,
                    child: Container(
                      width: highlight.width,
                      height: highlight.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: left,
              top: top,
              child: _bubble(
                width: bubbleWidth,
                showArrowAbove: placeBelow,
                showArrowBelow: !placeBelow,
                arrowInset: connectorX - 8,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _bubble({
    double? width,
    bool showArrowAbove = false,
    bool showArrowBelow = false,
    double arrowInset = 24,
    double? maxImageHeight,
  }) {
    final card = DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0xFF2A3158),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageAsset != null) ...[
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: maxImageHeight ?? 220,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imageAsset!,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
            if (heading != null) ...[
              SizedBox(
                width: double.infinity,
                child: Text(
                  heading!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                ),
              ),
              if (message.isNotEmpty) const SizedBox(height: 8),
            ],
            if (message.isNotEmpty)
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              heightFactor: 1,
              child: InkWell(
                onTap: onNext,
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  child: Text(
                    nextLabel,
                    style: const TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return GestureDetector(
      onTap: onNext,
      child: SizedBox(
        width: width ?? 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showArrowAbove)
              Padding(
                padding: EdgeInsets.only(left: arrowInset),
                child: const Icon(
                  Icons.arrow_drop_up,
                  color: Color(0xFF2A3158),
                  size: 16,
                ),
              ),
            card,
            if (showArrowBelow)
              Padding(
                padding: EdgeInsets.only(left: arrowInset),
                child: const Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xFF2A3158),
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _dim(double left, double top, double width, double height) {
    if (width <= 0 || height <= 0) return const SizedBox.shrink();
    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque,
        child: const ColoredBox(color: Colors.black54),
      ),
    );
  }
}
