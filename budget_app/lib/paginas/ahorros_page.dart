import 'package:flutter/material.dart';

class AhorrosPage extends StatelessWidget {
  const AhorrosPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos ficticios de transferencias
    final List<Map<String, dynamic>> transferencias = [
      {"monto": 100.0, "tipo": "Ingreso", "fecha": "2025-05-01"},
      {"monto": 50.0, "tipo": "Egreso", "fecha": "2025-05-05"},
      {"monto": 200.0, "tipo": "Ingreso", "fecha": "2025-05-10"},
      {"monto": 75.0, "tipo": "Egreso", "fecha": "2025-05-15"},
    ];

    // Cálculo del total ahorrado
    double total = 0;
    for (var t in transferencias) {
      total += t["tipo"] == "Ingreso" ? t["monto"] : -t["monto"];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ahorros"),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Total Ahorrado
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      "Total Ahorrado",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "\$${total.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 32, color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Historial de Transferencias",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Lista de transferencias
            Expanded(
              child: ListView.builder(
                itemCount: transferencias.length,
                itemBuilder: (context, index) {
                  final t = transferencias[index];
                  return ListTile(
                    leading: Icon(
                      t["tipo"] == "Ingreso" ? Icons.arrow_downward : Icons.arrow_upward,
                      color: t["tipo"] == "Ingreso" ? Colors.green : Colors.red,
                    ),
                    title: Text("${t["tipo"]}: \$${t["monto"]}"),
                    subtitle: Text("Fecha: ${t["fecha"]}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}