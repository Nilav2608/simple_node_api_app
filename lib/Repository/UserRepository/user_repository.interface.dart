abstract class IUserRepository {
  Future registerUser(String email, String password);
  Future loginWithEmailAndPawword(String email, String password);
}
