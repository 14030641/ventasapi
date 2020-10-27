import 'package:ventasapi/models/Categories.dart';
import 'package:ventasapi/ventasapi.dart';

class CategoriesController extends ResourceController {
  CategoriesController(this.context);
  final ManagedContext context;

//Get de todos los objetos
  @Operation.get()
  Future<Response> getAllCategories() async {
    final categoriesQuery = Query<Categories>(context);
    final category = await categoriesQuery.fetch();
    return Response.ok(category);
  }

//Get de un objeto especifico
  @Operation.get('idcategory')
  Future<Response> getCategory(@Bind.path('idcategory') int idcateg) async {
    final categoriesQuery = Query<Categories>(context)
      ..where((a) => a.idCategory).equalTo(idcateg);
    final category = categoriesQuery.fetchOne();
    return category != null ? Response.ok(category) : Response.notFound();
  }

//Insert
  @Operation.post()
  Future<Response> addCategory() async {
    final category = Categories()
      ..read(await request.body.decode(), ignore: ['idcategory']);

    final categoriesQuery = Query<Categories>(context)..values = category;
    final addCategory = await categoriesQuery.insert();
    return Response.ok(addCategory);
  }

//Update
  @Operation.put('idcategory')
  Future<Response> updCategory(@Bind.path('idcategory') int idcateg) async {
    final category = Categories()..read(await request.body.decode());
    final categoriesQuery = Query<Categories>(context)
      ..where((a) => a.idCategory).equalTo(idcateg)
      ..values = category;
    final updCategory = await categoriesQuery.update();
    return Response.ok(updCategory);
  }

//Delete
  @Operation.delete('idcategory')
  Future<Response> delCategory(@Bind.path('idcategory') int idcateg) async {
    final categoriesQuery = Query<Categories>(context)
      ..where((a) => a.idCategory).equalTo(idcateg);
    final delCategory = await categoriesQuery.delete();
    return Response.ok(delCategory);
  }
}
