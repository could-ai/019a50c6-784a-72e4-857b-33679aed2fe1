import 'package:flutter/material.dart';
import '../models/subscriber.dart';

class SubscriberForm extends StatefulWidget {
  final Subscriber? subscriber;
  final Function(Subscriber) onSave;

  const SubscriberForm({
    super.key,
    this.subscriber,
    required this.onSave,
  });

  @override
  State<SubscriberForm> createState() => _SubscriberFormState();
}

class _SubscriberFormState extends State<SubscriberForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _feeController;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.subscriber?.name ?? '');
    _emailController = TextEditingController(text: widget.subscriber?.email ?? '');
    _phoneController = TextEditingController(text: widget.subscriber?.phone ?? '');
    _feeController = TextEditingController(text: widget.subscriber?.monthlyFee.toString() ?? '');
    _isActive = widget.subscriber?.isActive ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _feeController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final subscriber = Subscriber(
        id: widget.subscriber?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        registrationDate: widget.subscriber?.registrationDate ?? DateTime.now(),
        monthlyFee: double.parse(_feeController.text),
        subscriptions: widget.subscriber?.subscriptions ?? [],
        isActive: _isActive,
      );
      widget.onSave(subscriber);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subscriber == null ? 'إضافة مشترك جديد' : 'تعديل المشترك'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'الاسم'),
                validator: (value) => value!.isEmpty ? 'يرجى إدخال الاسم' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
                validator: (value) => value!.isEmpty ? 'يرجى إدخال البريد' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'رقم الهاتف'),
                validator: (value) => value!.isEmpty ? 'يرجى إدخال رقم الهاتف' : null,
              ),
              TextFormField(
                controller: _feeController,
                decoration: const InputDecoration(labelText: 'الرسوم الشهرية'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'يرجى إدخال الرسوم' : null,
              ),
              SwitchListTile(
                title: const Text('نشط'),
                value: _isActive,
                onChanged: (value) => setState(() => _isActive = value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _save,
                child: const Text('حفظ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}