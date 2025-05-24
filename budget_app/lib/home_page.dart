import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// --------------------------------------------
// PANTALLA PRINCIPAL TRAS EL LOGIN
// --------------------------------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _irAIngresos(BuildContext context) {
    // Aquí podrías usar Navigator.push para ir a la pantalla de ingresos
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navegar a pantalla de Ingresos')),
    );
  }

  void _irAEgresos(BuildContext context) {
    // Aquí podrías usar Navigator.push para ir a la pantalla de egresos
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navegar a pantalla de Egresos')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Presupuesto"),
        automaticallyImplyLeading: false, // Oculta el botón de retroceso
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.redAccent,
                      value: 40,
                      title: 'Alquiler\n40%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.orangeAccent,
                      value: 30,
                      title: 'Comida\n30%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.blueAccent,
                      value: 20,
                      title: 'Transporte\n20%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.greenAccent,
                      value: 10,
                      title: 'Otros\n10%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => _irAIngresos(context),
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Ingresos'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () => _irAEgresos(context),
              icon: const Icon(Icons.remove_circle_outline),
              label: const Text('Egresos'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}