import 'package:flutter/material.dart';
import '../models/subscriber.dart';
import 'subscriber_form.dart';
import 'subscriber_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Subscriber> subscribers = [
    Subscriber(
      id: '1',
      name: 'أحمد محمد',
      email: 'ahmed@example.com',
      phone: '0123456789',
      registrationDate: DateTime.now().subtract(const Duration(days: 30)),
      monthlyFee: 50.0,
      subscriptions: [
        Subscription(
          id: 's1',
          subscriberId: '1',
          dueDate: DateTime.now().subtract(const Duration(days: 30)),
          amount: 50.0,
          isPaid: true,
          paymentDate: DateTime.now().subtract(const Duration(days: 25)),
        ),
        Subscription(
          id: 's2',
          subscriberId: '1',
          dueDate: DateTime.now(),
          amount: 50.0,
        ),
      ],
    ),
    // يمكن إضافة المزيد من البيانات التجريبية
  ];

  void _addSubscriber(Subscriber subscriber) {
    setState(() {
      subscribers.add(subscriber);
    });
  }

  void _updateSubscriber(Subscriber updatedSubscriber) {
    setState(() {
      final index =
          subscribers.indexWhere((s) => s.id == updatedSubscriber.id);
      if (index != -1) {
        subscribers[index] = updatedSubscriber;
      }
    });
  }

  void _deleteSubscriber(String id) {
    setState(() {
      subscribers.removeWhere((s) => s.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة المشتركين'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubscriberForm(
                    onSave: _addSubscriber,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: subscribers.length,
        itemBuilder: (context, index) {
          final subscriber = subscribers[index];
          return ListTile(
            title: Text(subscriber.name),
            subtitle: Text('البريد: ${subscriber.email} | الهاتف: ${subscriber.phone}'),
            trailing: Text('شهرياً: ${subscriber.monthlyFee}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubscriberDetail(
                    subscriber: subscriber,
                    onUpdate: _updateSubscriber,
                    onDelete: _deleteSubscriber,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}