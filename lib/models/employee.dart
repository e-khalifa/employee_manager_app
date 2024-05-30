class Employee {
  int? id;
  String name;
  String title;
  String email;
  String phone;

  Employee({
    this.id,
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'email': email,
      'phone': phone,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      title: map['title'],
      email: map['email'],
      phone: map['phone'],
    );
  }
}
