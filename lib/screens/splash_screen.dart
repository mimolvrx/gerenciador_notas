import 'package:flutter/material.dart';
import 'package:gerenciador_notas/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //initState() roda uma vez, quando o estado é criado
    super.initState(); // mantém a inicialização da classe pai.

    abrirHome(); // inicia a espera e a troca de tela
  }

  // Future<void>: operação assíncron que não retorna valor
  Future<void> abrirHome() async {
    // aguarda 2 segundo sem travar a interface
    // await -> esperar
    await Future.delayed(const Duration(seconds: 2));

    // mounted é false se esta tela já foi removida da arvore.
    // Não podemos usar context para navegar depois disso
    if (!mounted) return;

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const HomeScreen()),
    // );
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        
        transitionDuration: const Duration(seconds: 2),
        reverseTransitionDuration: const Duration(milliseconds: 300),

        pageBuilder: (context, animation, secondaryAnimation) {
          return const HomeScreen();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0, 1);
          const end = Offset.zero;

          final curva = CurvedAnimation(parent: animation, curve: Curves.ease);

          final tween = Tween<Offset>(begin: begin, end: end);

          final offsetAnimation = tween.animate(curva);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ocupar o necessário
          children: [
            Icon(Icons.edit_note, size: 78, color: Colors.indigo),

            const SizedBox(height: 20),

            Text(
              'Gerenciador de Notas',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
