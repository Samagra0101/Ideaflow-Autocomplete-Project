import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Autocomplete Example')),
        body: AutocompleteWidget(),
      ),
    );
  }
}

class AutocompleteWidget extends StatefulWidget {
  @override
  _AutocompleteWidgetState createState() => _AutocompleteWidgetState();
}

class _AutocompleteWidgetState extends State<AutocompleteWidget> {
  List<String> items = [];
  TextEditingController _controller = TextEditingController();

  void addItemToList(String item) {
    if (item.isNotEmpty) {
      setState(() {
        items.add(item);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter text...',
              ),
              onSubmitted: addItemToList,
            ),
            suggestionsCallback: (pattern) async {
              return items
                  .where((item) =>
                  item.toLowerCase().contains(pattern.toLowerCase()))
                  .toList();
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            onSuggestionSelected: (suggestion) {
              _controller.text = suggestion;
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Save the list or perform any other action here.
            _showSaveDialog();
          },
          child: Text('Save List'),
        ),
      ],
    );
  }

  // Show a dialog to confirm saving the list.
  void _showSaveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Save List'),
          content: Text('Do you want to save the list?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform the save action or navigate to another screen to save the list.
                _saveList();
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Save the list to a persistent storage or perform any other required action.
  void _saveList() {
    // Here, we'll just print the list to the console.
    print('List items:');
    for (String item in items) {
      print(item);
    }
  }
}
