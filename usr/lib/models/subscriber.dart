class Subscriber {
  String id;
  String name;
  String email;
  String phone;
  DateTime registrationDate;
  double monthlyFee;
  List<Subscription> subscriptions;
  bool isActive;

  Subscriber({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.registrationDate,
    required this.monthlyFee,
    this.subscriptions = const [],
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'registrationDate': registrationDate.toIso8601String(),
      'monthlyFee': monthlyFee,
      'subscriptions': subscriptions.map((s) => s.toMap()).toList(),
      'isActive': isActive,
    };
  }

  factory Subscriber.fromMap(Map<String, dynamic> map) {
    return Subscriber(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      registrationDate: DateTime.parse(map['registrationDate']),
      monthlyFee: map['monthlyFee'],
      subscriptions: (map['subscriptions'] as List?)
              ?.map((s) => Subscription.fromMap(s))
              .toList() ??
          [],
      isActive: map['isActive'] ?? true,
    );
  }
}

class Subscription {
  String id;
  String subscriberId;
  DateTime dueDate;
  DateTime? paymentDate;
  double amount;
  bool isPaid;

  Subscription({
    required this.id,
    required this.subscriberId,
    required this.dueDate,
    this.paymentDate,
    required this.amount,
    this.isPaid = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subscriberId': subscriberId,
      'dueDate': dueDate.toIso8601String(),
      'paymentDate': paymentDate?.toIso8601String(),
      'amount': amount,
      'isPaid': isPaid,
    };
  }

  factory Subscription.fromMap(Map<String, dynamic> map) {
    return Subscription(
      id: map['id'],
      subscriberId: map['subscriberId'],
      dueDate: DateTime.parse(map['dueDate']),
      paymentDate: map['paymentDate'] != null
          ? DateTime.parse(map['paymentDate'])
          : null,
      amount: map['amount'],
      isPaid: map['isPaid'] ?? false,
    );
  }
}