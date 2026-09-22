import 'package:flutter/material.dart';

import '../../core/sound_effects.dart';

/// AppBar の戻る。ボタンでもシステムの戻るでも reverse を一度だけ鳴らす。
class SoundBackButton extends StatefulWidget {
  const SoundBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  State<SoundBackButton> createState() => _SoundBackButtonState();
}

class _SoundBackButtonState extends State<SoundBackButton> {
  var _playedByButton = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) return;
        if (_playedByButton) {
          _playedByButton = false;
          return;
        }
        SoundEffects.instance.reverse();
      },
      child: BackButton(
        onPressed: () async {
          _playedByButton = true;
          await SoundEffects.instance.untilReversePlaying();
          if (!context.mounted) return;
          final custom = widget.onPressed;
          if (custom != null) {
            custom();
            return;
          }
          Navigator.maybePop(context);
        },
      ),
    );
  }
}
