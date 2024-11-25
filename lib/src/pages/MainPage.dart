import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/src/widgets/CartScreen.dart';
import 'package:project/src/widgets/ListaCategorias.dart';
import '../widgets/ListaProductos.dart'; // Importar ListaProductos
import 'RegisterScreen.dart'; // Importa la pantalla de registro
import 'LoginScreen.dart'; // Importa la pantalla de login
import 'NosotrosScreen.dart'; // Importa la pantalla de "Nosotros"
import 'ContactosScreen.dart'; // Importa la pantalla de "Contactos"
import '../../services/sqlite_service.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isHomePageSelected = true;
  int cartItemCount = 0; // Contador de elementos en el carrito
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _updateCartItemCount(); // Actualizar el contador al iniciar
  }

  Future<void> _updateCartItemCount() async {
    final cartItems = await _databaseService.getProducts();
    setState(() {
      cartItemCount = cartItems.length; // Actualizar la cantidad de productos
    });
  }

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.sort, color: Colors.black54),
            onSelected: (String choice) {
              switch (choice) {
                case 'Registrar':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                  break;
                case 'Logear':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                  break;
                case 'Nosotros':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NosotrosScreen()),
                  );
                  break;
                case 'Contactos':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactosScreen()),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Registrar', 'Logear', 'Nosotros', 'Contactos'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
          CircleAvatar(
            radius: 40, // Tamaño del avatar
            backgroundColor: Colors.transparent, // Fondo transparente
            child: SvgPicture.asset(
              'assets/user.svg', // Asegúrate de colocar el archivo SVG en la carpeta assets
              fit: BoxFit.cover,
              width: 80, // Ajusta el tamaño de la imagen SVG
              height: 80,
            ),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                isHomePageSelected ? 'Nuestros' : 'Carrito',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w400),
              ),
              Text(
                isHomePageSelected ? 'Productos' : '',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
              ),
            ],
          ),

        ],
      ),
    );
  }

  void onBottomIconPressed(int index) {
    setState(() {
      isHomePageSelected = index == 0;
    });
    if (index == 1) {
      // Actualizar el carrito cuando se selecciona el botón de carrito
      _updateCartItemCount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _appBar(),
            _title(),
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: isHomePageSelected
                    ? ListaCategorias() // Lista de productos
                    : CartScreen(), // Página del carrito
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onBottomIconPressed,
        currentIndex: isHomePageSelected ? 0 : 1,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                if (cartItemCount > 0) // Mostrar el contador si hay productos
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '$cartItemCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Carrito',
          ),
        ],
      ),
    );
  }
}
