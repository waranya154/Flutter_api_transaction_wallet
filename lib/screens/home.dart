import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_validate/services/storage_service.dart';
import 'package:form_validate/utils/api.dart';
import 'package:get/get.dart';
import 'package:form_validate/components/drawer.dart';
import 'package:http/http.dart' as http;

import '../components/transaction_card.dart';
import '../controllers/auth_controller.dart';
import '../controllers/transac_controller.dart';
import '../model/transaction.dart';
import 'transaction_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController authController = Get.find<AuthController>();
  final StorageService _storageService = StorageService();

  // ใช้งาน TransactionController แทน RxList
  final TransactionController transactionController = Get.put(
    TransactionController(),
  );

  Future<List<TransactionData>> _getAllTransaction() async {
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
        transactionController.setTransactions(
          list
              .map(
                (item) =>
                    TransactionData.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
        );
      }

      return transactionController.transactions;
    } catch (e) {
      debugPrint('Error fetching transactions: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet_rounded, color: Colors.blue[700]),
            const SizedBox(width: 8),
            Text(
              'TangJa',
              style: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.blue[700]),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder<List<TransactionData>>(
        future: _getAllTransaction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Obx(
              () => transactionController.transactions.isEmpty
                  ? Center(
                      child: Text(
                        'ยังไม่มีรายการธุรกรรม',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 18,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      itemCount: transactionController.transactions.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(16),
                          child: TransacCard(
                            transaction: transactionController.transactions[index],
                          ),
                        );
                      },
                    ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[700],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.8,
                minChildSize: 0.5,
                maxChildSize: 1.0,
                builder: (context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          controller: scrollController,
                          child: TransactionForm(),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: const Icon(Icons.close, size: 28),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
