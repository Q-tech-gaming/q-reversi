import '../../domain/entities/position.dart';

/// 同じ行・列ボタンの再クリックを、解除にするか適用にするか。
enum RepeatAxisTapDecision {
  /// 別ボタンなら選び直し、同じボタンなら範囲を外す
  toggle,

  /// 同じボタンの再クリックで、範囲を残したままゲートを適用する
  apply,
}

/// 設定がオンで、いま選んでいる行・列と同じボタンを押し直したときだけ適用する。
///
/// 時間制限はない。行・列は2回目のクリック自体が解除だったため、そのクリックを適用に置き換える。
RepeatAxisTapDecision decideRepeatAxisTap({
  required bool armed,
  required bool sameSelection,
  required bool canApply,
}) {
  if (armed && sameSelection && canApply) {
    return RepeatAxisTapDecision.apply;
  }
  return RepeatAxisTapDecision.toggle;
}

/// 盤面マスのダブルタップを、ゲート即適用にするかどうか。
enum CellDoubleTapDecision {
  /// 通常の1タップとして選択処理を続ける
  normalTap,

  /// いまの選択にゲートを適用し、このタップでは選択を変えない
  apply,

  /// 選択も適用もせず、このタップを捨てる
  ignore,
}

/// 同じマスへの連続タップを検知する。
///
/// GestureDetector の onDoubleTap は単タップを待たせるため使わない。
/// 1回目はすぐ選択し、設定がオンのときだけ2回目で適用する。
class CellDoubleTapApplyController {
  /// Flutter のダブルタップ判定と同じ待ち時間。
  static const Duration window = Duration(milliseconds: 300);

  Position? _position;
  DateTime? _at;
  bool _accepted = false;

  void reset() {
    _position = null;
    _at = null;
    _accepted = false;
  }

  /// 通常の選択処理の前に呼ぶ。
  ///
  /// [armed] は次をすべて満たすときだけ true にする。
  /// - 設定がオン
  /// - ゲート選択済み
  /// - ガイド／チュートリアル／処理中ではない
  ///
  /// [canApply] と [selectionContainsCell] は、このタップで選択を変える前の状態。
  /// [twoBitSingleCell] は、2ビットゲートでその1マスだけが選ばれているとき。
  CellDoubleTapDecision onTap({
    required Position position,
    required bool armed,
    required bool canApply,
    required bool selectionContainsCell,
    required bool twoBitSingleCell,
    DateTime? now,
  }) {
    if (!armed) {
      reset();
      return CellDoubleTapDecision.normalTap;
    }

    final time = now ?? DateTime.now();
    if (!_matches(position, time)) {
      return CellDoubleTapDecision.normalTap;
    }

    reset();
    if (canApply && selectionContainsCell) {
      return CellDoubleTapDecision.apply;
    }
    // 2ビットの1マス目を連打しても、隣接エラーで選択を壊さない
    if (twoBitSingleCell) {
      return CellDoubleTapDecision.ignore;
    }
    return CellDoubleTapDecision.normalTap;
  }

  /// 通常タップの結果を記録する。受付されなかったタップは次の連打を即適用にしない。
  void record(
    Position position, {
    required bool accepted,
    DateTime? now,
  }) {
    _position = position;
    _at = now ?? DateTime.now();
    _accepted = accepted;
  }

  bool _matches(Position position, DateTime now) {
    if (!_accepted || _position != position || _at == null) return false;
    final elapsed = now.difference(_at!);
    return !elapsed.isNegative && elapsed <= window;
  }
}
