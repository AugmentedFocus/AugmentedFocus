import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_emailController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, completa todos los campos."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Las contraseñas no coinciden."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Si todo está bien, se continúa con el registro (por ahora navegación)
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registrar',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Ingresa tu email'),
              const SizedBox(height: 20),

              _buildTextField(
                  controller: _nameController,
                  label: 'Nombre',
                  hint: 'Ingresa tu nombre'),
              const SizedBox(height: 20),

              _buildTextField(
                  controller: _passwordController,
                  label: 'Contraseña',
                  hint: 'Crea tu contraseña',
                  obscureText: true),
              const SizedBox(height: 20),

              _buildTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirmar contraseña',
                  hint: 'Confirma tu contraseña',
                  obscureText: true),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleRegister,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Siguiente',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              GestureDetector(
                onTap: () => _showTermsAndPrivacyDialog(context),
                child: const Text(
                  'Registrandote, aceptas los Terminos y Condiciones de Privacidad.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle:
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black54, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.orange, width: 2),
        ),
      ),
    );
  }

  void _showTermsAndPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Términos de uso y Política de privacidad"),
        content: const SingleChildScrollView(
          child: Text(
            "Bienvenido a nuestra aplicación. Al usar esta app, aceptas cumplir con nuestros Términos de uso y nuestra Política de privacidad.\n\n"
                "Términos de uso:\n"
                "1. No debes utilizar la aplicación para fines ilegales o inapropiados.\n"
                "2. Debes respetar los derechos de autor y la propiedad intelectual del contenido.\n"
                "3. Eres responsable del uso que hagas de la aplicación y de toda la información que proporciones.\n\n"
                "Política de privacidad:\n"
                "1. Recopilamos datos personales con el fin de mejorar tu experiencia educativa.\n"
                "2. No compartimos tu información con terceros sin tu consentimiento previo.\n"
                "3. Toda la información se almacena de forma segura y cifrada para proteger tu privacidad.\n\n"
                "Por favor, revisa cuidadosamente estos términos. Si no estás de acuerdo, te recomendamos no registrarte ni utilizar la aplicación.",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }
}

