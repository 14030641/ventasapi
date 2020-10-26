import 'package:ventasapi/controllers/CategoriesController.dart';
import 'package:ventasapi/controllers/CustomersController.dart';
import 'package:ventasapi/controllers/OrderDetailsController.dart';
import 'package:ventasapi/controllers/OrdersController.dart';
import 'package:ventasapi/controllers/ProductsController.dart';

import 'ventasapi.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class VentasapiChannel extends ApplicationChannel {
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.

  ///Variable para la conexión a la BD
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore(
        'postgres', 'root', 'localhost', 5432, 'ventas_db');
    context = ManagedContext(dataModel, persistentStore);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
    router
        .route("/products[/:idproduct]")
        .link(() => ProductsController(context));

    router.route("/orders[/:idorder]").link(() => OrdersController(context));

    router
        .route("/orderdetails[/:iddetail]")
        .link(() => OrderDetailsController(context));

    router
        .route("/customers[/:idcustomer]")
        .link(() => CustomersController(context));

    router
        .route("/categories[/:idcategory]")
        .link(() => CategoriesController(context));

    return router;
  }
}
