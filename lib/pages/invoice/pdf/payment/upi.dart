class UPIDetails {
  final String upiID;
  final String payeeName;
  final String? transactionID;
  final String? amount;
  final String currencyCode;
  final String? transactionNote;

  UPIDetails(
      {required this.upiID,
      required this.payeeName,
      this.transactionID = "",
      this.amount = "0",
      this.currencyCode = "INR",
      this.transactionNote = ""});

  String get qrCodeValue {
    if (amount == null) {
      return "upi://pay?pa=$upiID&pn=$payeeName&tr=$transactionID&am=0&cu=$currencyCode&mode=01&purpose=10&orgid=-&sign=-&tn=$transactionNote";
    }
    return "upi://pay?pa=$upiID&pn=$payeeName&tr=$transactionID&am=$amount&cu=$currencyCode&mode=01&purpose=10&orgid=-&sign=-&tn=$transactionNote";
  }
}
