import 'package:flutter/material.dart';

class Filters extends StatefulWidget {
  final Function(String) onFilterChanged;

  const Filters({super.key, required this.onFilterChanged});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  String _selectedFilter = 'All';

  void _changeFilter(String value) {
    setState(() {
      _selectedFilter = value;
    });
    widget.onFilterChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // النص "Filter"
          const Text(
            'Filter',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          //const SizedBox(width: 4), // مسافة بين النص والأيقونة
          // زر الفلترة باستخدام الأيقونة
          GestureDetector(
            onTap: () {
              // عند النقر على الأيقونة، يتم تغيير الفلتر إلى القيمة المحددة
              _changeFilter(
                  'All'); // يمكنك تغيير القيمة هنا إذا كنت تريد قيمة أخرى
            },
            child: const Icon(Icons.filter_list, color: Colors.black),
          ),
          const SizedBox(width: 8), // مسافة بين الأيقونة والقائمة المنسدلة
          // القائمة المنسدلة للفلترة
          DropdownButton<String>(
            value: _selectedFilter,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 4,
            underline: Container(height: 2, color: Colors.grey),
            items: ['All', 'Complete', 'Refund', 'Rejected']
                .map((filter) => DropdownMenuItem(
                      value: filter,
                      child: Text(filter),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                _changeFilter(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
