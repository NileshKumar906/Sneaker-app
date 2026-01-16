import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import 'signup_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final authService = ref.read(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ShopSneakers - Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
          TextField(controller: _password, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
          const SizedBox(height: 12),
          if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
          ElevatedButton(
            onPressed: _loading
                ? null
                : () async {
              setState(() { _loading = true; _error = null; });
              try {
                await authService.signIn(email: _email.text.trim(), password: _password.text.trim());
              } catch (e) {
                setState(() { _error = e.toString(); });
              } finally {
                setState(() { _loading = false; });
              }
            },
            child: _loading ? const CircularProgressIndicator() : const Text('Login'),
          ),
          TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen())), child: const Text('Create account'))
        ]),
      ),
    );
  }
}
