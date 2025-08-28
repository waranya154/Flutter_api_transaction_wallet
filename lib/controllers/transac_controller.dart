import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/transaction.dart';

class TransactionController extends GetxController {
  // สถานะรายการธุรกรรมทั้งหมด
  final RxList<TransactionData> transactions = <TransactionData>[].obs;

  // เพิ่มรายการใหม่
  void addTransaction(TransactionData transaction) {
    transactions.add(transaction);
  }

  // ลบรายการตาม uuid
  void removeTransaction(String uuid) {
    transactions.removeWhere((item) => item.uuid == uuid);
  }

  // อัปเดตรายการ
  void updateTransaction(TransactionData transaction) {
    final index = transactions.indexWhere(
      (item) => item.uuid == transaction.uuid,
    );
    debugPrint('Update transaction at index: $index');
    if (index != -1) {
      transactions[index] = transaction;
    }
  }

  // โหลดรายการใหม่ทั้งหมด
  void setTransactions(List<TransactionData> list) {
    transactions.value = list;
  }

  // ดึงข้อมูลธุรกรรมจาก uuid
  TransactionData? getTransactionByUuid(String uuid) {
    try {
      return transactions.firstWhere((item) => item.uuid == uuid);
    } catch (e) {
      debugPrint('Transaction not found for uuid: $uuid');
      return null;
    }
  }

  // ดึง index ของธุรกรรมจาก uuid
  int getIndexByUuid(String uuid) {
    return transactions.indexWhere((item) => item.uuid == uuid);
  }

  // ดึงข้อมูลธุรกรรมด้วย index
  TransactionData? getTransactionByIndex(int index) {
    if (index >= 0 && index < transactions.length) {
      return transactions[index];
    }
    return null;
  }

  // ฟังก์ชันคำนวณยอดรวมรายรับ (type == 1)
  int getTotalIncome() {
    return transactions
        .where((item) => item.type == 1)
        .fold(0, (sum, item) => sum + item.amount);
  }

  // ฟังก์ชันคำนวณยอดรวมรายจ่าย (type == 2 หรือ type == -1)
  int getTotalExpense() {
    return transactions
        .where((item) => item.type == 2 || item.type == -1)
        .fold(0, (sum, item) => sum + item.amount);
  }
}
