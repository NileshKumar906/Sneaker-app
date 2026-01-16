class Address {
  final String name;
  final String phone;
  final String addressLine;
  final String city;
  final String pincode;

  Address({
    required this.name,
    required this.phone,
    required this.addressLine,
    required this.city,
    required this.pincode,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'addressLine': addressLine,
      'city': city,
      'pincode': pincode,
    };
  }
}
