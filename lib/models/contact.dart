class Contact {
  final String fullName;
  final int accountNumber;

  Contact(this.accountNumber, this.fullName);

  @override
  String toString() {
    return 'Contact{fullName: $fullName, accountNumber: $accountNumber}';
  }
}
