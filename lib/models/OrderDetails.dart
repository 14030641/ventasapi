import 'package:ventasapi/models/Orders.dart';
import 'package:ventasapi/models/Products.dart';
import 'package:ventasapi/ventasapi.dart';

class OrderDetails extends ManagedObject<tblOrderDetails>
    implements tblOrderDetails {}

class tblOrderDetails {
  //todos los campos de la tabla
  @primaryKey
  int idDetail;

  @Relate(#fkProduct)
  Products idProduct;

  @Relate(#fkOrder)
  Orders idOrder;

  double price;
  double discount;
  double quantity;
}
