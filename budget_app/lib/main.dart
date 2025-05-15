import 'package:flutter/material.dart';
import 'home_page.dart'; // Importación de la pantalla principal (HomePage)

// --------------------------------------------
// PUNTO DE ENTRADA DE LA APLICACIÓN
// --------------------------------------------
void main() {
  runApp(const MyApp());
}

// --------------------------------------------
// CONFIGURACIÓN PRINCIPAL DE LA APP
// --------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const LoginPage(), // Pantalla inicial
      debugShowCheckedModeBanner: false, // Oculta la banda de debug
    );
  }
}

// --------------------------------------------
// PANTALLA DE LOGIN (STATEFUL WIDGET)
// --------------------------------------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// --------------------------------------------
// ESTADO Y LÓGICA DEL LOGIN
// --------------------------------------------
class _LoginPageState extends State<LoginPage> {
  // Controladores para los campos de texto
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  // Estado para controlar la visualización del spinner de carga
  bool _isLoading = false;

  // ------------------------------------------
  // MÉTODO PARA MANEJAR EL INICIO DE SESIÓN
  // ------------------------------------------
  void _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // VALIDACIÓN 1: Campos vacíos
    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog(
        title: 'Campos incompletos',
        message: email.isEmpty && password.isEmpty
            ? 'Por favor ingresa tu correo y contraseña.'
            : email.isEmpty
                ? 'Por favor ingresa tu correo electrónico.'
                : 'Por favor ingresa tu contraseña.',
      );
      return;
    }

    // VALIDACIÓN 2: Formato de correo electrónico
    if (!email.contains('@') || !email.contains('.')) {
      _showErrorDialog(
        title: 'Correo inválido',
        message: 'Por favor ingresa un correo electrónico válido.',
      );
      return;
    }

    // Simulación de autenticación (carga)
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // Espera simulada
    setState(() => _isLoading = false);

    // Navegación a la pantalla principal (HomePage)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  // ------------------------------------------
  // MOSTRAR DIÁLOGO DE ERROR (REUTILIZABLE)
  // ------------------------------------------
  void _showErrorDialog({required String title, required String message}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------
  // INTERFAZ DE USUARIO (WIDGET BUILD)
  // ------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar Sesión")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo de correo electrónico
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Correo electrónico",
                border: OutlineInputBorder(),
                hintText: "ejemplo@correo.com",
              ),
            ),

            const SizedBox(height: 16),

            // Campo de contraseña

            const SizedBox(height: 20),

            // Botón de inicio de sesión o spinner
            _isLoading
                ? const CircularProgressIndicator(color: Colors.teal)
                : ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    child: const Text(
                      "Iniciar Sesión",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}