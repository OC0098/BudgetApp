import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:budget_app/Profile.dart';
import 'package:budget_app/Income.dart';
import 'package:budget_app/Expense.dart';
import 'main.dart';

// --- PANTALLAS DE EJEMPLO PARA NAVEGACIÓN (NUEVAS) ---
// Estas son pantallas placeholder. Deberás crear las tuyas.





// --- FIN DE PANTALLAS DE EJEMPLO ---


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

  // Estado para el FAB expandible
  bool _isFabMenuOpen = false;

  void _toggleFabMenu() {
    setState(() {
      _isFabMenuOpen = !_isFabMenuOpen;
    });
  }

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
            Text("Desglose de Gastos", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: 10),
            expenseData.isNotEmpty
                ? PieChart(
                    dataMap: expenseData,
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
            Text("Fuentes de Ingresos", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: 10),
            incomeData.isNotEmpty
                ? PieChart(
                    dataMap: incomeData,
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
      floatingActionButton: _buildFloatingActionMenu(),
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

  Widget _buildFloatingActionMenu() {
    final ThemeData theme = Theme.of(context);
    final Color labelBackgroundColor = theme.brightness == Brightness.dark 
        ? theme.colorScheme.surfaceContainerHighest 
        : Colors.white; 
    final Color labelTextColor = theme.brightness == Brightness.dark
        ? theme.colorScheme.onSurface 
        : theme.primaryColor; 

    return Stack(
      alignment: Alignment.bottomRight,
      clipBehavior: Clip.none,
      children: <Widget>[
        if (_isFabMenuOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleFabMenu,
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),

        AnimatedOpacity(
          opacity: _isFabMenuOpen ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 250),
          child: Visibility(
            visible: _isFabMenuOpen,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70.0, right: 0.0), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  _buildFabOption(
                    icon: Icons.edit_note, // Icono para editar perfil
                    label: "Editar perfil",
                    labelBackgroundColor: labelBackgroundColor,
                    labelTextColor: labelTextColor,
                    onPressed: () {
                      _toggleFabMenu();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()));
                    },
                    heroTag: 'editProfileFab',
                  ),
                  const SizedBox(height: 12.0),
                  _buildFabOption(
                    icon: Icons.payments_outlined, // Icono para modificar ingresos
                    label: "Modificar fuente de ingresos",
                    labelBackgroundColor: labelBackgroundColor,
                    labelTextColor: labelTextColor,
                    onPressed: () {
                      _toggleFabMenu();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ModifyIncomeSourceScreen()));
                    },
                    heroTag: 'modifyIncomeFab',
                  ),
                  const SizedBox(height: 12.0),
                  _buildFabOption(
                    icon: Icons.price_check_outlined, // Icono para modificar gastos
                    label: "Modificar gastos",
                    labelBackgroundColor: labelBackgroundColor,
                    labelTextColor: labelTextColor,
                    onPressed: () {
                      _toggleFabMenu();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ModifyExpensesScreen()));
                    },
                    heroTag: 'modifyExpensesFab',
                  ),
                ],
              ),
            ),
          ),
        ),

        FloatingActionButton(
          onPressed: _toggleFabMenu,
          tooltip: _isFabMenuOpen ? 'Cerrar menú' : 'Abrir menú',
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Icon(
              _isFabMenuOpen ? Icons.close : Icons.add,
              key: ValueKey<bool>(_isFabMenuOpen), 
            ),
          ),
          heroTag: 'mainFab',
        ),
      ],
    );
  }

  Widget _buildFabOption({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required String heroTag,
    required Color labelBackgroundColor,
    required Color labelTextColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: labelBackgroundColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: labelTextColor,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        FloatingActionButton.small(
          heroTag: heroTag,
          onPressed: onPressed,
          child: Icon(icon),
        ),
      ],
    );
  }
}