import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/dimmed_background.dart';
import '../../core/widgets/tilted_posters_grid.dart';
import '../../core/services/movies_api_service.dart';
import '../auth/presentation/screens/login_screen.dart';

class _OnboardPage {
  final String title;
  final String description;
  final String? imagePath;
  // The tint color for this page's overlay — matches the poster's mood,
  // like the reference design (teal, red, purple, orange...).
  final Color tintColor;
  const _OnboardPage(this.title, this.description, this.imagePath, this.tintColor);
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final MoviesApiService _apiService = MoviesApiService();

  List<String> _posterUrls = [];
  bool _isLoadingPosters = true;

  // TODO: swap these tint colors to match your exact Figma palette per page.
  final List<_OnboardPage> _pages = const [
    _OnboardPage(
      'Discover Movies',
      'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
      null,
      Color(0xFF0D3B3E), // dark teal
    ),
    _OnboardPage(
      'Explore All Genres',
      'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
      null,
      Color(0xFF5A1A0E), // deep red/orange
    ),
    _OnboardPage(
      'Create Watchlists',
      'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
      null,
      Color(0xFF3A1440), // deep purple
    ),
    _OnboardPage(
      'Rate, Review, and Learn',
      "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
      null,
      Color(0xFF4A0E0E), // dark crimson
    ),
    _OnboardPage(
      'Start Watching Now',
      '',
      null,
      Color(0xFF1A1A1A), // near-black, slight warmth
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadPosters();
  }

  Future<void> _loadPosters() async {
    final urls = await _apiService.fetchPosterUrls(limit: 12);
    if (!mounted) return;
    setState(() {
      _posterUrls = urls;
      _isLoadingPosters = false;
    });
  }

  void _goToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _next() {
    _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _back() {
    _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _pages.length + 1,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (context, index) {
          if (index == 0) return _buildIntroPage(context);
          final page = _pages[index - 1];
          final isLast = index == _pages.length;
          final showBack = index >= 2;
          return _buildContentPage(
            context,
            imagePath: page.imagePath,
            tintColor: page.tintColor,
            title: page.title,
            description: page.description,
            primaryLabel: isLast ? 'Finish' : 'Next',
            showBack: showBack,
            onPrimaryPressed: isLast ? _goToLogin : _next,
            onBackPressed: _back,
            pageIndexForPoster: index - 1,
          );
        },
      ),
    );
  }

  Widget _buildIntroPage(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        TiltedPostersGrid(posterUrls: _posterUrls),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                AppColors.background.withOpacity(0.75),
                AppColors.background,
              ],
              stops: const [0.0, 0.55, 1.0],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: context.horizontalPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Find Your Next\nFavorite Movie Here',
                    style: AppTextStyles.heading1.copyWith(fontSize: context.sp(30))),
                SizedBox(height: context.h(12)),
                Text(
                  'Get access to a huge library of movies to suit all tastes. You will surely like it.',
                  style: AppTextStyles.body,
                ),
                SizedBox(height: context.h(24)),
                PrimaryButton(label: 'Explore Now', onPressed: _next),
                SizedBox(height: context.h(24)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentPage(
      BuildContext context, {
        required String? imagePath,
        required Color tintColor,
        required String title,
        required String description,
        required String primaryLabel,
        required bool showBack,
        required VoidCallback onPrimaryPressed,
        required VoidCallback onBackPressed,
        required int pageIndexForPoster,
      }) {
    final backdropUrl = _posterUrls.isNotEmpty
        ? _posterUrls[pageIndexForPoster % _posterUrls.length]
        : null;

    return DimmedBackground(
      imageUrl: backdropUrl,
      imagePath: imagePath,
      tintColor: tintColor,
      overlayOpacity: 0.75,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(context.w(24), context.h(28), context.w(24), context.h(28)),
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: AppTextStyles.heading2, textAlign: TextAlign.center),
              if (description.isNotEmpty) ...[
                SizedBox(height: context.h(12)),
                Text(description, style: AppTextStyles.body, textAlign: TextAlign.center),
              ],
              SizedBox(height: context.h(24)),
              PrimaryButton(label: primaryLabel, onPressed: onPrimaryPressed),
              if (showBack) ...[
                SizedBox(height: context.h(12)),
                PrimaryButton(label: 'Back', isOutlined: true, onPressed: onBackPressed),
              ],
            ],
          ),
        ),
      ),
    );
  }
}