abstract class UserRepository {}

class UserRepositoryImpl implements UserRepository {
  Future<void> initializeUserAuthData(
      String token, Map<String, dynamic> payloadData) async {}
}
