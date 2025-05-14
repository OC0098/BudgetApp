import 'package:flutter/material.dart';

void main() => runApp(const BudgetApp());

class BudgetApp extends StatelessWidget {
  const BudgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BUDGET APP',
      home: const BudgetHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BudgetHome extends StatefulWidget {
  const BudgetHome({super.key});

  @override
  State<BudgetHome> createState() => _BudgetHomeState();
}

class _BudgetHomeState extends State<BudgetHome> {
  final List<Map<String, dynamic>> _transactions = [];
  final TextEditingController _amountController = TextEditingController();
  String _type = 'Ingreso'; // Por defecto

  void _addTransaction() {
    final double? amount = double.tryParse(_amountController.text);

    if (amount == null || amount <= 0) return;

    setState(() {
      _transactions.add({
        'type': _type,
        'amount': amount,
        'date': DateTime.now(),
      });
      _amountController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BUDGET APP')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Formulario para ingresar monto y tipo
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Monto'),
            ),
            DropdownButton<String>(
              value: _type,
              items: const [
                DropdownMenuItem(value: 'Ingreso', child: Text('Ingreso')),
                DropdownMenuItem(value: 'Egreso', child: Text('Egreso')),
              ],
              onChanged: (value) {
                setState(() {
                  _type = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: _addTransaction,
              child: const Text('Registrar'),
            ),
            const SizedBox(height: 20),
            const Text('Transacciones registradas:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final tx = _transactions[index];
                  return ListTile(
                    leading: Icon(
                      tx['type'] == 'Ingreso' ? Icons.arrow_downward : Icons.arrow_upward,
                      color: tx['type'] == 'Ingreso' ? Colors.green : Colors.red,
                    ),
                    title: Text('${tx['type']} - \$${tx['amount']}'),
                    subtitle: Text(tx['date'].toString()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}