import 'package:flutter/material.dart';
import 'confirmacao_tela.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Usuario',
      home: const MyHomePage(title: 'Cadastro de Usuario'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? sexoSelecionado;
  bool aceitouTermos = false;

  final FocusNode nomeFocus = FocusNode();
  final FocusNode idadeFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();

  @override
  void dispose() {
    nomeController.dispose();
    idadeController.dispose();
    emailController.dispose();
    nomeFocus.dispose();
    idadeFocus.dispose();
    emailFocus.dispose();
    super.dispose();
  }

  bool validarCampos(BuildContext context) {
    if (nomeController.text.trim().isEmpty) {
      _mostrarSnackBar(context, 'Por favor, preencha o nome');
      return false;
    }

    if (idadeController.text.trim().isEmpty) {
      _mostrarSnackBar(context, 'Por favor, preencha a idade');
      return false;
    }

    int? idade;
    try {
      idade = int.parse(idadeController.text.trim());
    } catch (e) {
      _mostrarSnackBar(context, 'Idade deve ser um número válido');
      return false;
    }

    if (idade < 18) {
      _mostrarSnackBar(context, 'Você deve ter 18 anos ou mais');
      return false;
    }

    String email = emailController.text.trim();
    if (email.isEmpty) {
      _mostrarSnackBar(context, 'Por favor, preencha o email');
      return false;
    }
    if (!email.contains('@') || !email.contains('.')) {
      _mostrarSnackBar(context, 'Email inválido. Deve conter "@" e "."');
      return false;
    }

    if (sexoSelecionado == null) {
      _mostrarSnackBar(context, 'Por favor, selecione o sexo');
      return false;
    }

    if (!aceitouTermos) {
      _mostrarSnackBar(context, 'Você deve aceitar os termos de uso');
      return false;
    }

    return true;
  }

  void _mostrarSnackBar(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Preencha os campos abaixo",
              ),
              const SizedBox(height: 20),

              // Campo Nome
              TextField(
                controller: nomeController,
                focusNode: nomeFocus,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(idadeFocus);
                },
                decoration: const InputDecoration(
                  labelText: "Nome completo",
                  hintText: "Digite seu nome",
                ),
              ),
              const SizedBox(height: 10),

              // Campo Idade
              TextField(
                controller: idadeController,
                focusNode: idadeFocus,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(emailFocus);
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Idade",
                  hintText: "Digite sua idade",
                ),
              ),
              const SizedBox(height: 10),

              // Campo Email
              TextField(
                controller: emailController,
                focusNode: emailFocus,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                onSubmitted: (_) {
                  FocusScope.of(context).unfocus();
                },
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "exemplo@email.com",
                ),
              ),
              const SizedBox(height: 20),

              // Dropdown Sexo (sem estilização)
              DropdownButton<String>(
                hint: const Text("Selecione o sexo"),
                value: sexoSelecionado,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    value: "Masculino",
                    child: Text("Masculino"),
                  ),
                  DropdownMenuItem(
                    value: "Feminino",
                    child: Text("Feminino"),
                  ),
                  DropdownMenuItem(
                    value: "Outro",
                    child: Text("Outro"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    sexoSelecionado = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Checkbox Termos (sem estilização)
              Row(
                children: [
                  Checkbox(
                    value: aceitouTermos,
                    onChanged: (value) {
                      setState(() {
                        aceitouTermos = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      "Aceito os termos de uso",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Botão Cadastrar (sem estilização)
              ElevatedButton(
                onPressed: () {
                  if (validarCampos(context)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmacaoTela(
                          nome: nomeController.text.trim(),
                          idade: idadeController.text.trim(),
                          email: emailController.text.trim(),
                          sexo: sexoSelecionado!,
                          aceitouTermos: aceitouTermos,
                        ),
                      ),
                    );
                  }
                },
                child: const Text("Cadastrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}