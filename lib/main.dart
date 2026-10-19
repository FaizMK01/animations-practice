import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fx_2_folder/books/books.dart';
import 'package:fx_2_folder/butterfly/butterfly_demo.dart';
import 'package:fx_2_folder/confetti/confetti_demo.dart';
import 'package:fx_2_folder/debug-overlay-3D/debug_overlay_3d.dart';
import 'package:fx_2_folder/folder_shape/folder_home.dart';
import 'package:fx_2_folder/fx_14_text_chaotic_spring/demo.dart';
import 'package:fx_2_folder/gemini-splash/gemini_splash_demo.dart';
import 'package:fx_2_folder/globe/3d_cloude_demo.dart';
import 'package:fx_2_folder/grid-animated/grid_animated.dart';
import 'package:fx_2_folder/light-bulb-night-mode/light_bulb_demo.dart';
import 'package:fx_2_folder/loader-square/loader_square_demo.dart';
import 'package:fx_2_folder/notification-list/notification_list.dart';
import 'package:fx_2_folder/orbit/orbit_demo.dart';
import 'package:fx_2_folder/page-flip/page_flip.dart';
import 'package:fx_2_folder/scroll-progress/scroll_progress_demo.dart';
import 'package:fx_2_folder/splash-door-open/splash_door_open.dart';
import 'package:fx_2_folder/stacked-cards/stacked_card.dart';
import 'package:fx_2_folder/stacked-expand-cards/stacked_expand_card.dart';
import 'package:fx_2_folder/infinite-scrolling/infinite_scrolling_3d.dart';
import 'package:fx_2_folder/tree/tree.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const AnimationShowcaseApp());

class AnimationShowcaseApp extends StatelessWidget {
  const AnimationShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'fx-widget Showcase',
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF1E222D),
        scaffoldBackgroundColor: const Color(0xFF0F1117),
        cardColor: const Color(0xFF161922),
        textTheme: GoogleFonts.robotoMonoTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: Colors.white),
      ),
      home: HomeScreen(),
    );
  }
}

class AnimationExample {
  final String title;
  final Widget Function(BuildContext) builder;
  final IconData icon;
  final Color? appBarColor;
  final bool isFullScreen;

  const AnimationExample({
    required this.title,
    required this.builder,
    required this.icon,
    this.appBarColor,
    this.isFullScreen = false,
  });
}

class HomeScreen extends StatelessWidget {
  final List<AnimationExample> examples = [
    AnimationExample(
      title: 'Butterfly Flight',
      icon: Icons.flutter_dash,
      builder: (context) => const ButterflyDemo(),
      appBarColor: Colors.black,
      isFullScreen: true,
    ),
    AnimationExample(
      title: 'Animated Folder',
      icon: Icons.folder_open_rounded,
      builder: (context) => const FolderHomeWidget(
          curve: Curves.easeInOutBack, title: 'EaseInOutBack'),
    ),
    AnimationExample(
      title: 'Book Shelf',
      icon: Icons.auto_stories_rounded,
      builder: (context) =>
          const BookShelfPage(title: 'Flutter Demo Home Page'),
    ),
    AnimationExample(
      title: '3D Logo Sphere',
      icon: Icons.public_rounded,
      builder: (context) => const TechStackDemo(),
      appBarColor: Colors.black,
    ),
    AnimationExample(
      title: 'Orbit System',
      icon: Icons.track_changes_rounded,
      builder: (context) => const OrbitDemo(),
      appBarColor: Colors.black,
    ),
    AnimationExample(
      title: 'Night Mode Bulb',
      icon: Icons.lightbulb_rounded,
      builder: (context) => const NightModeDemo(),
      appBarColor: Colors.black,
      isFullScreen: true,
    ),
    AnimationExample(
      title: 'Stacked Cards',
      icon: Icons.layers_rounded,
      builder: (context) => const StackedCardDemo(),
      appBarColor: Colors.black,
    ),
    AnimationExample(
      title: 'Expandable Stack',
      icon: Icons.view_carousel_rounded,
      builder: (context) => const StackedExpandedCardDemo(),
      appBarColor: Colors.black,
    ),
    AnimationExample(
      title: 'Confetti Burst',
      icon: Icons.celebration_rounded,
      builder: (context) => const ConfettiDemo(),
      appBarColor: Colors.black,
    ),
    AnimationExample(
      title: 'Scroll Progress',
      icon: Icons.linear_scale_rounded,
      builder: (context) => const ScrollProgressDemo(),
      appBarColor: Colors.black,
    ),
    AnimationExample(
      title: 'Sparkle Splash',
      icon: Icons.auto_awesome_rounded,
      builder: (context) => const SparkleDemo(),
      appBarColor: Colors.black,
    ),
    AnimationExample(
      title: 'Spring Physics Text',
      icon: Icons.waves_rounded,
      builder: (context) => const TextChaoticSpringDemo(),
      appBarColor: Colors.black,
    ),
    AnimationExample(
      title: 'Matrix Square Loader',
      icon: Icons.grid_view_rounded,
      builder: (context) => const LoaderSquareDemo(),
      appBarColor: Colors.black,
      isFullScreen: true,
    ),
    AnimationExample(
      title: 'Animated Grid',
      icon: Icons.grid_4x4_rounded,
      builder: (context) => const GridAnimatedDemo(),
      appBarColor: Colors.black,
    ),
    AnimationExample(
      title: '3D Page Flip',
      icon: Icons.menu_book_rounded,
      builder: (context) => const PageFlipDemo(),
      appBarColor: Colors.black,
      isFullScreen: true,
    ),
    AnimationExample(
      title: 'Notification Feed',
      icon: Icons.notifications_active_rounded,
      builder: (context) => const NotificationDemo(),
      appBarColor: Colors.black,
      isFullScreen: true,
    ),
    AnimationExample(
      title: 'Door Opening Reveal',
      icon: Icons.meeting_room_rounded,
      builder: (context) => SplashDoorOpenRevealDemo(),
      appBarColor: Colors.black,
      isFullScreen: true,
    ),
    AnimationExample(
      title: '3D Debug Inspector',
      icon: Icons.view_in_ar_rounded,
      builder: (context) => const OverlayDebugDemo(),
      appBarColor: Colors.black,
      isFullScreen: true,
    ),
    AnimationExample(
      title: 'Fractal Tree',
      icon: Icons.park_rounded,
      builder: (context) => const TreeDemo(),
      appBarColor: Colors.black,
      isFullScreen: true,
    ),
    AnimationExample(
      title: '3D Infinite Scroll',
      icon: Icons.view_carousel_outlined,
      builder: (context) => Marquee3D(),
      appBarColor: Colors.black,
      isFullScreen: false,
    ),
  ];

  HomeScreen({super.key});

  void enterFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  void exitFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1117),
      appBar: AppBar(
        title: const Text(
          'Animation Examples',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: const Color(0xFF0F1117),
        elevation: 0,
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.05,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
        ),
        itemCount: examples.length,
        itemBuilder: (context, index) {
          final example = examples[index];
          return Hero(
            tag: 'example_${example.title}',
            child: Card(
              elevation: 0,
              color: const Color(0xFF161922),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(
                  color: Color(0xFF262B3A),
                  width: 1,
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        if (example.isFullScreen) {
                          return FullScreen(
                            key: UniqueKey(),
                            example: example,
                          );
                        } else {
                          return DetailScreen(
                            key: UniqueKey(),
                            example: example,
                          );
                        }
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF202636),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          example.icon,
                          size: 30,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        example.title,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final AnimationExample example;

  const DetailScreen({super.key, required this.example});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(example.title),
        elevation: 0,
        backgroundColor: example.appBarColor ?? Theme.of(context).primaryColor,
      ),
      body: Hero(
        tag: 'example_${example.title}',
        child: example.builder(context),
      ),
    );
  }
}

class FullScreen extends StatelessWidget {
  final AnimationExample example;

  const FullScreen({super.key, required this.example});

  @override
  Widget build(BuildContext context) {
    return example.builder(context);
  }
}
