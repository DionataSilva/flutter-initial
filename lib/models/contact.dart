class Contact {

  final int id;
  final String fullName;
  final int accountNumber;

  Contact(
    this.id,
    this.fullName,
    this.accountNumber,
  );

  @override
  String toString() {
    return 'Contact{id: $id, fullName: $fullName, accountNumber: $accountNumber}';
  }
}
