import 'package:ventasapi/models/Categories.dart';
import 'package:ventasapi/models/OrderDetails.dart';
import 'package:ventasapi/ventasapi.dart';

class Products extends ManagedObject<tblProducts> implements tblProducts {}

class tblProducts {
  //todos los campos de la tabla
  @primaryKey
  int idProduct;

  @Column(unique: true)
  String nameProduct;

  double price;
  int stock;
  bool discontinued;

  @Relate(#fkcategory)
  Categories idCategory;

  ManagedSet<OrderDetails> fkProduct;
}
