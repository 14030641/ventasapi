import 'package:ventasapi/models/OrderDetails.dart';
import 'package:ventasapi/ventasapi.dart';

class OrderDetailsController extends ResourceController {
  OrderDetailsController(this.context);
  final ManagedContext context;

//Get de todos los objetos
  @Operation.get()
  Future<Response> getAllDetails() async {
    final detailQuery = Query<OrderDetails>(context);
    final detail = await detailQuery.fetch();
    return Response.ok(detail);
  }

//Get de un objeto especifico
  @Operation.get('iddetail')
  Future<Response> getDetail(@Bind.path('iddetail') int iddeta) async {
    final detailQuery = Query<OrderDetails>(context)
      ..where((a) => a.idDetail).equalTo(iddeta);
    final detail = detailQuery.fetchOne();
    return detail != null ? Response.ok(detail) : Response.notFound();
  }

//Insert
  @Operation.post()
  Future<Response> addDetail() async {
    final detail = OrderDetails()
      ..read(await request.body.decode(), ignore: ['iddetail']);

    final detailQuery = Query<OrderDetails>(context)..values = detail;
    final addDetail = await detailQuery.insert();
    return Response.ok(addDetail);
  }

//Update
  @Operation.put('iddetail')
  Future<Response> updDetail(@Bind.path('iddetail') int iddeta) async {
    final detail = OrderDetails()..read(await request.body.decode());
    final detailQuery = Query<OrderDetails>(context)
      ..where((a) => a.idDetail).equalTo(iddeta)
      ..values = detail;
    final updDetail = await detailQuery.update();
    return Response.ok(updDetail);
  }

//Delete
  @Operation.delete('iddetail')
  Future<Response> delDetail(@Bind.path('iddetail') int iddeta) async {
    final detailQuery = Query<OrderDetails>(context)
      ..where((a) => a.idDetail).equalTo(iddeta);
    final delDetail = await detailQuery.delete();
    return Response.ok(delDetail);
  }
}
