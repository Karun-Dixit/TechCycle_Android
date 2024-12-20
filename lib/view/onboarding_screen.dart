import 'package:flutter/material.dart';
import 'package:sprint1/view/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Onboarding Screen',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const OnboardingPages(),
    );
  }
}

class OnboardingPages extends StatefulWidget {
  const OnboardingPages({super.key});

  @override
  _OnboardingPagesState createState() => _OnboardingPagesState();
}

class _OnboardingPagesState extends State<OnboardingPages> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Changed to white
      body: SafeArea(
        child: Column(
          children: [
            // PageView for Swipeable Screens
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                children: const [
                  OnboardingPage(
                    imagePath: 'assets/images/logo.png',
                    title: 'Choose Products',
                    subtitle:
                        'Browse a wide variety of products, handpicked just for you.',
                  ),
                  OnboardingPage(
                    imagePath: 'assets/images/buysell.png',
                    title: 'Buy or Sell Products',
                    subtitle: 'Trusted platform for buying/selling products.',
                  ),
                  OnboardingPage(
                    imagePath: 'assets/images/payment.png',
                    title: 'Fast Transaction',
                    subtitle:
                        'Pay for your selected items quickly and safely with our secure payment options.',
                  ),
                ],
              ),
            ),
            // Page Indicator and Next Button
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page Indicator Dots
                  Row(
                    children: [
                      buildPageIndicator(0),
                      buildPageIndicator(1),
                      buildPageIndicator(2),
                    ],
                  ),
                  // Next or Finish Button
                  TextButton(
                    onPressed: () {
                      if (currentPage < 2) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } else {
                        // Navigate to Login Page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      }
                    },
                    child: Text(
                      currentPage == 2 ? 'Finish' : 'Next',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function for page indicators
  Widget buildPageIndicator(int pageIndex) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 8.0,
      width: currentPage == pageIndex ? 20.0 : 8.0,
      decoration: BoxDecoration(
        color: currentPage == pageIndex ? Colors.red : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }
}

// Onboarding Page Widget
class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Skip Button at Top Right
        Positioned(
          top: 20,
          right: 20,
          child: TextButton(
            onPressed: () {
              // Navigate to Login Page when Skip is pressed
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // Content Centered
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Centers vertically
              children: [
                // Image - Adjusted size
                SizedBox(
                  width: 220, // Adjust width
                  height: 220, // Adjust height
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 40),

                // Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 26, // Slightly larger font
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 15),

                // Subtitle with darker text
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87, // Darker color
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
