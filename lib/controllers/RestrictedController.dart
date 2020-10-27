import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:ventasapi/helpers/Configuration.dart';
import 'package:ventasapi/ventasapi.dart';

class RestrictedController extends ResourceController {
  @Operation.get()
  Future<Response> restricted(
      @Bind.header("Authorization") String authHeader) async {
    if (!_isAuthorized(authHeader)) {
      return Response.forbidden();
    }

    return Response.ok('Aquí se mostrara el resultado de su petición.');
  }

  bool _isAuthorized(String authHeader) {
    final parts = authHeader.split(' ');
    if (parts == null || parts.length != 2 || parts[0] != 'Bearer') {
      return false;
    }
    return _isValidToken(parts[1]);
  }

  bool _isValidToken(String token) {
    const key = Properties.jwtSecret;
    try {
      verifyJwtHS256Signature(token, key);
      return true;
    } on JwtException {
      print('Invalid Token');
    }
    return false;
  }
}
