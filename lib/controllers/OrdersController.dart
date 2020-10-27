import 'package:ventasapi/models/Orders.dart';
import 'package:ventasapi/ventasapi.dart';

class OrdersController extends ResourceController {
  OrdersController(this.context);
  final ManagedContext context;

//Get de todos los objetos
  @Operation.get()
  Future<Response> getAllOrders() async {
    final orderQuery = Query<Orders>(context);
    final order = await orderQuery.fetch();
    return Response.ok(order);
  }

//Get de un objeto especifico
  @Operation.get('idorder')
  Future<Response> getOrder(@Bind.path('idorder') int idord) async {
    final orderQuery = Query<Orders>(context)
      ..where((a) => a.idOrder).equalTo(idord);
    final order = orderQuery.fetchOne();
    return order != null ? Response.ok(order) : Response.notFound();
  }

//Insert
  @Operation.post()
  Future<Response> addOrder() async {
    final order = Orders()
      ..read(await request.body.decode(), ignore: ['idorder']);

    final orderQuery = Query<Orders>(context)..values = order;
    final addOrder = await orderQuery.insert();
    return Response.ok(addOrder);
  }

//Update
  @Operation.put('idorder')
  Future<Response> updOrder(@Bind.path('idorder') int idord) async {
    final order = Orders()..read(await request.body.decode());
    final orderQuery = Query<Orders>(context)
      ..where((a) => a.idOrder).equalTo(idord)
      ..values = order;
    final updOrder = await orderQuery.update();
    return Response.ok(updOrder);
  }

//Delete
  @Operation.delete('idorder')
  Future<Response> delOrder(@Bind.path('idorder') int idord) async {
    final orderQuery = Query<Orders>(context)
      ..where((a) => a.idOrder).equalTo(idord);
    final delOrder = await orderQuery.delete();
    return Response.ok(delOrder);
  }
}
