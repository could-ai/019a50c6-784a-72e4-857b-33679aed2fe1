import 'package:flutter/material.dart';
import '../models/item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> items = [
    Item(
      id: '1',
      name: 'هاتف ذكي سامسونج',
      wholesalePrice: 500.0,
      sellingPrice: 700.0,
    ),
    Item(
      id: '2',
      name: 'لابتوب أسوس',
      wholesalePrice: 800.0,
      sellingPrice: 1000.0,
    ),
    Item(
      id: '3',
      name: 'سماعات بلوتوث',
      wholesalePrice: 50.0,
      sellingPrice: 80.0,
    ),
    Item(
      id: '4',
      name: 'شاشة كمبيوتر',
      wholesalePrice: 200.0,
      sellingPrice: 250.0,
    ),
    Item(
      id: '5',
      name: 'ماوس لاسلكي',
      wholesalePrice: 20.0,
      sellingPrice: 30.0,
    ),
    Item(
      id: '6',
      name: 'كيبورد ميكانيكي',
      wholesalePrice: 100.0,
      sellingPrice: 150.0,
    ),
    // يمكن إضافة المزيد من المنتجات التجريبية
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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('كتالوج المنتجات'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'البحث عن المنتج',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // عدد الأعمدة في الشبكة
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.75, // نسبة العرض إلى الارتفاع للبطاقات
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // صورة افتراضية (يمكن استبدالها بصور حقيقية لاحقاً)
                      Container(
                        height: 120.0,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          color: Colors.grey[300],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.image,
                            size: 50.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              'سعر البيع: ${item.sellingPrice} ريال',
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              'سعر الجملة: ${item.wholesalePrice} ريال',
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
