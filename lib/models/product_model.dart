class ProductModel {
  final String id, title, imageUrl, category;
  final double price, salePrice;
  final bool isOnSale, isPiece;

  ProductModel(this.id, this.title, this.imageUrl, this.category, this.price,
      this.salePrice, this.isOnSale, this.isPiece);
}
