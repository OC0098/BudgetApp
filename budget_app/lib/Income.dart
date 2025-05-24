
import 'package:flutter/material.dart';

class ModifyIncomeSourceScreen extends StatelessWidget {
  const ModifyIncomeSourceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Modificar Fuente de Ingresos")),
      body: const Center(child: Text("Pantalla para Modificar Fuentes de Ingresos")),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Presupuesto App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
     // home: const NuevoIngresoScreen(),
    );
  }
}
