import 'package:flutter/material.dart';

class UserInputFormScreen extends StatefulWidget {
  const UserInputFormScreen({super.key});

  @override
  State<UserInputFormScreen> createState() => _UserInputFormScreenState();
}

class _UserInputFormScreenState extends State<UserInputFormScreen> {
  // Global key to uniquely identify the Form widget and allow validation
  final _formKey = GlobalKey<FormState>();
  
  // Controller to retrieve the text from the TextField
  final _nameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _nameController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // Form is valid, process data and show SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Processing Data for ${_nameController.text}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Input Form')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please enter your details below:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              
              // TextField wrapped with Form Field capabilities
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter some text. Field cannot be empty.';
                  }
                  return null; // Null means valid
                },
              ),
              const SizedBox(height: 24),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
