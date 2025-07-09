import 'package:flutter/material.dart';
import 'package:time_capsule/utils/colors.dart';

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
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _dateController.text = ''; // empty at start
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
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
            Padding(padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Create Time Capsule',
                filled: true,
                fillColor: AppColors.primary,
              )
            )
            ),
          ],
        ),
      ),
    );
  }
}
