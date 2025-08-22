import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_validate/services/storage_service.dart';
import 'package:form_validate/utils/api.dart';
import 'package:get/get.dart';
import 'package:form_validate/components/drawer.dart';
import 'package:http/http.dart' as http;
import '../controllers/auth_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController authController = Get.find<AuthController>();
  final StorageService _storageService = StorageService();

  List<Transaction> transactions = [];

  Future<List<Transaction>> _getAllTransaction() async {
    // Simulate a network call to fetch transactions
    await _storageService.init();

    final token = _storageService.getToken();
    final serviceUrl = '$BASE_URL$TRANSACTION_ENDPOINT';

    try {
      var response = await http.get(
        Uri.parse(serviceUrl),
        headers: {
          'Content-Type': 'application/json',
          "app_version": "1.2.0",
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        debugPrint('Failed to load transactions: ${response.reasonPhrase}');
        throw Exception('Failed to load transactions');
      } else {
        final json = jsonDecode(response.body);

        final list = json['data'] as List<dynamic>;

        transactions = list
            .map((item) => Transaction.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      return transactions;
    } catch (e) {
      debugPrint('Error fetching transactions: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      drawer: AppDrawer(),
      body: Obx(() {
        final user = authController.currentUser;

        return FutureBuilder(
          future: _getAllTransaction(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(transactions[index].name),
                    subtitle: Text(transactions[index].desc),
                    trailing: Text(
                      transactions[index].amount.toString(),
                      style: TextStyle(
                        fontSize: 24,
                        color: transactions[index].type == 1
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  );
                },
              );
            }
          },
        );
      }),
    );
  }
}

class Transaction {
  final String uuid;
  final String wallet;
  final String name;
  final String desc;
  final int amount;
  final int type;
  final String date;
  final String createdAt;
  final String updatedAt;

  Transaction({
    required this.uuid,
    required this.wallet,
    required this.name,
    required this.desc,
    required this.amount,
    required this.type,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      uuid: json['uuid'] ?? '',
      wallet: json['wallet'] ?? '',
      name: json['name'] ?? '',
      desc: json['desc'] ?? '',
      amount: json['amount'] ?? 0,
      type: json['type'] ?? 0,
      date: json['date'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
