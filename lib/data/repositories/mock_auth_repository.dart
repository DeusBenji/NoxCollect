import '../../domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  String _currentUserId = 'local_user';
  bool _signedIn = true;

  @override
  Future<String> getCurrentUserId() async => _currentUserId;

  @override
  Future<bool> isAuthenticated() async => _signedIn;

  @override
  Future<void> signInMockUser({String userId = 'local_user'}) async {
    _currentUserId = userId;
    _signedIn = true;
  }

  @override
  Future<void> signOut() async {
    _signedIn = false;
  }
}
