class SalaryPayment {
  final String id, workerId;
  final DateTime weekStart, weekEnd;
  final double totalAmount, advance, finalAmount;
  final bool paid;
  final DateTime? paidDate;
  const SalaryPayment({required this.id,required this.workerId,required this.weekStart,required this.weekEnd,required this.totalAmount,required this.advance,required this.finalAmount,required this.paid,this.paidDate});
}
