import 'package:ventasapi/models/Products.dart';
import 'package:ventasapi/ventasapi.dart';

class ProductsController extends ResourceController {
  ProductsController(this.context);
  final ManagedContext context;

//Get de todos los objetos
  @Operation.get()
  Future<Response> getAllProducts() async {
    final productsQuery = Query<Products>(context);
    final products = await productsQuery.fetch();
    return Response.ok(products);
  }

//Get de un objeto especifico
  @Operation.get('idproduct')
  Future<Response> getProduct(@Bind.path('idproduct') int idprod) async {
    final productQuery = Query<Products>(context)
      ..where((a) => a.idProduct).equalTo(idprod);
    final product = productQuery.fetchOne();
    return product != null ? Response.ok(product) : Response.notFound();
  }

//Insert
  @Operation.post()
  Future<Response> addProduct() async {
    final product = Products()
      ..read(await request.body.decode(), ignore: ['idproduct']);

    final productQuery = Query<Products>(context)..values = product;
    final addProduct = await productQuery.insert();
    return Response.ok(addProduct);
  }

//Update
  @Operation.put('idproduct')
  Future<Response> updProduct(@Bind.path('idproduct') int idprod) async {
    final product = Products()..read(await request.body.decode());
    final productQuery = Query<Products>(context)
      ..where((a) => a.idProduct).equalTo(idprod)
      ..values = product;
    final updProduct = await productQuery.update();
    return Response.ok(updProduct);
  }

//Delete
  @Operation.delete('idproduct')
  Future<Response> delProduct(@Bind.path('idproduct') int idprod) async {
    final productQuery = Query<Products>(context)
      ..where((a) => a.idProduct).equalTo(idprod);
    final delProduct = await productQuery.delete();
    return Response.ok(delProduct);
  }
}
