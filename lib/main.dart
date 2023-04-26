import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _textoInfo = "Informe seus dados";

  final _formIMC = GlobalKey<FormState>();

  void _limpaCampos() {
    alturaController.text = '';
    pesoController.text = '';

    setState(() {
      _textoInfo = "Informe seus dados";
    });
  }

  String _getCategoryIMC(double imc) {
    String baseText = "Obesidade Grau III";

    if (imc < 16.5) {
      baseText = "Desnutrição";
    } else if (imc <= 18.5) {
      baseText = "Abaixo do Peso";
    } else if (imc <= 24.9) {
      baseText = "Peso ideal";
    } else if (imc <= 29.9) {
      baseText = "Sobrepeso";
    } else if (imc <= 34.9) {
      baseText = "Obesidade Grau I";
    } else if (imc <= 39.9) {
      baseText = "Obesidade Grau II";
    }

    return "$baseText (${imc.toStringAsPrecision(3)})";
  }

  void _calcularIMC() {
    if (!_formIMC.currentState!.validate()) {
      return;
    }

    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text) / 100;
    double imc = peso / pow(altura, 2);

    setState(() {
      _textoInfo = _getCategoryIMC(imc);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Calculadora IMC'),
            centerTitle: true,
            backgroundColor: Colors.green,
            actions: <Widget>[
              IconButton(
                  onPressed: _limpaCampos, icon: const Icon(Icons.refresh))
            ]),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Form(
              key: _formIMC,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Icon(Icons.person_outline,
                        size: 100.0, color: Colors.green),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Peso (KG)',
                      ),
                      style: const TextStyle(fontSize: 16.0),
                      controller: pesoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'O campo Peso é obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Altura (CM)',
                      ),
                      style: const TextStyle(fontSize: 16.0),
                      controller: alturaController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'O campo Altura é obrigatório';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                              onPressed: _calcularIMC,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              child: const Text('Calcular'))),
                    ),
                    Text(
                      _textoInfo,
                      textAlign: TextAlign.center,
                    )
                  ]),
            )));
  }
}
