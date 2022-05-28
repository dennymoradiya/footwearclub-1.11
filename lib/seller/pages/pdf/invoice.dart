class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  // final String name;
  final String number;
  final String date;
  final String orderid;
  // final DateTime dueDate;

  const InvoiceInfo({
    // required this.name,
    required this.orderid,
    required this.number,
    required this.date,
    // required this.dueDate,
  });
}

class InvoiceItem {
  final String name;
  final String date;
  final int quantity;
  // final double vat;
  final double unitPrice;

  const InvoiceItem({
    required this.name,
    required this.date,
    required this.quantity,
    required this.unitPrice,
  });
}

class Customer {
  final String name;
  final String address;
  final String phone;

  const Customer({
    required this.name,
    required this.address,
    required this.phone,
  });
}

class Supplier {
  final String name;
  // final String address;
  final String paymentInfo;

  const Supplier({
    required this.name,
    // required this.address,
    required this.paymentInfo,
  });
}
