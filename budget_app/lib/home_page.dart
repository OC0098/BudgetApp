import 'package:flutter/material.dart';

// --------------------------------------------
// PANTALLA PRINCIPAL TRAS EL LOGIN
// --------------------------------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Presupuesto"),
        automaticallyImplyLeading: false, // Oculta el botón de retroceso
      ),
      body: const Center(
        child: Text(
          "¡Bienvenido a tu gestor financiero!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}