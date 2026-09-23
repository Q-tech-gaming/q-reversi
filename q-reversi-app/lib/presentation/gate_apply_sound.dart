import '../core/sound_effects.dart';
import '../domain/entities/game_state.dart';
import '../domain/entities/gate_type.dart';
import '../domain/entities/position.dart';
import '../domain/services/game_service.dart';

/// エンタングル駒が新しくできる適用は entanglement、それ以外は apply。
void playGateApplySound(
  GameState state,
  GateType gate,
  List<Position> targets,
) {
  if (GameService().createsEntangledPiece(state, gate, targets)) {
    SoundEffects.instance.entanglement();
  } else {
    SoundEffects.instance.apply();
  }
}
