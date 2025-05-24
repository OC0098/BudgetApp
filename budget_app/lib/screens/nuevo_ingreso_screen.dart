import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NuevoIngresoScreen extends StatefulWidget {
  const NuevoIngresoScreen({super.key});

  @override
  State<NuevoIngresoScreen> createState() => _NuevoIngresoScreenState();
}

class _NuevoIngresoScreenState extends State<NuevoIngresoScreen> {
  String selectedDate = DateFormat('EEEE, d MMMM', 'es_ES').format(DateTime.now());
  String amount = "0";
  String? selectedCategory;
  TextEditingController noteController = TextEditingController();

  List<String> categorias = ["Salario", "Venta", "Regalo", "Otro"];

  void addDigit(String digit) {
    setState(() {
      if (amount == "0") {
        amount = digit;
      } else {
        amount += digit;
      }
    });
  }

  void resetAmount() {
    setState(() {
      amount = "0";
    });
  }

  void guardarIngreso() {
    print('Fecha: $selectedDate');
    print('Monto: $amount');
    print('Nota: ${noteController.text}');
    print('Categoría: $selectedCategory');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5FFF4),
      appBar: AppBar(
        title: const Text("Nuevos ingresos"),
        backgroundColor: const Color(0xFF6DD5A1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(selectedDate, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.green, size: 32),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    amount,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(onPressed: resetAmount, icon: const Icon(Icons.close))
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(
                hintText: 'Nota',
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Elegir categoría',
                border: OutlineInputBorder(),
              ),
              value: selectedCategory,
              items: categorias.map((cat) {
                return DropdownMenuItem(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 7,
                children: [
                  ...["1", "2", "3"],
                  ...["4", "5", "6"],
                  ...["7", "8", "9"],
                  ...["C", "0", "C"],
                ].map((e) {
                  return GestureDetector(
                    onTap: () {
                      if (e == "C") {
                        resetAmount();
                      } else if (RegExp(r'[0-9]').hasMatch(e)) {
                        addDigit(e);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          e,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: guardarIngreso,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Guardar ingreso', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
