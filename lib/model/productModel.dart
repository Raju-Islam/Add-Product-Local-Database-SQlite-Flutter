// ignore_for_file: file_names, prefer_const_declarations, non_constant_identifier_names, unused_label

final String TABLE_PRODUCT = 'tbl_product';
final String COL_PRODUCT_ID = 'pro_id';
final String COL_PRODUCT_NAME = 'pro_name';
final String COL_PRODUCT_PRICE = 'pro_price';
final String COL_PRODUCT_CATGORY = 'pro_catgory';
final String COL_PRODUCT_DATE = 'pro_date';
final String COL_PRODUCT_IMAGE = 'pro_image';
final String COL_PRODUCT_FAVORITE = 'pro_favorite';

class Product {
  int? id;
  String? name;
  double? price;
  String? catgory;
  String? date;
  String? imagePath;
  bool? isFavorite;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      COL_PRODUCT_NAME: name,
      COL_PRODUCT_PRICE: price,
      COL_PRODUCT_CATGORY: catgory,
      COL_PRODUCT_DATE: date,
      COL_PRODUCT_IMAGE: imagePath,
      COL_PRODUCT_FAVORITE: isFavorite! ? 1 : 0,
    };

    if (id != null) {
      map[COL_PRODUCT_ID] = id;
    }
    return map;
  }

  Product.fromMap(Map<String, dynamic> map) {
    id = map[COL_PRODUCT_ID];
    name = map[COL_PRODUCT_NAME];
    price = map[COL_PRODUCT_PRICE];
    catgory = map[COL_PRODUCT_CATGORY];
    date = map[COL_PRODUCT_DATE];
    imagePath = map[COL_PRODUCT_IMAGE];
    isFavorite = map[COL_PRODUCT_FAVORITE] == 0 ? false : true;
  }
  Product(e,
      {this.id,
      this.name,
      this.price,
      this.catgory,
      this.date,
      this.imagePath,
      this.isFavorite=false
      });

  @override
  String toString() {
    return 'Product{id: $id,name:$name,prize:$price,catgory:$catgory,date:$date,imagePath:$imagePath,isFavorite:$isFavorite}';
  }
}
