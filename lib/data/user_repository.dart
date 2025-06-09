class FakeUserRepository {
  static final List<Map<String, String>> _users = [
    {'email': 'ejemplo@correo.com', 'password': '123456'},
    {'email': 'admin@demo.com', 'password': 'admin123'},
    {'email': 'leocesias', 'password': '123'},
  ];

  static List<Map<String, String>> get users => _users;

  static void addUser(String email, String password) {
    _users.add({'email': email, 'password': password});
  }

  static bool authenticate(String email, String password) {
    return _users.any(
          (user) => user['email'] == email && user['password'] == password,
    );
  }
}