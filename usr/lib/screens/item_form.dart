import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemForm extends StatefulWidget {
  final Item? item;
  final Function(Item) onSave;

  const ItemForm({
    super.key,
    this.item,
    required this.onSave,
  });

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _wholesalePriceController;
  late TextEditingController _sellingPriceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _wholesalePriceController = TextEditingController(text: widget.item?.wholesalePrice.toString() ?? '');
    _sellingPriceController = TextEditingController(text: widget.item?.sellingPrice.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _wholesalePriceController.dispose();
    _sellingPriceController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final item = Item(
        id: widget.item?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        wholesalePrice: double.parse(_wholesalePriceController.text),
        sellingPrice: double.parse(_sellingPriceController.text),
      );
      widget.onSave(item);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'إضافة مادة جديدة' : 'تعديل المادة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'اسم المادة'),
                validator: (value) => value!.isEmpty ? 'يرجى إدخال اسم المادة' : null,
              ),
              TextFormField(
                controller: _wholesalePriceController,
                decoration: const InputDecoration(labelText: 'سعر الجملة'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'يرجى إدخال سعر الجملة' : null,
              ),
              TextFormField(
                controller: _sellingPriceController,
                decoration: const InputDecoration(labelText: 'سعر البيع'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'يرجى إدخال سعر البيع' : null,
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
