import '../entities/game_mode.dart';

/// CNOTで、1駒目がこの色のときに2駒目へXがかかるか。
///
/// 通常モードは自分の色、VSモードは相手の色。
/// プレイヤー色が無い画面（チュートリアル、スタディ）は説明と同じく黒。
///
/// VSの黒プレイヤーは条件が反転し、1駒目が白のときだけ反転する。
bool cnotControlIsBlack({
  PlayerColor? playerColor,
  bool isVsMode = false,
}) {
  if (playerColor == null) return true;
  if (isVsMode) {
    return playerColor == PlayerColor.white;
  }
  return playerColor == PlayerColor.black;
}
