import Foundation

final class DefaultUsersUseCase {
  private let usersRepository: UsersRepository
  
  init(usersRepository: UsersRepository) {
    self.usersRepository = usersRepository
  }
  
  func create(user: User, completion: @escaping (Result<User, Error>) -> Void) {
    self.usersRepository.create(user: user, completion: { result in
      switch result {
      case .success(let user):
        completion(.success(user))
      case .failure(let error):
        completion(.failure(error))
      }
    })
  }
  
  func fetchUser(userID: String, completion: @escaping (Result<User, Error>) -> Void) {
    self.usersRepository.fetchUser(userID: userID, completion: { result in
      switch result {
      case .success(let user):
        completion(.success(user))
      case .failure(let error):
        completion(.failure(error))
      }
    })
  }
  
  func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
    self.usersRepository.fetchUsers(completion: { result in
      switch result {
      case .success(let users):
        completion(.success(users))
      case .failure(let error):
        completion(.failure(error))
      }
    })
  }
  
  func fetchUserPosts(userID: String, completion: @escaping (Result<[Post], Error>) -> Void) {
    self.usersRepository.fetchUserPosts(userID: userID, completion: { result in
      switch result {
      case .success(let posts):
        completion(.success(posts))
      case .failure(let error):
        completion(.failure(error))
      }
    })
  }
  
  func searchUser(username: String, completion: @escaping (Result<User, Error>) -> Void) {
    self.usersRepository.searchUser(username: username, completion: { result in
      switch result {
      case .success(let user):
        completion(.success(user))
      case .failure(let error):
        completion(.failure(error))
      }
    })
  }
}
