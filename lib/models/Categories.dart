import 'package:ventasapi/models/Products.dart';
import 'package:ventasapi/ventasapi.dart';

class Categories extends ManagedObject<tblCategories> implements tblCategories {
}

class tblCategories {
  //todos los campos de la tabla
  @primaryKey
  int idCategory;

  @Column(unique: true)
  String nameCategory;

  ManagedSet<Products> fkcategory;
}
