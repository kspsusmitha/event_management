import 'dart:math';

import 'package:event_management/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'sign_in_screen.dart';
import 'signup_screen.dart';
import 'dart:math' as math;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  final List<ParticleModel> particles = [];
  final Random random = Random();
  bool _particlesInitialized = false;

  @override
  void initState() {
    super.initState();
    
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();

    // Check login state after animation
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkLoginState();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_particlesInitialized) {
      _initializeParticles();
      _particlesInitialized = true;
    }
  }

  void _initializeParticles() {
    final size = MediaQuery.of(context).size;
    particles.clear();
    for (int i = 0; i < 50; i++) {
      particles.add(ParticleModel(random, size));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => isLoggedIn 
          ? const HomeScreen() 
          : const SignupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Stack(
        children: [
          // Animated gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF6A1B9A),  // Deep Purple
                  const Color(0xFF4A148C),  // Darker Purple
                  Color.fromARGB(255, 48, 12, 94),  // Even darker purple
                ],
              ),
            ),
          ),
          
          // Floating particles
          ...List.generate(
            particles.length,
            (index) => AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                particles[index].update();
                return Positioned(
                  left: particles[index].x,
                  top: particles[index].y,
                  child: Container(
                    width: particles[index].size,
                    height: particles[index].size,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ),

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.celebration,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // App name with shimmer effect
                ShimmerText(
                  text: 'Red Carpet',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Tagline with slide animation
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _controller,
                    curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
                  )),
                  child: const Text(
                    'Look • Book • Enjoy',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Particle model for floating animation
class ParticleModel {
  late double x;
  late double y;
  late double speed;
  late double size;
  final Random random;
  final Size screenSize;

  ParticleModel(this.random, this.screenSize) {
    reset();
    y = random.nextDouble() * screenSize.height;
  }

  void reset() {
    x = random.nextDouble() * screenSize.width;
    y = 0;
    speed = 1 + random.nextDouble() * 2;
    size = 2 + random.nextDouble() * 4;
  }

  void update() {
    y += speed;
    if (y > screenSize.height) {
      reset();
    }
  }
}

// Shimmer text effect widget
class ShimmerText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const ShimmerText({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);

  @override
  State<ShimmerText> createState() => _ShimmerTextState();
}

class _ShimmerTextState extends State<ShimmerText> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: const [
              Colors.white,
              Colors.white70,
              Colors.white,
            ],
            stops: const [0.0, 0.5, 1.0],
            transform: GradientRotation(_shimmerController.value * 2 * math.pi),
          ).createShader(bounds),
          child: Text(
            widget.text,
            style: widget.style.copyWith(color: Colors.white),
          ),
        );
      },
    );
  }
} 