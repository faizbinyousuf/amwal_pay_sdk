import 'package:amwal_pay_sdk/core/ui/transactiondialog/transaction.dart';
import 'package:amwal_pay_sdk/core/ui/transactiondialog/transaction_dialog_action_buttons.dart';
import 'package:flutter/material.dart';

class TransactionDetailsSettings {
  final String transactionDisplayName;
  final TransactionStatus transactionStatus;
  final String transactionType;
  final Map<String, dynamic>? details;
  final num? dueAmount;
  final bool? isRefunded;
  final bool? isCaptured;
  final bool? isSettled;
  final void Function()? onClose;
  final bool isTransactionDetails;
  final String Function(String)? globalTranslator;
  final Locale locale;
  final NullableVoidCallback onCapture;
  final NullableVoidCallback onRefund;
  final NullableVoidCallback onVoid;
  final bool canRefund;
  final bool canVoid;
  final bool canCapture;
  final bool isSuccess;
  final num amount;
  final String? currency;
  final String? transactionId;

  const TransactionDetailsSettings({
    required this.transactionDisplayName,
    required this.isTransactionDetails,
    required this.transactionStatus,
    required this.transactionType,
    required this.isSuccess,
    this.transactionId,
    this.dueAmount,
    this.locale = const Locale('en'),
    this.globalTranslator,
    this.isRefunded,
    this.isCaptured,
    this.isSettled,
    this.onCapture,
    this.onRefund,
    this.details,
    this.onClose,
    this.onVoid,
    this.canCapture = false,
    this.canRefund = false,
    this.canVoid = false,
    required this.amount,
    this.currency,
  });

  TransactionDetailsSettings copyWith({
    TransactionStatus? transactionStatus,
    String? transactionType,
    Map<String, dynamic>? details,
    bool? isRefunded,
    bool? isCaptured,
    bool? isSettled,
    void Function()? onClose,
    bool? isTransactionDetails,
    String Function(String)? globalTranslator,
    String? currency,
    String? transactionId,
  }) {
    return TransactionDetailsSettings(
      transactionDisplayName: transactionDisplayName,
      transactionStatus: transactionStatus ?? this.transactionStatus,
      transactionType: transactionType ?? this.transactionType,
      details: details ?? this.details,
      isRefunded: isRefunded ?? this.isRefunded,
      isCaptured: isCaptured ?? this.isCaptured,
      isSettled: isSettled ?? this.isSettled,
      onClose: onClose ?? this.onClose,
      isTransactionDetails: isTransactionDetails ?? this.isTransactionDetails,
      globalTranslator: globalTranslator ?? this.globalTranslator,
      isSuccess: isSuccess,
      locale: locale,
      canCapture: canCapture,
      canRefund: canRefund,
      canVoid: canVoid,
      dueAmount: dueAmount,
      onCapture: onCapture,
      onRefund: onRefund,
      onVoid: onVoid,
      amount: amount,
      currency: currency ?? this.currency,
      transactionId: transactionId,
    );
  }
}
