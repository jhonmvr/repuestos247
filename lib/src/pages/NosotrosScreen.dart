import 'package:flutter/material.dart';

class NosotrosScreen extends StatefulWidget {
  @override
  _NosotrosScreenState createState() => _NosotrosScreenState();
}

class _NosotrosScreenState extends State<NosotrosScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nosotros'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SlideTransition(
          position: _slideAnimation,
          child: ListView(
            children: [
              SizedBox(height: 16),
              // Visión Section
              SectionWidget(
                title: 'Visión',
                description:
                    'Convertirnos en la primera opción del Mercado nacional para la compra de repuestos automotrices abarcando las principales marcas comerciales con una atención eficiente y de calidad en los diferentes canales de atención, Mayorista, Concesionarios y seguros, Consumidor Final, Web a un precio competitivo y con una excelente calidad.',
              ),
              SizedBox(height: 24),
              // Misión Section
              SectionWidget(
                title: 'Misión',
                description:
                    'Garantizar el abastecimiento de repuesto de Colisión para las principales marcas comerciales en el mercado ecuatoriano con el mejor precio y calidad.',
              ),
              SizedBox(height: 24),
              // Aquí puedes añadir más detalles de valores si es necesario
            ],
          ),
        ),
      ),
    );
  }
}

class SectionWidget extends StatelessWidget {
  final String title;
  final String description;

  SectionWidget({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0, // Añadir sombra para un efecto de profundidad
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centrar el contenido horizontalmente
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
              textAlign: TextAlign.center, // Centrar el título
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 4,
                  height: 40,
                  color: Colors.lightBlue,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.justify, // Justificar la descripción
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
