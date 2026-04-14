import 'package:flutter/material.dart';

class ConfirmacaoTela extends StatelessWidget {
  final String nome;
  final String idade;
  final String email;
  final String sexo;
  final bool aceitouTermos;

  const ConfirmacaoTela({
    super.key,
    required this.nome,
    required this.idade,
    required this.email,
    required this.sexo,
    required this.aceitouTermos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildInfoRow('Nome:', nome),
            const SizedBox(height: 15),
            _buildInfoRow('Idade:', idade),
            const SizedBox(height: 15),
            _buildInfoRow('Email:', email),
            const SizedBox(height: 15),
            _buildInfoRow('Sexo:', sexo),
            const SizedBox(height: 15),
            _buildInfoRow('Termos aceitos:', aceitouTermos ? 'Sim' : 'Não'),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Voltar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Editar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(label),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }
}