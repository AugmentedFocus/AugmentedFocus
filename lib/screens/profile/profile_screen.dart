import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FAQ Button

            // Circle Avatar with Shadow
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade300,
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Text Fields with Rounded Borders
            _buildTextField(label: 'Leonardo Cesias', hint: 'Leonardo Cesias'),
            const SizedBox(height: 16),
            _buildTextField(label: '71205216', hint: '71205216'),
            const SizedBox(height: 16),
            _buildTextField(
                label: 'lpcd_04@hotmail.com', hint: 'lpcd_04@hotmail.com'),
            const SizedBox(height: 16),
            _buildTextField(label: 'Carlos Gonzales 251', hint: 'Carlos Gonzales 251'),

            const SizedBox(height: 30),

            // Logout Button
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Cerrar sesión',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showFAQDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Preguntas Frecuentes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Button to Report Error
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ReportErrorScreen()));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Reportar Error',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Función para mostrar el diálogo FAQ
  void _showFAQDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Preguntas Frecuentes'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                _buildFAQItem(
                  question: '¿Cómo puedo realizar una actividad de aprendizaje con realidad aumentada?',
                  answer:
                  'Para realizar una actividad con realidad aumentada, ingresa a la sección de actividades, selecciona una actividad marcada como "Realidad Aumentada" y sigue las instrucciones en pantalla. La aplicación te dará retroalimentación en tiempo real durante la actividad.',
                ),
                _buildFAQItem(
                  question: '¿Qué hago si la cámara no detecta correctamente los objetos en realidad aumentada?',
                  answer:
                  'Si la cámara tiene problemas para detectar objetos, verifica que la iluminación sea adecuada y que el marcador esté en un lugar visible. La aplicación mostrará un mensaje con recomendaciones para mejorar la detección.',
                ),
                _buildFAQItem(
                  question: '¿Cómo puedo ver mi progreso y estadísticas en la aplicación?',
                  answer:
                  'Accede a la sección de estadísticas desde el menú principal para ver un resumen de tus logros, áreas de mejora y evolución a lo largo del tiempo. Si tienes problemas para cargar las estadísticas, puedes intentar recargar o contactar soporte.',
                ),
                _buildFAQItem(
                  question: '¿Puedo acceder a contenido educativo adicional?',
                  answer:
                  'Sí, en la sección de recursos educativos puedes encontrar artículos, videos y juegos adicionales que refuerzan tu aprendizaje. Si hay problemas para cargar el contenido, intenta más tarde o contacta soporte.',
                ),
                _buildFAQItem(
                  question: '¿Cómo puedo descargar contenido de realidad aumentada para usar sin conexión?',
                  answer:
                  'Si tienes conexión a internet, selecciona la opción de descargar actividades y contenido AR para usarlos sin conexión. En caso de problemas con la descarga, revisa tu conexión o el espacio en tu dispositivo.',
                ),
                _buildFAQItem(
                  question: '¿Cómo puedo revisar mis logros y avances en las actividades de realidad aumentada?',
                  answer:
                  'Ve a la sección de logros y progreso para ver tus trofeos, niveles completados y recomendaciones. Si no puedes visualizar tus logros, intenta recargar o contacta soporte técnico.',
                ),
                _buildFAQItem(
                  question: '¿Qué hago si olvidé mi contraseña o no puedo iniciar sesión?',
                  answer:
                  'Si ingresas una contraseña incorrecta, la aplicación mostrará un mensaje de error. Si tu usuario no está registrado, también recibirás un aviso. Puedes usar la opción de recuperación de contraseña o registrarte si aún no tienes cuenta.',
                ),
                _buildFAQItem(
                  question: '¿Puedo interactuar con objetos en 3D durante las actividades de realidad aumentada?',
                  answer:
                  'Sí, puedes rotar, acercar o alejar los objetos virtuales que aparecen al enfocar la cámara en los marcadores AR, para una experiencia más dinámica e interactiva.',
                ),
                _buildFAQItem(
                  question: '¿Cómo puedo personalizar las opciones de accesibilidad en la aplicación?',
                  answer:
                  'En la configuración de accesibilidad puedes ajustar el tamaño de fuente, contraste de colores y respuestas táctiles para adaptar la app a tus necesidades.',
                ),
                _buildFAQItem(
                  question: '¿Cómo puedo registrar mis datos personales y mantenerlos seguros?',
                  answer:
                  'La aplicación cifra y almacena tus datos personales siguiendo estándares de seguridad. En caso de una brecha de seguridad, serás notificado inmediatamente con las acciones que se tomarán.',
                ),
                _buildFAQItem(
                  question: '¿Cómo puedo ver y actualizar mi información personal?',
                  answer:
                  'Accede a tu perfil para visualizar y editar datos como nombre, correo electrónico y foto de perfil.',
                ),
                _buildFAQItem(
                  question: '¿Cómo puedo ver y organizar mis tareas pendientes?',
                  answer:
                  'En la sección de tareas verás una lista organizada por prioridad o fecha de entrega para ayudarte a cumplir con tus responsabilidades académicas.',
                ),
                _buildFAQItem(
                  question: '¿Cómo accedo a los cursos y sus actividades?',
                  answer:
                  'Desde la opción "Cursos" puedes navegar la lista de cursos disponibles y acceder a sus actividades para practicar y evaluar tu aprendizaje.',
                ),
                _buildFAQItem(
                  question: '¿Dónde puedo consultar las calificaciones obtenidas?',
                  answer:
                  'En la sección "Calificaciones" puedes revisar tus notas, desempeño y comentarios asociados a cada actividad evaluable.',
                ),
                _buildFAQItem(
                  question: '¿Cómo puedo aceptar los términos y condiciones de uso?',
                  answer:
                  'Durante el registro, encontrarás la sección de términos y condiciones que debes leer y aceptar para finalizar la creación de tu cuenta.',
                ),
                _buildFAQItem(
                  question: '¿Dónde puedo encontrar ayuda si tengo dudas sobre la aplicación?',
                  answer:
                  'En la sección "Preguntas Frecuentes" encontrarás respuestas organizadas para resolver tus dudas sin necesidad de asistencia externa.',
                ),
                _buildFAQItem(
                  question: '¿Puedo recibir notificaciones sobre tareas próximas a vencer?',
                  answer:
                  'Sí, la aplicación te enviará alertas para recordarte las fechas importantes de entrega de tareas.',
                ),
                _buildFAQItem(
                  question: '¿Cómo puedo reportar errores o problemas en la aplicación?',
                  answer:
                  'Usa la opción “Reportar error” para describir cualquier problema que encuentres y enviarlo al equipo técnico para su revisión y corrección.',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }


  // FAQ item widget
  Widget _buildFAQItem({required String question, required String answer}) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(answer),
        ),
      ],
    );
  }

  // Helper function to build text fields
  Widget _buildTextField({required String label, required String hint}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
}

class ReportErrorScreen extends StatefulWidget {
  const ReportErrorScreen({super.key});

  @override
  State<ReportErrorScreen> createState() => _ReportErrorScreenState();
}

class _ReportErrorScreenState extends State<ReportErrorScreen> {
  final TextEditingController _controller = TextEditingController();

  void _submitReport() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, escribe una descripción del error')),
      );
      return;
    }

    // Aquí podrías enviar el reporte a un backend o guardarlo

    // Luego, volver al perfil
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reporte enviado. Gracias por tu colaboración!')),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar Error'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Describe el error que encontraste:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Escribe aquí el error...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitReport,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Enviar Reporte',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}