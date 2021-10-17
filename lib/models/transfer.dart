class Transfer {
  final int id;
  final int accountNumber;
  final double value;

  Transfer(this.id, this.accountNumber, this.value);

  @override
  String toString() {
    return 'Transfer{id: $id, accountNumber: $accountNumber, value: $value}';
  }
}
