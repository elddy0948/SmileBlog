import Foundation

final class NetworkUsersRepository: UsersRepository {
  func create(user: User, completion: @escaping (Result<User, Error>) -> Void) {
    let userToCreate = UserRequestDTO(username: user.username)
    NetworkService.create(
      encodableData: userToCreate,
      endPoint: "/api/users/",
      completion: { (result: Result<UserResponseDTO, NetworkError>) in
        switch result {
        case .success(let userResponse):
          let user = userResponse.toDomain()
          completion(.success(user))
        case .failure(let error):
          completion(.failure(error))
        }
      })
  }
  
  func fetchUser(userID: String, completion: @escaping (Result<User, Error>) -> Void) {
    NetworkService.fetch(
      endPoint: "/api/users/\(userID)",
      completion: { (result: Result<UserResponseDTO, NetworkError>) in
        switch result {
        case .success(let userResponse):
          let user = userResponse.toDomain()
          completion(.success(user))
          return
        case .failure(let error):
          completion(.failure(error))
          return
        }
      })
  }
  
  func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
    NetworkService.fetch(
      endPoint: "/api/users/",
      completion: { (result: Result<[UserResponseDTO], NetworkError>) in
        switch result {
        case .success(let userResponses):
          let users = userResponses.map({ $0.toDomain() })
          completion(.success(users))
          return
        case .failure(let error):
          completion(.failure(error))
          return
        }
      })
  }
  
  func fetchUserPosts(userID: String, completion: @escaping (Result<[Post], Error>) -> Void) {
    NetworkService.fetch(
      endPoint: "/api/users/\(userID)/posts",
      completion: { (result: Result<[PostResponseDTO], NetworkError>) in
        switch result {
        case .success(let postResponses):
          let posts = postResponses.map({ $0.toDomain() })
          completion(.success(posts))
          return
        case .failure(let error):
          completion(.failure(error))
          return
        }
      })
  }
}
