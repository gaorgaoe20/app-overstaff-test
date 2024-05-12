

class Cart {
  final dynamic id;
  late List list;
  late dynamic totalPrice = 0;

  Cart({
    this.id,
    required this.list,
    this.totalPrice
  });

}