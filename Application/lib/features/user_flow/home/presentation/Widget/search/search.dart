import 'package:flutter/material.dart';
import 'search_results_widgets.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Search()),
          );
        },
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              hintText: "Search...",
              hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 14.0),
              filled: true,
              fillColor:
                  Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 14.0),
          ),
        ),
      ),
    );
  }
}
