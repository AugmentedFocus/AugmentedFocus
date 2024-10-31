import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
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
              _buildTextField(label: 'Email', hint: 'Enter your email'),
              const SizedBox(height: 20),

              _buildTextField(label: 'Name', hint: 'Enter your name'),
              const SizedBox(height: 20),

              _buildTextField(label: 'Password', hint: 'Create a password', obscureText: true),
              const SizedBox(height: 20),

              _buildTextField(label: 'Confirm password', hint: 'Confirm your password', obscureText: true),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'NEXT',
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
                  'By signing up, you agree to Photo\'s Terms of Service and Privacy Policy.',
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

  Widget _buildTextField({required String label, required String hint, bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
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

  // Function to show Terms and Privacy Dialog
  void _showTermsAndPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Terms of Service and Privacy Policy"),
        content: const SingleChildScrollView(
          child: Text(
            "Welcome to our application. By using this app, you agree to comply with our Terms of Service and Privacy Policy.\n\n"
                "Terms of Service:\n"
                "1. You agree not to misuse the service.\n"
                "2. Respect intellectual property rights.\n"
                "3. You accept full responsibility for your activities on the platform.\n\n"
                "Privacy Policy:\n"
                "1. We collect information to provide better services to all users.\n"
                "2. We do not share your personal information with third parties without consent.\n"
                "3. You have control over your personal information and can manage it within the app.\n\n"
                "Please review these terms carefully. If you do not agree with these terms, please do not register for or use the app.",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}