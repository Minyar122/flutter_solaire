import 'package:flutter/material.dart';
import 'dart:math';

import 'package:system_solaire/page1.dart';

void main() => runApp(SolarSystemApp());

class SolarSystemApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: SolarSystem(),
      routes: {
        '/page1': (context) => Page1(), // Route vers la page1
      },
    );
  }
}

class SolarSystem extends StatefulWidget {
  @override
  _SolarSystemState createState() => _SolarSystemState();
}

class _SolarSystemState extends State<SolarSystem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF051d41),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400, // Taille globale agrandie du système solaire
              height: 400,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildSun(),
                  _buildOrbitCircle(80.0), // Cercle pour l'orbite de Mercure
                  _buildOrbitCircle(120.0), // Cercle pour l'orbite de Vénus
                  _buildOrbitCircle(160.0), // Cercle pour l'orbite de la Terre
                  _buildOrbitCircle(200.0), // Cercle pour l'orbite de Mars
                  _buildOrbit(
                      80.0, _controller, 0.24, 'mercury.png'), // Mercure
                  _buildOrbit(120.0, _controller, 0.62, 'venus.png'), // Vénus
                  _buildOrbit(160.0, _controller, 1.0, 'earth.png'), // Terre
                  _buildOrbit(200.0, _controller, 1.88, 'mars.png'), // Mars
                  // Ajoutez d'autres planètes ici si nécessaire
                ],
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/page1');
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/icon.png'), // Icône à cliquer
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSun() {
    return Container(
      width: 80, // Taille agrandie du Soleil
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/images/sun.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildOrbit(double radius, AnimationController controller,
      double speedMultiplier, String planetImage) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final angle = 2 * pi * controller.value * speedMultiplier;
        final offsetX = radius * cos(angle);
        final offsetY = radius * sin(angle);
        return Transform.translate(
          offset: Offset(offsetX, offsetY),
          child: child,
        );
      },
      child: _buildPlanet(planetImage),
    );
  }

  Widget _buildPlanet(String planetImage) {
    return Container(
      width: 30, // Taille agrandie des planètes
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/images/$planetImage'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildOrbitCircle(double radius) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
    );
  }
}
