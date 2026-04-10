import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Cadastro de Usuario',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.black,)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                "Preencha os campos abaixo",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black,),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: "Nome"),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: idadeController,
                decoration: const InputDecoration(labelText: "Idade"),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 10),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),

              const SizedBox(height: 20),

              DropdownButton<String>(
                hint: const Text("Selecione o sexo"),
                value: sexoSelecionado,
                isExpanded: true,
                items: ["Masculino", "Feminino", "Outro"]
                    .map((sexo) => DropdownMenuItem(
                  value: sexo,
                  child: Text(sexo),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    sexoSelecionado = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Checkbox(
                    value: aceitouTermos,
                    onChanged: (value) {
                      setState(() {
                        aceitouTermos = value!;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text("Aceito os termos de uso"),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  // depois vamos usar isso
                  print("Nome: ${nomeController.text}");
                  print("Idade: ${idadeController.text}");
                  print("Email: ${emailController.text}");
                  print("Sexo: $sexoSelecionado");
                  print("Aceitou termos: $aceitouTermos");
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