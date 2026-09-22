import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../core/sound_effects.dart';
import '../../data/firebase/backend_warmup.dart';
import 'game_mode_selection_screen.dart';

/// START 効果音（START_soft）の長さに合わせた遷移。
const _startFadeDuration = Duration(milliseconds: 1700);

/// ホーム画面
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _versionLabel;
  bool _opening = false;

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (!mounted) return;
    setState(() {
      _versionLabel = 'v${info.version}';
    });
  }

  Future<void> _openModes() async {
    if (_opening) return;
    setState(() => _opening = true);
    BackendWarmup.kickoff();
    Future<void>.delayed(const Duration(milliseconds: 100), () {
      if (!mounted) return;
      SoundEffects.instance.start();
    });
    try {
      await Navigator.push(context, _HomeToMenuRoute());
    } finally {
      if (mounted) {
        setState(() => _opening = false);
      } else {
        _opening = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final secondary = ModalRoute.of(context)?.secondaryAnimation;
    final fadeOut = secondary == null
        ? const AlwaysStoppedAnimation<double>(1)
        : Tween<double>(begin: 1, end: 0).animate(
            CurvedAnimation(parent: secondary, curve: Curves.easeInOut),
          );

    return ColoredBox(
      color: const Color(0xFF0A0E27),
      child: FadeTransition(
        opacity: fadeOut,
        child: _buildHome(),
      ),
    );
  }

  Widget _buildHome() {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      body: IgnorePointer(
        ignoring: _opening,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/home_background2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Positioned(
                      top: constraints.maxHeight * 0.25,
                      left: 0,
                      right: 0,
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Qリバーシ',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Quantum Computing Reversi',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: _openModes,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          backgroundColor: const Color(0xFF6B46C1),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        child: const Text(
                          'START',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    if (_versionLabel != null)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 16,
                        child: Text(
                          _versionLabel!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.35),
                            fontSize: 13,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeToMenuRoute extends PageRouteBuilder<void> {
  _HomeToMenuRoute()
      : super(
          transitionDuration: _startFadeDuration,
          reverseTransitionDuration: const Duration(milliseconds: 350),
          opaque: false,
          pageBuilder: (context, animation, secondaryAnimation) {
            return const GameModeSelectionScreen();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: const Interval(0.4, 1, curve: Curves.easeOut),
              ),
              child: child,
            );
          },
        );
}
