import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'page2.dart';
import 'page3.dart';
import 'page4.dart';
import 'page5.dart';
import 'page6.dart';
import 'page7.dart';
import 'page8.dart';
import 'page9.dart';
import 'Quiz.dart'; // Importez la page Quiz ici

void main() {
  runApp(Page1());
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/images/icon.png', // Assurez-vous que l'image existe
                width: 30,
                height: 30,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  "النظام الشمسي", // "Système solaire" en arabe
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 35,
                  ),
                ),
              ),
              RotatingIcon(),
            ],
          ),
        ),
        body: GridView.builder(
          padding: EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.8,
          ),
          itemCount: planetList.length,
          itemBuilder: (context, index) {
            return PlanetCard(planet: planetList[index]);
          },
        ),
      ),
    );
  }
}

class RotatingIcon extends StatefulWidget {
  @override
  _RotatingIconState createState() => _RotatingIconState();
}

class _RotatingIconState extends State<RotatingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value,
          child: IconButton(
            icon: Icon(Icons.quiz, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Quiz()), // Aller à la page Quiz
              );
            },
          ),
        );
      },
    );
  }
}

class PlanetCard extends StatefulWidget {
  final Map<String, String> planet;

  PlanetCard({required this.planet});

  @override
  _PlanetCardState createState() => _PlanetCardState();
}

class _PlanetCardState extends State<PlanetCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.planet['name']?.toLowerCase() == 'الأرض') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Page2()),
          );
        } else if (widget.planet['name']?.toLowerCase() == 'عطارد') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Page3()),
          );
        } else if (widget.planet['name']?.toLowerCase() == 'المريخ') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Page4()),
          );
        } else if (widget.planet['name']?.toLowerCase() == 'المشتري') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Page5()),
          );
        } else if (widget.planet['name']?.toLowerCase() == 'نبتون') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Page6()),
          );
        } else if (widget.planet['name']?.toLowerCase() == 'أورانوس') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Page7()),
          );
        } else if (widget.planet['name']?.toLowerCase() == 'شمس') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Page8()),
          );
        } else if (widget.planet['name']?.toLowerCase() == 'زحل') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Page9()),
          );
        }
      },
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AnimatedBuilder(
                  animation: _rotationAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade300,
                          image: DecorationImage(
                            image: AssetImage(
                                getPlanetImage(widget.planet['name'] ?? '')),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                widget.planet['name']?.toUpperCase() ?? '',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              InfoRow(label: 'إمالة', value: '${widget.planet['tilt']}°'),
              InfoRow(label: 'يوم', value: '${widget.planet['day']} ساعة'),
              InfoRow(label: 'سنة', value: '${widget.planet['year']} يوم'),
            ],
          ),
        ),
      ),
    );
  }

  String getPlanetImage(String name) {
    switch (name.toLowerCase()) {
      case 'عطارد':
        return 'assets/images/mercury.png';
      case 'الزهرة':
        return 'assets/images/venus.png';
      case 'الأرض':
        return 'assets/images/earth.png';
      case 'المريخ':
        return 'assets/images/mars.png';
      case 'المشتري':
        return 'assets/images/jupiter.png';
      case 'زحل':
        return 'assets/images/saturn.png';
      case 'أورانوس':
        return 'assets/images/uranus.png';
      case 'نبتون':
        return 'assets/images/neptune.png';
      case ' بلوتو':
        return 'assets/images/pluto.png';
      case 'شمس':
        return 'assets/images/sun.png';
      default:
        return 'assets/images/placeholder.png';
    }
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, String>> planetList = [
  {"name": "عطارد", "tilt": "0.034", "day": "1,407", "year": "88"},
  {"name": "الزهرة", "tilt": "177.3", "day": "5,832", "year": "224.7"},
  {"name": "الأرض", "tilt": "23.5", "day": "24", "year": "365.25"},
  {"name": "المريخ", "tilt": "25.2", "day": "24.6", "year": "687"},
  {"name": "المشتري", "tilt": "3.1", "day": "9.9", "year": "4,333"},
  {"name": "زحل", "tilt": "26.7", "day": "10.7", "year": "10,759"},
  {"name": "أورانوس", "tilt": "97.8", "day": "17.2", "year": "30,687"},
  {"name": "نبتون", "tilt": "28.3", "day": "16.1", "year": "60,190"},
  {"name": "بلوتو", "tilt": "122.5", "day": "153.3", "year": "90,560"},
  {"name": "شمس", "tilt": "7", "day": "24", "year": "0"},
];
