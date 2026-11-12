import 'package:flutter/material.dart';
import '../../core/background_music.dart';
import '../../core/sound_effects.dart';
import '../../domain/services/audio_volume_preference_service.dart';
import '../../domain/services/operation_order_preference_service.dart';
import '../../l10n/app_localizations.dart';
import '../gate_effect_icon_setting.dart';

/// 設定ダイアログを表示し、閉じた時点の操作設定を返す。
Future<OperationOrderSettings?> showOperationOrderSettingsDialog(
  BuildContext context,
) async {
  final service = OperationOrderPreferenceService();
  final volumeService = AudioVolumePreferenceService();
  var allowFree = await service.isFreeSelectionOrderEnabled();
  var doubleTapApply = await service.isDoubleTapApplyEnabled();
  var showGateIcons = await service.isGateEffectIconEnabled();
  var bgmVolume = await volumeService.bgmVolume();
  var sfxVolume = await volumeService.sfxVolume();
  if (!context.mounted) return null;

  return showDialog<OperationOrderSettings>(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          final l10n = AppLocalizations.of(context);
          return AlertDialog(
            backgroundColor: const Color(0xFF1A1F3A),
            title: Text(
              l10n.settings,
              style: const TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        l10n.settingsFreeOrderTitle,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14),
                      ),
                      subtitle: Text(
                        l10n.settingsFreeOrderDescription,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12),
                      ),
                      value: allowFree,
                      activeColor: const Color(0xFF4CAF50),
                      onChanged: (value) async {
                        SoundEffects.instance.click();
                        await service.setFreeSelectionOrderEnabled(value);
                        setDialogState(() {
                          allowFree = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        l10n.settingsGateEffectIconTitle,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14),
                      ),
                      subtitle: Text(
                        l10n.settingsGateEffectIconDescription,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12),
                      ),
                      value: showGateIcons,
                      activeColor: const Color(0xFF4CAF50),
                      onChanged: (value) async {
                        SoundEffects.instance.click();
                        await GateEffectIconSetting.instance.setEnabled(value);
                        setDialogState(() {
                          showGateIcons = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        l10n.settingsDoubleTapTitle,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14),
                      ),
                      subtitle: Text(
                        l10n.settingsDoubleTapDescription,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12),
                      ),
                      value: doubleTapApply,
                      activeColor: const Color(0xFF4CAF50),
                      onChanged: (value) async {
                        SoundEffects.instance.click();
                        await service.setDoubleTapApplyEnabled(value);
                        setDialogState(() {
                          doubleTapApply = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        l10n.settingsVolumeHeading,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _VolumeSlider(
                      label: l10n.settingsVolumeBgm,
                      value: bgmVolume,
                      onChanged: (value) {
                        setDialogState(() => bgmVolume = value);
                        BackgroundMusic.instance.setVolume(value);
                      },
                      onChangeEnd: (value) {
                        volumeService.setBgmVolume(value);
                      },
                    ),
                    _VolumeSlider(
                      label: l10n.settingsVolumeSfx,
                      value: sfxVolume,
                      onChanged: (value) {
                        setDialogState(() => sfxVolume = value);
                        SoundEffects.instance.setVolume(value);
                      },
                      onChangeEnd: (value) {
                        volumeService.setSfxVolume(value);
                        SoundEffects.instance.click();
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  SoundEffects.instance.click();
                  Navigator.of(dialogContext).pop(
                    OperationOrderSettings(
                      allowFreeSelectionOrder: allowFree,
                      doubleTapApplyEnabled: doubleTapApply,
                    ),
                  );
                },
                child: Text(l10n.close),
              ),
            ],
          );
        },
      );
    },
  );
}

class _VolumeSlider extends StatelessWidget {
  const _VolumeSlider({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.onChangeEnd,
  });

  final String label;
  final double value;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangeEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label  ${(value * 100).round()}%',
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        Slider(
          value: value,
          activeColor: const Color(0xFF6B46C1),
          onChanged: onChanged,
          onChangeEnd: onChangeEnd,
        ),
      ],
    );
  }
}
