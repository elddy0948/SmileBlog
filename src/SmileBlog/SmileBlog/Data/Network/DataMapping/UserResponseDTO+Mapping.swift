import Foundation

struct UserResponseDTO: Decodable {
  let id: UUID?
  let username: String
}

extension UserResponseDTO {
  func toDomain() -> User {
    return User(
      id: self.id,
      username: self.username)
  }
}
