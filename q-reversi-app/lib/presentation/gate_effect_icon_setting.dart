import 'package:flutter/foundation.dart';

import '../domain/services/operation_order_preference_service.dart';

/// ゲートボタンに効果アイコンを出すか。初期値はオン。
class GateEffectIconSetting {
  GateEffectIconSetting._();

  static final GateEffectIconSetting instance = GateEffectIconSetting._();

  final ValueNotifier<bool> notifier = ValueNotifier<bool>(true);
  final OperationOrderPreferenceService _service =
      OperationOrderPreferenceService();

  Future<void> load() async {
    notifier.value = await _service.isGateEffectIconEnabled();
  }

  Future<void> setEnabled(bool value) async {
    notifier.value = value;
    await _service.setGateEffectIconEnabled(value);
  }
}
