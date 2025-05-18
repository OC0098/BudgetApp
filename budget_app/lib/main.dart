// Importación de paquetes de Flutter
import 'package:flutter/material.dart';
import 'home_page.dart';

// --------------------------------------------
// PUNTO DE ENTRADA PRINCIPAL DE LA APLICACIÓN
// --------------------------------------------
void main() {
  // Inicia la aplicación con el widget BudgetApp
  runApp(const BudgetApp());
}

// --------------------------------------------
// CONFIGURACIÓN PRINCIPAL DE LA APP (WIDGET RAÍZ)
// --------------------------------------------
class BudgetApp extends StatelessWidget {
  const BudgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BUDGET APP', // Nombre de la aplicación
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de debug
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo), // Tema principal
        useMaterial3: true, // Habilita Material 3
      ),
      home: const LoginScreen(), // Pantalla inicial
    );
  }
}

// --------------------------------------------
// PANTALLA DE INICIO DE SESIÓN (STATEFUL WIDGET)
// --------------------------------------------
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// --------------------------------------------
// ESTADO Y LÓGICA DE LA PANTALLA DE LOGIN
// --------------------------------------------
class _LoginScreenState extends State<LoginScreen> {
  // Controladores para los campos de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // ------------------------------------------
  // MÉTODO PARA MANEJAR EL INICIO DE SESIÓN
  // ------------------------------------------
  void _login() {
    // Obtiene y limpia los valores de los campos
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    // Validación de campos vacíos
    if (email.isEmpty || password.isEmpty) {
      // Mensaje dinámico según el campo faltante
      String message = email.isEmpty
          ? 'Por favor ingresa tu correo electrónico.'
          : 'Por favor ingresa tu contraseña.';

      // Muestra diálogo de error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Campos incompletos"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

 // Expresión regular para validar el formato del correo
  bool correoValido = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);

  if (!correoValido) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Correo inválido"),
        content: const Text("Por favor ingresa un correo electrónico válido."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
    return;
  }

    // Muestra notificación de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Inicio de sesión exitoso")),
    );
  
    Future.delayed(const Duration(seconds: 1), () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  });
}  

  // ------------------------------------------
  // CONSTRUCCIÓN DE LA INTERFAZ DE USUARIO
  // ------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        title: const Text("BUDGET APP"),
        backgroundColor: Colors.indigo[900], // Color de fondo
        foregroundColor: Colors.white, // Color del texto/iconos
      ),
      
      // Cuerpo de la pantalla
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
          // Imagen de login
          Image.asset(
          'Imagenes/Imagen_finanzas_login.png',
          height: 200,
          ),

          const SizedBox(height: 20), // Espacio entre iamgen y bienvenida

            // Mensaje de bienvenida
            const Text(
              "Bienvenido a BUDGET APP, inicia sesión", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20,), // Espaciador

            // Campo de correo electrónico
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress, // Teclado optimizado para emails
              decoration: const InputDecoration(
                labelText: "Correo electrónico",
                border: OutlineInputBorder(), // Borde con estilo Material
              ),
            ),

            const SizedBox(height: 20), // Espaciador

            // Campo de contraseña
            TextField(
              controller: _passwordController,
              obscureText: true, // Oculta el texto para contraseñas
              decoration: const InputDecoration(
                labelText: "Contraseña",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30), // Espaciador más grande

            // Botón de inicio de sesión
            ElevatedButton(
              onPressed: _login, // Método que se ejecuta al presionar
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[900], // Color de fondo
                foregroundColor: Colors.white, // Color del texto
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Bordes redondeados
                ),
              ),
              child: const Text("Iniciar Sesión"),
            ),
          ],
        ),
      ),
    );
  }
}