class CoffeItem {
  String? title;
  String? description;
  String? url;
  bool isFavorite;

  CoffeItem({
    required this.title,
    required this.description,
    required this.url,
    this.isFavorite = false,
  });
}
