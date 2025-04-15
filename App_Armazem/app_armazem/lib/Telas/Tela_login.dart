import 'package:flutter/material.dart';
import 'package:app_armazem/Model/usuario.dart';
import 'package:app_armazem/telas/tela_requisicao_pecas.dart'; // Importe sua tela de requisição

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _mostrarSenha = false;
  bool _carregando = false;
  String? _erroLogin;

  @override
  void dispose() {
    _usernameController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _fazerLogin() async {
    setState(() {
      _carregando = true;
      _erroLogin = null;
    });

    // Simulação de processamento
    await Future.delayed(Duration(seconds: 1));

    // Verificação do usuário teste
    if (_usernameController.text == Usuario.usuarioTeste.username &&
        _senhaController.text == Usuario.usuarioTeste.senha) {
      // Login bem-sucedido - navegar para tela de requisição
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => TelaRequisicaoPecas()),
      );
    } else {
      setState(() {
        _erroLogin = 'Usuário ou senha incorretos';
      });
    }

    setState(() => _carregando = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF398AE5), Color(0xFF478DE0)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_outline, size: 100, color: Colors.white),
                SizedBox(height: 30),
                _buildCardLogin(),
                if (_erroLogin != null) ...[
                  SizedBox(height: 20),
                  Text(
                    _erroLogin!,
                    style: TextStyle(color: Colors.red[200], fontSize: 16),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardLogin() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Usuário',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(
                labelText: 'Senha',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _mostrarSenha ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() => _mostrarSenha = !_mostrarSenha);
                  },
                ),
                border: OutlineInputBorder(),
              ),
              obscureText: !_mostrarSenha,
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _carregando ? null : _fazerLogin,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child:
                    _carregando
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('ENTRAR', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
