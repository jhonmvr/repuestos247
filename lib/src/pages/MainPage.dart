import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/ListaProductos.dart'; // Importar ListaProductos

class MainPage extends StatefulWidget {
  MainPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isHomePageSelected = true;

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.sort, color: Colors.black54),
            onPressed: () {},
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
                isHomePageSelected ? 'Our' : 'Shopping',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w400),
              ),
              Text(
                isHomePageSelected ? 'Products' : 'Cart',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Spacer(),
          if (!isHomePageSelected)
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.orange),
              onPressed: () {},
            ),
        ],
      ),
    );
  }

  void onBottomIconPressed(int index) {
    setState(() {
      isHomePageSelected = index == 0 || index == 1;
    });
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
                child: isHomePageSelected ? ListaProductos() : ShoppingCartPage(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onBottomIconPressed,
        currentIndex: isHomePageSelected ? 0 : 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}

class ShoppingCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Shopping Cart'),
    );
  }
}
