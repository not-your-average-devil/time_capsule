import 'package:flutter/material.dart';
import 'package:time_capsule/utils/colors.dart';
import 'package:http/http.dart' as http;

class CapsulePage extends StatefulWidget {
  // constructor function, whenever CapsulePage is written this constructor is called
  const CapsulePage({super.key});

  // overiding createState() method from StatefulWidget
  @override
  // State<CapsulePage> is the return type
  State<CapsulePage> createState() => _CapsulePage();
}

class _CapsulePage extends State<CapsulePage> {
  final TextEditingController _dateController = TextEditingController();
  // final -> cannot change
  // TextEditingController -> read value, set value (value - textfeild value)
  // _ -> private (only can be accessed in this dart file)
  // messageController -> name of variable
  // TextEditingController() -> creating a new instance of the controller
  final TextEditingController _messageController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _dateController.text = ''; // empty at start
  }

  @override
  void dispose() {
    _dateController.dispose();
    // clears resources used by _messageController
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitCapsule() async {
    final message = _messageController.text.trim();
    final date = _selectedDate;

    if (message.isEmpty || date == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both message and date")),
      );
      return;
    }

    final url = Uri.parse(
      'http://10.0.2.2:3000/capsules',
    ); // change this to your backend URL

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body:
          '{"message": "$message", "unlockDate": "${date.toIso8601String()}"}',
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Time Capsule Created!")));
      _messageController.clear();
      _dateController.clear();
      setState(() => _selectedDate = null);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed: ${response.statusCode}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Create your Capsule'),
        backgroundColor: AppColors.secondary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              // binding _messageController to the value of the text field
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Write a message to your future self',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Date Picker Field
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                    _dateController.text =
                        '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    hintText: 'Select a date to unlock',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _submitCapsule,
                child: const Text(
                  'Create Time Capsule',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
