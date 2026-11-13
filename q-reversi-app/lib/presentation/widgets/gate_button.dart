import 'package:flutter/material.dart';

import '../../domain/entities/game_mode.dart';
import '../../domain/entities/gate_type.dart';
import '../../domain/rules/cnot_control_color.dart';
import '../theme/app_theme.dart';
import 'gate_effect_icon.dart';

/// ゲートボタン
class GateButton extends StatelessWidget {
  final GateType gate;
  final bool isEnabled;
  final bool isSelected;
  final int? cooldown;
  final VoidCallback? onTap;
  final bool isReadOnly; // 読み取り専用（相手のゲート表示用）
  final bool centerTwoBitLabel; // 2ビットゲートの文字を中央寄せする（画面固有用）

  /// 効果の見取り図を文字の横に出す。設定がオフのときは呼び出し側が false にする。
  final bool showEffectIcon;

  /// 相手側。ゲート名とクールタイムだけを出す。
  final bool compact;

  /// CNOTの制御色に使う。未指定ならチュートリアルと同じく黒。
  final PlayerColor? playerColor;

  /// VSモードではCNOTの制御色が相手の色になる。
  final bool isVsMode;

  const GateButton({
    super.key,
    required this.gate,
    this.isEnabled = true,
    this.isSelected = false,
    this.cooldown,
    this.onTap,
    this.isReadOnly = false,
    this.centerTwoBitLabel = false,
    this.showEffectIcon = false,
    this.compact = false,
    this.playerColor,
    this.isVsMode = false,
  });

  /// 相手の表示。手番が移るときにクールタイムが1減るので、0と1は次の相手ターンで使える。
  bool get _readyOnOpponentsNextTurn {
    final showsOpponentGates = compact || (isReadOnly && isVsMode);
    return showsOpponentGates && (cooldown ?? 0) <= 1;
  }

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.getGateButtonStyle(
      gate,
      isEnabled || _readyOnOpponentsNextTurn,
      isSelected,
      isReadOnly,
    );
    final button = ElevatedButton(
      onPressed: (isEnabled && !isReadOnly) ? onTap : null,
      style: showEffectIcon || compact
          ? style.copyWith(
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(
                  horizontal: compact ? 4 : 8,
                  vertical: compact ? 4 : 6,
                ),
              ),
              minimumSize: WidgetStatePropertyAll(
                compact ? const Size(0, 28) : const Size(0, 36),
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            )
          : style,
      child: showEffectIcon ? _effectBody() : _textBody(),
    );

    // 読み取り専用の相手ボタンは、コンパクト表示ではクールタイムを読みやすく残す。
    // 次の相手ターンで使えるゲートは、薄い紫が分かるようにさらに薄くしない。
    if (isReadOnly && !compact && !_readyOnOpponentsNextTurn) {
      return Opacity(
        opacity: 0.6,
        child: button,
      );
    }

    return button;
  }

  Widget _textBody() {
    final hasCooldown = cooldown != null && cooldown! > 0;
    if (compact) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            gate.displayName,
            style: TextStyle(
              fontSize: gate.isTwoBitGate ? 11 : 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            overflow: TextOverflow.clip,
            softWrap: false,
          ),
          if (hasCooldown) ...[
            const SizedBox(width: 4),
            Text(
              '$cooldown',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        gate.isTwoBitGate && !centerTwoBitLabel
            ? Transform.translate(
                offset: const Offset(-10, 0),
                child: Text(
                  gate.displayName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.visible,
                  softWrap: false,
                  textAlign: TextAlign.center,
                ),
              )
            : Text(
                gate.displayName,
                style: TextStyle(
                  fontSize: gate.isTwoBitGate ? 12 : 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.visible,
                softWrap: false,
                textAlign: TextAlign.center,
              ),
        if (hasCooldown)
          Text(
            '$cooldown',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
      ],
    );
  }

  Widget _effectBody() {
    final hasCooldown = cooldown != null && cooldown! > 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              gate.displayName,
              style: TextStyle(
                fontSize: gate.isTwoBitGate ? 13 : 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1,
              ),
            ),
            if (hasCooldown) ...[
              const SizedBox(height: 2),
              Text(
                '$cooldown',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(width: 6),
        GateEffectIcon(
          gate: gate,
          cnotControlIsBlack: cnotControlIsBlack(
            playerColor: playerColor,
            isVsMode: isVsMode,
          ),
        ),
      ],
    );
  }
}
