import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:ventasapi/helpers/Configuration.dart';
import 'package:ventasapi/ventasapi.dart';

class SignupController extends ResourceController {
  @Operation.post()
  Future<Response> signup() async {
    final String token = _singToken();
    return Response.ok(token);
  }

  String _singToken() {
    final claimSet = JwtClaim(
        issuer: 'PATMServer',
        subject: '2020',
        issuedAt: DateTime.now(),
        maxAge: const Duration(hours: 2));

    const String secret = Properties.jwtSecret;
    return issueJwtHS256(claimSet, secret);
  }
}
