// home_page.dart

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart'; // Asegúrate de que esta importación esté aquí

// Si necesitas navegar de vuelta a LoginScreen desde HomePage (ej. para el logout)
// y LoginScreen está en, por ejemplo, 'login_screen.dart' o 'main.dart'
// tendrás que importarlo aquí.
// Ejemplo si LoginScreen está en main.dart Y NO es la misma clase que BudgetApp o main():
// import 'main.dart'; // Esto podría causar un ciclo de importación si main.dart también importa home_page.dart.
                     // Es mejor tener LoginScreen en su propio archivo si es posible.
// Si LoginScreen está en su propio archivo, por ejemplo, 'login_screen.dart':
import 'main.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Datos de ejemplo para los gastos
  Map<String, double> expenseData = {
    "Alimentación": 350.0,
    "Transporte": 120.0,
    "Vivienda": 500.0,
    "Ocio": 90.0,
    "Salud": 60.0,
  };

  // Datos de ejemplo para los ingresos
  Map<String, double> incomeData = {
    "Salario": 2000.0,
    "Bonos": 300.0,
    "Otros Ingresos": 50.0,
  };

  // Lista de colores para los gráficos (opcional)
  final List<Color> expenseColorList = [
    Colors.redAccent,
    Colors.orangeAccent,
    Colors.amberAccent,
    Colors.yellowAccent,
    Colors.limeAccent,
  ];

  final List<Color> incomeColorList = [
    Colors.greenAccent.shade700,
    Colors.tealAccent.shade700,
    Colors.cyanAccent.shade700,
  ];

  @override
  Widget build(BuildContext context) {
    double totalExpenses = expenseData.values.fold(0.0, (sum, item) => sum + item);
    double totalIncome = incomeData.values.fold(0.0, (sum, item) => sum + item);
    double balance = totalIncome - totalExpenses;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resumen Mensual"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Cerrar Sesión",
            onPressed: () {
              // Navega de vuelta al LoginScreen y elimina todas las rutas anteriores.
              // Asegúrate de que LoginScreen sea importado correctamente arriba.
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Sección de Resumen General
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.only(bottom: 20.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Resumen Financiero del Mes", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    _buildSummaryRow("Ingresos Totales:", totalIncome, Colors.green.shade700),
                    _buildSummaryRow("Gastos Totales:", totalExpenses, Colors.red.shade700),
                    const Divider(height: 20, thickness: 1),
                    _buildSummaryRow("Balance:", balance, balance >= 0 ? Colors.blue.shade700 : Colors.orange.shade700, isBold: true),
                  ],
                ),
              ),
            ),

            // Gráfico de Gastos
            Text("Desglose de Gastos", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: 10),
            expenseData.isNotEmpty
                ? PieChart(
                    dataMap: expenseData,
                    // ... otras propiedades del PieChart para gastos ...
                     animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 2.5,
                    colorList: expenseColorList,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 32,
                    centerText: "GASTOS",
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                      legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: false,
                    ),
                  )
                : const Center(child: Text("No hay datos de gastos para mostrar.")),
            const SizedBox(height: 30),

            // Gráfico de Ingresos
            Text("Fuentes de Ingresos", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: 10),
            incomeData.isNotEmpty
                ? PieChart(
                    dataMap: incomeData,
                    // ... otras propiedades del PieChart para ingresos ...
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 2.5,
                    colorList: incomeColorList,
                    initialAngleInDegree: 0,
                    chartType: ChartType.disc,
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                      legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: false,
                    ),
                  )
                : const Center(child: Text("No hay datos de ingresos para mostrar.")),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value, Color valueColor, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(
            "${value >= 0 ? '' : '-'}\$${value.abs().toStringAsFixed(2)}",
            style: TextStyle(fontSize: 16, color: valueColor, fontWeight: isBold ? FontWeight.bold : FontWeight.w600),
          ),
        ],
      ),
    );
  }
}