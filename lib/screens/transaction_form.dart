import 'package:flutter/material.dart';
import 'dart:convert';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  int _type = -1;
  DateTime? _selectedDate;

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final data = {
        "name": _nameController.text,
        "desc": _descController.text,
        "amount": int.tryParse(_amountController.text) ?? 0,
        "type": _type,
        "date": _selectedDate!.toIso8601String().substring(0, 10),
      };
      final jsonData = jsonEncode(data);
      debugPrint("ส่งข้อมูล: $jsonData");
      // ส่ง jsonData ไป backend ได้ที่นี่
      Navigator.of(context).pop();
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40),
            Text(
              'บันทึกข้อมูลการทำรายการ',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'ชื่อรายการ'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'กรุณากรอกชื่อรายการ' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'รายละเอียด'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'กรุณากรอกรายละเอียด' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'จำนวนเงิน'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value == null || value.isEmpty ? 'กรุณากรอกจำนวนเงิน' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: _type,
              decoration: const InputDecoration(labelText: 'ประเภท'),
              items: const [
                DropdownMenuItem(value: 1, child: Text('รายรับ')),
                DropdownMenuItem(value: -1, child: Text('รายจ่าย')),
              ],
              onChanged: (value) {
                setState(() {
                  _type = value ?? -1;
                });
              },
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'กรุณาเลือกวันที่'
                        : 'วันที่: ${_selectedDate!.toIso8601String().substring(0, 10)}',
                  ),
                ),
                TextButton(
                  onPressed: _pickDate,
                  child: const Text('เลือกวันที่'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('บันทึกข้อมูล'),
            ),
          ],
        ),
      ),
    );
  }
}
