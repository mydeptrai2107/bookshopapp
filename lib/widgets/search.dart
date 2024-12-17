import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.sort),
            ),
          ),
        ],
      ),
      body: ListView(children: [
        const ListTile(
          title: Text(
            "Items",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.pink),
          ),
        ),
        Container(
          height: 52,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.blueGrey,
              filled: true,
              hintText: "Search Book in the Store",
              suffixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ]),
    );
  }
}
