import 'package:ventasapi/models/Customers.dart';
import 'package:ventasapi/ventasapi.dart';

class CustomersController extends ResourceController {
  CustomersController(this.context);
  final ManagedContext context;

//Get de todos los objetos
  @Operation.get()
  Future<Response> getAllCustomers() async {
    final customerQuery = Query<Customers>(context);
    final customer = await customerQuery.fetch();
    return Response.ok(customer);
  }

//Get de un objeto especifico
  @Operation.get('idCustomer')
  Future<Response> getDetail(@Bind.path('idcustomer') int idcust) async {
    final customerQuery = Query<Customers>(context)
      ..where((a) => a.idCustomer).equalTo(idcust);
    final customer = customerQuery.fetchOne();
    return customer != null ? Response.ok(customer) : Response.notFound();
  }

//Insert
  @Operation.post()
  Future<Response> addCustomer() async {
    final customer = Customers()
      ..read(await request.body.decode(), ignore: ['idcustomer']);

    final customerQuery = Query<Customers>(context)..values = customer;
    final addCustomer = await customerQuery.insert();
    return Response.ok(addCustomer);
  }

//Update
  @Operation.put('idcustomer')
  Future<Response> updCustomer(@Bind.path('idcustomer') int idcust) async {
    final customer = Customers()..read(await request.body.decode());
    final customerQuery = Query<Customers>(context)
      ..where((a) => a.idCustomer).equalTo(idcust)
      ..values = customer;
    final updCustomer = await customerQuery.update();
    return Response.ok(updCustomer);
  }

//Delete
  @Operation.delete('idcustomer')
  Future<Response> delCustomer(@Bind.path('idcustomer') int idcust) async {
    final customerQuery = Query<Customers>(context)
      ..where((a) => a.idCustomer).equalTo(idcust);
    final delCustomer = await customerQuery.delete();
    return Response.ok(delCustomer);
  }
}
