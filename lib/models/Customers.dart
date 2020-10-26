import 'package:ventasapi/models/Orders.dart';
import 'package:ventasapi/ventasapi.dart';

class Customers extends ManagedObject<tblCustomers> implements tblCustomers {}

class tblCustomers {
  //todos los campos de la tabla
  @primaryKey
  int idCustomer;

  String nameCustomer;
  String addCustomer;
  @Column(unique: true)
  String emailCustomer;
  String phoneCustomer;

  ManagedSet<Orders> fkCustomer;
}
