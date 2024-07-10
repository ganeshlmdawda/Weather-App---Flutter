import 'package:flutter/material.dart';

class CitySearchBar extends StatelessWidget {
  final Function(String) onSearch;

  CitySearchBar({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: 'Enter city',
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            onSearch(_controller.text);
          },
        ),
      ),
    );
  }
}
