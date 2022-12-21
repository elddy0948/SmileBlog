import Foundation

protocol UsersRepository {
  func create(user: User, completion: @escaping (Result<User, Error>) -> Void)
  func fetchUser(userID: String, completion: @escaping (Result<User, Error>) -> Void)
  func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
  func fetchUserPosts(userID: String, completion: @escaping (Result<[Post], Error>) -> Void)
  func searchUser(username: String, completion: @escaping (Result<User, Error>) -> Void)
}
