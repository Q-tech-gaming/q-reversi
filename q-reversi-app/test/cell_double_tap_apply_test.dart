import 'package:flutter_test/flutter_test.dart';
import 'package:q_reversi_app/domain/entities/position.dart';
import 'package:q_reversi_app/presentation/input/cell_double_tap_apply.dart';

void main() {
  const cell = Position(3, 4);
  const other = Position(3, 5);
  final t0 = DateTime(2026, 1, 1, 12);

  CellDoubleTapApplyController ready() {
    final controller = CellDoubleTapApplyController();
    expect(
      controller.onTap(
        position: cell,
        armed: true,
        canApply: false,
        selectionContainsCell: false,
        twoBitSingleCell: false,
        now: t0,
      ),
      CellDoubleTapDecision.normalTap,
    );
    controller.record(cell, accepted: true, now: t0);
    return controller;
  }

  CellDoubleTapDecision tap(
    CellDoubleTapApplyController controller, {
    Position position = cell,
    bool armed = true,
    bool canApply = false,
    bool selectionContainsCell = false,
    bool twoBitSingleCell = false,
    Duration after = const Duration(milliseconds: 200),
  }) {
    return controller.onTap(
      position: position,
      armed: armed,
      canApply: canApply,
      selectionContainsCell: selectionContainsCell,
      twoBitSingleCell: twoBitSingleCell,
      now: t0.add(after),
    );
  }

  test('設定オフや未準備のときは単タップのまま', () {
    final controller = CellDoubleTapApplyController();
    controller.record(cell, accepted: true, now: t0);

    expect(
      tap(controller,
          armed: false, canApply: true, selectionContainsCell: true),
      CellDoubleTapDecision.normalTap,
    );
    // オフのあいだに記録は捨てる。直後にオンにしても即適用しない
    expect(
      tap(
        controller,
        canApply: true,
        selectionContainsCell: true,
        after: const Duration(milliseconds: 250),
      ),
      CellDoubleTapDecision.normalTap,
    );
  });

  test('1回目の選択が成立した同じマスだけ、2回目で適用する', () {
    final controller = ready();

    expect(
      tap(controller, canApply: true, selectionContainsCell: true),
      CellDoubleTapDecision.apply,
    );
    // 適用後は記録を捨てるので、続けてもう一度タップしても適用しない
    expect(
      tap(
        controller,
        canApply: true,
        selectionContainsCell: true,
        after: const Duration(milliseconds: 250),
      ),
      CellDoubleTapDecision.normalTap,
    );
  });

  test('選択に含まれないマスや、適用できない状態では適用しない', () {
    expect(
      tap(ready(), canApply: true, selectionContainsCell: false),
      CellDoubleTapDecision.normalTap,
    );
    expect(
      tap(ready(), canApply: false, selectionContainsCell: true),
      CellDoubleTapDecision.normalTap,
    );
  });

  test('別のマス、時間切れ、受付失敗、時刻の逆行では適用しない', () {
    expect(
      tap(ready(),
          position: other, canApply: true, selectionContainsCell: true),
      CellDoubleTapDecision.normalTap,
    );
    expect(
      tap(
        ready(),
        canApply: true,
        selectionContainsCell: true,
        after: const Duration(milliseconds: 301),
      ),
      CellDoubleTapDecision.normalTap,
    );
    expect(
      tap(
        ready(),
        canApply: true,
        selectionContainsCell: true,
        after: const Duration(milliseconds: 300),
      ),
      CellDoubleTapDecision.apply,
    );

    final rejected = CellDoubleTapApplyController();
    rejected.record(cell, accepted: false, now: t0);
    expect(
      tap(rejected, canApply: true, selectionContainsCell: true),
      CellDoubleTapDecision.normalTap,
    );

    final backwards = ready();
    expect(
      tap(
        backwards,
        canApply: true,
        selectionContainsCell: true,
        after: const Duration(milliseconds: -1),
      ),
      CellDoubleTapDecision.normalTap,
    );
  });

  test('2ビットで1マスだけの連打は選択を維持して無視する', () {
    final controller = ready();

    expect(
      tap(controller, twoBitSingleCell: true),
      CellDoubleTapDecision.ignore,
    );
    expect(
      tap(
        controller,
        canApply: true,
        selectionContainsCell: true,
        after: const Duration(milliseconds: 250),
      ),
      CellDoubleTapDecision.normalTap,
    );
  });

  test('同じ行・列の再クリックは、設定がオンで適用できるときだけ適用になる', () {
    expect(
      decideRepeatAxisTap(armed: false, sameSelection: true, canApply: true),
      RepeatAxisTapDecision.toggle,
    );
    expect(
      decideRepeatAxisTap(armed: true, sameSelection: false, canApply: true),
      RepeatAxisTapDecision.toggle,
    );
    expect(
      decideRepeatAxisTap(armed: true, sameSelection: true, canApply: false),
      RepeatAxisTapDecision.toggle,
    );
    expect(
      decideRepeatAxisTap(armed: true, sameSelection: true, canApply: true),
      RepeatAxisTapDecision.apply,
    );
  });

  test('行選択やゲート変更で reset すると連打は途切れる', () {
    final controller = ready();
    controller.reset();

    expect(
      tap(controller, canApply: true, selectionContainsCell: true),
      CellDoubleTapDecision.normalTap,
    );
  });
}
