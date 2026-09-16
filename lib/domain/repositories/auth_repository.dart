/// Abstract AuthRepository for user authentication.
/// Prototype uses MockAuthRepository with a fixed local user.
abstract class AuthRepository {
  Future<String> getCurrentUserId();
  Future<bool> isAuthenticated();
  Future<void> signInMockUser({String userId = 'local_user'});
  Future<void> signOut();
}
