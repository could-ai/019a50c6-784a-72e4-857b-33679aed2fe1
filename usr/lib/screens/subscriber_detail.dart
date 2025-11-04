import 'package:flutter/material.dart';
import '../models/subscriber.dart';
import 'subscriber_form.dart';

class SubscriberDetail extends StatefulWidget {
  final Subscriber subscriber;
  final Function(Subscriber) onUpdate;
  final Function(String) onDelete;

  const SubscriberDetail({
    super.key,
    required this.subscriber,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  State<SubscriberDetail> createState() => _SubscriberDetailState();
}

class _SubscriberDetailState extends State<SubscriberDetail> {
  late Subscriber _subscriber;

  @override
  void initState() {
    super.initState();
    _subscriber = widget.subscriber;
  }

  void _markAsPaid(int index) {
    setState(() {
      _subscriber.subscriptions[index].isPaid = true;
      _subscriber.subscriptions[index].paymentDate = DateTime.now();
    });
    widget.onUpdate(_subscriber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_subscriber.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubscriberForm(
                    subscriber: _subscriber,
                    onSave: widget.onUpdate,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('تأكيد الحذف'),
                  content: const Text('هل تريد حذف هذا المشترك؟'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إلغاء'),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.onDelete(_subscriber.id);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('حذف'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الاسم: ${_subscriber.name}', style: const TextStyle(fontSize: 18)),
            Text('البريد: ${_subscriber.email}'),
            Text('الهاتف: ${_subscriber.phone}'),
            Text('تاريخ التسجيل: ${_subscriber.registrationDate.toString().split(' ')[0]}'),
            Text('الرسوم الشهرية: ${_subscriber.monthlyFee}'),
            Text('الحالة: ${_subscriber.isActive ? 'نشط' : 'غير نشط'}'),
            const SizedBox(height: 20),
            const Text('الاشتراكات:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _subscriber.subscriptions.length,
                itemBuilder: (context, index) {
                  final sub = _subscriber.subscriptions[index];
                  return ListTile(
                    title: Text('تاريخ الاستحقاق: ${sub.dueDate.toString().split(' ')[0]}'),
                    subtitle: Text('المبلغ: ${sub.amount} | ${sub.isPaid ? 'مدفوع' : 'غير مدفوع'}'),
                    trailing: !sub.isPaid
                        ? ElevatedButton(
                            onPressed: () => _markAsPaid(index),
                            child: const Text('دفع'),
                          )
                        : const Icon(Icons.check, color: Colors.green),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
