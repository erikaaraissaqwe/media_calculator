import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('TAREFA FINAL', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        body: MediaCalculator(),
      ),
    );
  }
}

class MediaCalculator extends StatefulWidget {
  @override
  _MediaCalculatorState createState() => _MediaCalculatorState();
}

class _MediaCalculatorState extends State<MediaCalculator> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nota1Controller = TextEditingController();
  final TextEditingController _nota2Controller = TextEditingController();
  final TextEditingController _nota3Controller = TextEditingController();

  String _nameResult = '';
  String _emailResult = '';
  String _notasResult = '';
  String _mediaResult = '';

  void _calcularMedia() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _nameResult = _nameController.text;
        _emailResult = _emailController.text;
        _notasResult = '${_nota1Controller.text} -- ${_nota2Controller.text} -- ${_nota3Controller.text}';

        double nota1 = double.tryParse(_nota1Controller.text) ?? 0.0;
        double nota2 = double.tryParse(_nota2Controller.text) ?? 0.0;
        double nota3 = double.tryParse(_nota3Controller.text) ?? 0.0;
        double media = (nota1 + nota2 + nota3) / 3;

        _mediaResult = media.toStringAsFixed(2);
      });
    }
  }

  void _apagarCampos() {
    setState(() {
      _nameController.clear();
      _emailController.clear();
      _nota1Controller.clear();
      _nota2Controller.clear();
      _nota3Controller.clear();

      _nameResult = '';
      _emailResult = '';
      _notasResult = '';
      _mediaResult = '';
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o email';
    }
    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Por favor, insira um email válido';
    }
    return null;
  }

  String? _validateNota(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira a nota';
    }
    double? nota = double.tryParse(value);
    if (nota == null || nota < 0 || nota > 10) {
      return 'Por favor, insira uma nota entre 0 e 10';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CALCULADOR DE MEDIA',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o nome';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: _validateEmail,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _nota1Controller,
                          decoration: InputDecoration(labelText: 'Nota 1'),
                          keyboardType: TextInputType.number,
                          validator: _validateNota,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextFormField(
                          controller: _nota2Controller,
                          decoration: InputDecoration(labelText: 'Nota 2'),
                          keyboardType: TextInputType.number,
                          validator: _validateNota,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextFormField(
                          controller: _nota3Controller,
                          decoration: InputDecoration(labelText: 'Nota 3'),
                          keyboardType: TextInputType.number,
                          validator: _validateNota,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _calcularMedia,
                      child: Text('CALCULAR MÉDIA'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: Text(
                      'Resultado',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text('Nome: $_nameResult'),
                  Text('Email: $_emailResult'),
                  Text('Notas: $_notasResult'),
                  Text('Média: $_mediaResult'),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _apagarCampos,
                      child: Text('APAGA OS CAMPOS'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}