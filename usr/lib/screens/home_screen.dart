import 'package:flutter/material.dart';
import '../models/item.dart';
import 'item_form.dart';
import 'item_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> items = [
    Item(
      id: '1',
      name: 'مادة تجريبية 1',
      wholesalePrice: 10.0,
      sellingPrice: 15.0,
    ),
    Item(
      id: '2',
      name: 'مادة تجريبية 2',
      wholesalePrice: 20.0,
      sellingPrice: 25.0,
    ),
    // يمكن إضافة المزيد من البيانات التجريبية
  ];

  List<Item> filteredItems = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = items;
    searchController.addListener(_filterItems);
  }

  void _filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = items.where((item) => item.name.toLowerCase().contains(query)).toList();
    });
  }

  void _addItem(Item item) {
    setState(() {
      items.add(item);
      _filterItems();
    });
  }

  void _updateItem(Item updatedItem) {
    setState(() {
      final index = items.indexWhere((i) => i.id == updatedItem.id);
      if (index != -1) {
        items[index] = updatedItem;
        _filterItems();
      }
    });
  }

  void _deleteItem(String id) {
    setState(() {
      items.removeWhere((i) => i.id == id);
      _filterItems();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة المواد'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemForm(
                    onSave: _addItem,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'البحث عن المادة',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('سعر الجملة: ${item.wholesalePrice} | سعر البيع: ${item.sellingPrice}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetail(
                          item: item,
                          onUpdate: _updateItem,
                          onDelete: _deleteItem,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
