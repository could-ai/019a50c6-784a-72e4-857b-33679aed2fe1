import 'package:flutter/material.dart';
import '../models/item.dart';
import 'item_form.dart';

class ItemDetail extends StatefulWidget {
  final Item item;
  final Function(Item) onUpdate;
  final Function(String) onDelete;

  const ItemDetail({
    super.key,
    required this.item,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  late Item _item;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_item.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemForm(
                    item: _item,
                    onSave: widget.onUpdate,
                  ),
                ),
              );
              if (result != null) {
                setState(() {
                  _item = result;
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('تأكيد الحذف'),
                  content: const Text('هل تريد حذف هذه المادة؟'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إلغاء'),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.onDelete(_item.id);
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
            Text('اسم المادة: ${_item.name}', style: const TextStyle(fontSize: 18)),
            Text('سعر الجملة: ${_item.wholesalePrice}'),
            Text('سعر البيع: ${_item.sellingPrice}'),
          ],
        ),
      ),
    );
  }
}
