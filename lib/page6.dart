import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Assurez-vous d'importer google_fonts si vous l'utilisez

class Page6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 247, 245, 209), // Change l'arrière-plan en blanc
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/images/icon.png',
              width: 30,
              height: 30,
            ),
            Text(
            "نبتون",
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 35,
              ),
            ),
            // Icône stable
            IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Image de fond réduite
          Center(
            child: Container(
              width: 500, // Taille réduite de l'image de fond
              height: 500, // Taille réduite de l'image de fond
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/planet.png'),
                  fit: BoxFit
                      .contain, // L'image se redimensionne sans déformation
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          // Image en haut à droite avec rotation
          Positioned(
            top: 10, // Positionnée à 50 pixels du haut
            left: 10, // Positionnée à 10 pixels du bord droit
            child: Transform.rotate(
              angle: 0.5, // Rotation de 0.5 radians (environ 28.6 degrés)
              child: Image.asset(
                'assets/images/image1.png',
                width: 80, // Taille de l'image
                height: 80, // Taille de l'image
              ),
            ),
          ),
          // Image en bas à gauche avec rotation
          Positioned(
            bottom: 10, // Positionnée à 10 pixels du bas
            right: 10, // Positionnée à 10 pixels du bord gauche
            child: Transform.rotate(
              angle: -0.5, // Rotation de -0.5 radians (environ -28.6 degrés)
              child: Image.asset(
                'assets/images/image1.png',
                width: 80, // Taille de l'image
                height: 80, // Taille de l'image
              ),
            ),
          ),
          // Carré transparent au centre
          Center(
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'المريخ هو الكوكب الرابع من الشمس. لونه أحمر بسبب التراب على سطحه. يومه مشابه لليوم على الأرض، لكن سنته أطول. يحتوي على جبال وأودية، وكان فيه ماء في الماضي. له قمران صغيران هما فوبوس وديموس.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
