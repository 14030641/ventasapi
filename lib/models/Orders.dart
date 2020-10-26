import 'package:ventasapi/models/Customers.dart';
import 'package:ventasapi/models/OrderDetails.dart';
import 'package:ventasapi/ventasapi.dart';

class Orders extends ManagedObject<tblOrders> implements tblOrders {}

class tblOrders {
  //todos los campos de la tabla
  @primaryKey
  int idOrder;

  @Column(indexed: true)
  DateTime dateOrder;
  @Column(indexed: true)
  DateTime shippedDate;

  @Relate(#fkCustomer)
  Customers idCustomer;

  ManagedSet<OrderDetails> fkOrder;
}
